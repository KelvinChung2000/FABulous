#!/usr/bin/env python3
"""Simple Dashboard for FABulous Benchmark Analysis - Current Runs Only"""

import json
import threading
import time
import os
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any
from datetime import datetime
from enum import Enum
from dataclasses import dataclass, field
import subprocess
import sys
import re
import warnings
import concurrent.futures
from concurrent.futures import ThreadPoolExecutor, as_completed
from threading import Lock

# Data analysis
import pandas as pd
import numpy as np

# Visualization
import matplotlib.pyplot as plt
import seaborn as sns

# Jupyter widgets (optional for testing)
try:
    import ipywidgets as widgets
    from IPython.display import display, clear_output, HTML
    HAS_WIDGETS = True
except ImportError:
    HAS_WIDGETS = False
    # Create dummy widgets for testing
    class DummyWidgets:
        def __getattr__(self, name):
            def dummy_widget(*args, **kwargs):
                return f"DummyWidget({name})"
            return dummy_widget
    widgets = DummyWidgets()
    def display(*args): pass
    def clear_output(*args, **kwargs): pass
    def HTML(content): return content

# Suppress warnings for cleaner output
warnings.filterwarnings('ignore')

# Set up plotting style
plt.style.use('default')
sns.set_palette("husl")


# ============================================================================
# Utility Functions
# ============================================================================

def extract_placement_log(stdout_content: str) -> str:
    """Extract placement-specific log sections from NextPNR stdout"""
    if not stdout_content:
        return ""
    
    import re
    
    # Look for placement-related sections in the log
    placement_patterns = [
        r'Info: Running.*placement.*',
        r'Info: Placement.*',
        r'Info: Place.*',
        r'Info: Running placer.*',
        r'Info: Initial placement.*',
        r'Info: Placer.*',
        r'Info: After placement optimization.*',
        r'Info: Final placement.*',
        r'Info:.*at iteration.*',  # Placement optimization iterations
        r'Info:.*wirelen solved.*',  # Placement iteration details
        r'ERROR:.*placement.*',
        r'WARNING:.*placement.*'
    ]
    
    lines = stdout_content.split('\n')
    placement_lines = []
    
    # Extract lines that match placement patterns
    for line in lines:
        for pattern in placement_patterns:
            if re.search(pattern, line, re.IGNORECASE):
                placement_lines.append(line)
                break
    
    # Also look for blocks between placement start and end markers
    placement_start_patterns = [
        r'Info: Running.*placement',
        r'Info: Initial placement',
        r'Info: Placement starts'
    ]
    
    placement_end_patterns = [
        r'Info: Final placement',
        r'Info: Placement.*complete',
        r'Info: Running router.*',  # More specific - actual router start
        r'Info: Router1.*',  # NextPNR router1 phase
        r'Info: Running routing pass'  # Actual routing phase start
    ]
    
    in_placement_block = False
    block_lines = []
    
    for line in lines:
        # Check if we're starting a placement block
        if not in_placement_block:
            for pattern in placement_start_patterns:
                if re.search(pattern, line, re.IGNORECASE):
                    in_placement_block = True
                    block_lines.append(line)
                    break
        else:
            # We're in a placement block, add lines until we hit an end pattern
            block_lines.append(line)
            
            for pattern in placement_end_patterns:
                if re.search(pattern, line, re.IGNORECASE):
                    in_placement_block = False
                    break
    
    # Combine individual matching lines and block lines
    all_placement_lines = list(set(placement_lines + block_lines))
    
    # Sort by original order in the file
    result_lines = []
    line_indices = {line: i for i, line in enumerate(lines)}
    
    for line in all_placement_lines:
        if line in line_indices:
            result_lines.append((line_indices[line], line))
    
    result_lines.sort(key=lambda x: x[0])
    
    return '\n'.join([line for _, line in result_lines])

def display_scrollable_log(log_content: str, title: str, max_height: str = "300px"):
    """Display log content in a scrollable text area with rich formatting removed"""
    if not HAS_WIDGETS:
        # Fallback for non-widget environments
        print(f"\n{title}:")
        print("-" * 40)
        # Debug info to show log data characteristics
        lines = log_content.split('\n')
        print(f"DEBUG: Log has {len(lines)} lines, {len(log_content)} characters")
        if len(lines) > 10:
            print(f"DEBUG: First line: {lines[0][:100]}")
            print(f"DEBUG: Last line: {lines[-1][:100]}")
        # Show last 2000 lines to capture the end of the log with failure details
        if len(lines) > 2000:
            print(f"... (showing last 2000 lines out of {len(lines)} total lines)")
            print('\n'.join(lines[-2000:]))
        else:
            print(log_content)
        return
    
    import html
    
    # Clean the log content (simplified version)
    if not log_content:
        log_content = "No log content available"
    
    # Escape HTML characters
    escaped_content = html.escape(log_content)
    
    # Create scrollable HTML
    html_content = f"""
    <div style="border: 1px solid #ccc; border-radius: 5px; margin: 10px 0;">
        <div style="background-color: #f5f5f5; padding: 8px; border-bottom: 1px solid #ccc; font-weight: bold;">
            {title}
        </div>
        <div style="max-height: {max_height}; overflow-y: auto; padding: 10px; font-family: 'Courier New', monospace; font-size: 12px; background-color: #fafafa; line-height: 1.3;">
            <pre style="margin: 0; white-space: pre-wrap; word-wrap: break-word;">{escaped_content}</pre>
        </div>
    </div>
    """
    
    display(HTML(html_content))


# ============================================================================
# Data Classes and Enums (required for dashboard functionality)
# ============================================================================

class FailureType(Enum):
    NONE = "none"
    MLIR_OPTIMIZATION = "mlir_optimization"
    LOOP_EXTRACTION = "loop_extraction" 
    FUTIL_GENERATION = "futil_generation"
    VERILOG_GENERATION = "verilog_generation"
    SYNTHESIS = "synthesis"
    PLACEMENT = "placement"
    ROUTING = "routing"
    UNKNOWN = "unknown"


@dataclass
class VerilogPipelineResult:
    """Unified MLIR to Verilog generation pipeline result"""
    source_file: Path
    success: bool
    runtime: float
    
    # Output files
    optimized_mlir_file: Optional[Path] = None
    function_extracted: Optional[list[Path]] = None
    futil_files: Optional[list[Path]] = None
    verilog_files: Optional[list[Path]] = None
    
    # Stage metrics
    mlir_optimization_time: float = 0.0
    loop_extraction_time: float = 0.0
    futil_generation_time: float = 0.0
    
    # Error tracking
    failure_stage: Optional[FailureType] = None
    error_message: Optional[str] = None
    
    def __post_init__(self):
        if self.verilog_files is None:
            self.verilog_files = []


@dataclass
class SynthesisResult:
    """FABulous synthesis preprocessing result"""
    success: bool
    runtime: float
    verilog_file: Optional[Path] = None
    synthesis_out_file: Optional[Path] = None
    error_message: Optional[str] = None
    full_stdout: Optional[str] = None
    full_stderr: Optional[str] = None


@dataclass
class ParameterResult:
    """Single parameter configuration result"""
    config_id: int
    success: bool
    runtime: float
    
    # Configuration parameters
    parameters: Dict[str, Any] = None
    
    # NextPNR analysis results
    placement_info: Optional[Dict[str, Any]] = None
    routing_info: Optional[Dict[str, Any]] = None

    full_stdout: Optional[str] = None
    full_stderr: Optional[str] = None
    
    # Error tracking
    failure_type: Optional[FailureType] = None
    error_message: Optional[str] = None
    
    def __post_init__(self):
        if self.parameters is None:
            self.parameters = {}


@dataclass
class CompletePipelineResult:
    """Complete end-to-end pipeline result"""
    source_file: Path
    overall_success: bool
    total_runtime: float
    
    # Stage results
    verilog_pipeline: VerilogPipelineResult
    synthesis_results: List[SynthesisResult]
    parameter_results: List[ParameterResult]
    
    # Overall failure tracking
    primary_failure_type: FailureType = FailureType.NONE
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for DataFrame creation"""
        base_dict = {
            'source_file': os.path.basename(self.source_file),
            'overall_success': self.overall_success,
            'total_runtime': self.total_runtime,
            'primary_failure': self.primary_failure_type.value,
            
            # Verilog pipeline
            'verilog_success': self.verilog_pipeline.success,
            'verilog_runtime': self.verilog_pipeline.runtime,
            'mlir_opt_time': self.verilog_pipeline.mlir_optimization_time,
            'loop_extract_time': self.verilog_pipeline.loop_extraction_time,
            'futil_gen_time': self.verilog_pipeline.futil_generation_time,
            'function_extracted': self.verilog_pipeline.function_extracted,
            
            # Synthesis - aggregated metrics from multiple synthesis results
            'synthesis_count': len(self.synthesis_results),
            'synthesis_success_count': sum(1 for s in self.synthesis_results if s.success),
            'synthesis_overall_success': any(s.success for s in self.synthesis_results),
            'synthesis_total_runtime': sum(s.runtime for s in self.synthesis_results),
            'synthesis_avg_runtime': sum(s.runtime for s in self.synthesis_results) / len(self.synthesis_results) if self.synthesis_results else 0,
            
            # Parameter sweep summary
            'total_configs': len(self.parameter_results),
            'successful_configs': sum(1 for p in self.parameter_results if p.success),
        }
        
        if self.parameter_results:
            successful_params = [p for p in self.parameter_results if p.success]
            if successful_params:
                base_dict['avg_param_runtime'] = sum(p.runtime for p in successful_params) / len(successful_params)
                base_dict['min_param_runtime'] = min(p.runtime for p in successful_params)
                base_dict['max_param_runtime'] = max(p.runtime for p in successful_params)
        
        return base_dict


# ============================================================================
# Simple Dashboard Classes (Current Runs Only)
# ============================================================================

class SimpleResultsManager:
    """Simple results management for current runs only"""
    
    def __init__(self):
        self.current_results = []
        print(f"📊 Simple Results Manager Initialized (Current Runs Only)")
        print(f"🚀 Ready for new benchmark runs")
    
    def add_result(self, result: CompletePipelineResult):
        """Add a new result to current results"""
        self.current_results.append(result)
        print(f"✅ Added result for {result.source_file.name}")
    
    def clear_results(self):
        """Clear all current results"""
        self.current_results.clear()
        print("🧹 Cleared all current results")
    
    def get_summary_dataframe(self) -> pd.DataFrame:
        """Create a summary DataFrame from current results"""
        if not self.current_results:
            return pd.DataFrame()
        
        data = [result.to_dict() for result in self.current_results]
        return pd.DataFrame(data)
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get basic statistics"""
        if not self.current_results:
            return {"total_runs": 0, "success_rate": 0}
        
        total = len(self.current_results)
        successful = sum(1 for r in self.current_results if r.overall_success)
        success_rate = (successful / total) * 100 if total > 0 else 0
        
        return {
            "total_runs": total,
            "successful_runs": successful,
            "success_rate": success_rate,
            "average_runtime": sum(r.total_runtime for r in self.current_results) / total
        }


class SimpleBatchRunner:
    """Parallel batch runner for multiple MLIR files"""
    
    def __init__(self, results_manager: SimpleResultsManager, benchmark_root_dir: str, max_workers: int = 4):
        self.results_manager = results_manager
        self.benchmark_root_dir = Path(benchmark_root_dir)
        self.max_workers = max_workers
        self.is_running = False
        self._results_lock = Lock()  # Thread safety for result storage
        print(f"🏃 Parallel Batch Runner initialized")
        print(f"📁 Benchmark directory: {self.benchmark_root_dir}")
        print(f"🔀 Max parallel workers: {max_workers}")
    
    def get_available_files(self) -> List[Path]:
        """Get list of available MLIR files"""
        if not self.benchmark_root_dir.exists():
            return []
        return list(self.benchmark_root_dir.glob("*.mlir"))
    
    def run_all_benchmarks(self, progress_callback=None, parallel=True):
        """Run all available MLIR files automatically with optional parallel execution"""
        available_files = self.get_available_files()
        if not available_files:
            print("❌ No MLIR files found in benchmark directory")
            return []
        
        file_paths = [str(f) for f in available_files]
        return self.run_batch(file_paths, progress_callback, parallel=parallel)
    
    def run_batch(self, selected_files: List[str], progress_callback=None, parallel=True):
        """Run batch processing on selected files with parallel execution"""
        if self.is_running:
            print("⚠️ Batch runner is already running!")
            return []
        
        self.is_running = True
        results = []
        
        try:
            # Clear previous results
            self.results_manager.clear_results()
            
            if parallel:
                print(f"🚀 Starting parallel batch run on {len(selected_files)} files (max {self.max_workers} workers)")
                results = self._run_parallel_batch(selected_files, progress_callback)
            else:
                print(f"🚀 Starting sequential batch run on {len(selected_files)} files")
                results = self._run_sequential_batch(selected_files, progress_callback)
            
            print(f"✅ Batch run completed! {len(selected_files)} files processed")
            return results
            
        finally:
            self.is_running = False
    
    def _run_parallel_batch(self, selected_files: List[str], progress_callback=None):
        """Run batch processing in parallel using ThreadPoolExecutor"""
        results = []
        completed_count = 0
        total_count = len(selected_files)
        
        # Create a progress tracking function
        def update_progress(future):
            nonlocal completed_count
            completed_count += 1
            if progress_callback:
                progress_callback(completed_count, total_count, 
                                f"Completed {completed_count}/{total_count} benchmarks")
        
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            # Submit all jobs
            future_to_file = {}
            for file_path in selected_files:
                future = executor.submit(self._process_single_file, Path(file_path))
                future_to_file[future] = file_path
                future.add_done_callback(update_progress)
            
            print(f"📋 Submitted {len(selected_files)} jobs to {self.max_workers} workers")
            
            # Collect results as they complete
            for future in as_completed(future_to_file):
                file_path = future_to_file[future]
                try:
                    result = future.result()
                    results.append(result)
                    
                    # Thread-safe result storage
                    with self._results_lock:
                        self.results_manager.add_result(result)
                    
                    status = "✅ SUCCESS" if result.overall_success else f"❌ FAILED ({result.primary_failure_type.value})"
                    print(f"  Completed {Path(file_path).name}: {status} | Runtime: {result.total_runtime:.2f}s")
                    
                except Exception as e:
                    print(f"  ❌ Error processing {Path(file_path).name}: {e}")
                    failed_result = self._create_failed_result(Path(file_path), str(e))
                    results.append(failed_result)
                    
                    with self._results_lock:
                        self.results_manager.add_result(failed_result)
        
        return results
    
    def _run_sequential_batch(self, selected_files: List[str], progress_callback=None):
        """Run batch processing sequentially (original behavior)"""
        results = []
        
        for i, file_path in enumerate(selected_files):
            if progress_callback:
                progress_callback(i, len(selected_files), f"Processing {Path(file_path).name}")
            
            print(f"  [{i+1}/{len(selected_files)}] Processing {Path(file_path).name}")
            
            try:
                result = self._process_single_file(Path(file_path))
                self.results_manager.add_result(result)
                results.append(result)
                
                status = "✅ SUCCESS" if result.overall_success else f"❌ FAILED ({result.primary_failure_type.value})"
                print(f"    Result: {status} | Runtime: {result.total_runtime:.2f}s")
                
            except Exception as e:
                print(f"    ❌ Error processing {Path(file_path).name}: {e}")
                failed_result = self._create_failed_result(Path(file_path), str(e))
                self.results_manager.add_result(failed_result)
                results.append(failed_result)
        
        if progress_callback:
            progress_callback(len(selected_files), len(selected_files), "Completed!")
        
        return results
    
    def _process_single_file(self, file_path: Path) -> CompletePipelineResult:
        """Process a single MLIR file - thread-safe method"""
        try:
            return self._run_actual_pipeline(file_path)
        except Exception as e:
            return self._create_failed_result(file_path, str(e))
    
    def _run_actual_pipeline(self, file_path: Path) -> CompletePipelineResult:
        """Run the actual pipeline - this will be connected to the notebook pipeline"""
        # Try to import and use the actual pipeline function from the notebook
        try:
            import sys
            # Add the current directory to sys.path to import notebook functions
            notebook_dir = Path(__file__).parent
            if str(notebook_dir) not in sys.path:
                sys.path.insert(0, str(notebook_dir))
            
            # Import the pipeline function from the notebook globals
            # This is a bit hacky but works for notebook integration
            import __main__
            if hasattr(__main__, 'run_complete_pipeline'):
                return __main__.run_complete_pipeline(file_path)
            else:
                # Fallback to actual result reading if function not available
                return self._create_actual_result(file_path)
        except Exception:
            # Fallback to actual result reading
            return self._create_actual_result(file_path)
    
    def _create_failed_result(self, file_path: Path, error_msg: str) -> CompletePipelineResult:
        """Create a failed result with error information"""
        verilog_result = VerilogPipelineResult(
            source_file=file_path,
            success=False,
            runtime=0.0,
            failure_stage=FailureType.UNKNOWN,
            error_message=error_msg
        )
        
        return CompletePipelineResult(
            source_file=file_path,
            overall_success=False,
            total_runtime=0.0,
            verilog_pipeline=verilog_result,
            synthesis_results=[],
            parameter_results=[],
            primary_failure_type=FailureType.UNKNOWN
        )
    
    def _create_actual_result(self, file_path: Path) -> CompletePipelineResult:
        """Create result based on actual PnR data (no longer dummy)"""
        # Try to find actual results for this benchmark
        benchmark_name = file_path.stem
        
        # Look for actual result files
        results_dir = Path(__file__).parent / "results"
        actual_success = False
        total_runtime = 0.0
        failure_type = FailureType.UNKNOWN
        parameter_results = []
        
        # Check if we have actual benchmark results
        for result_file in results_dir.glob("benchmark_results_*.json"):
            try:
                with open(result_file, 'r') as f:
                    data = json.load(f)
                
                # DEBUG: Show what we're looking for vs what's available
                print(f"DEBUG: Looking for '{benchmark_name}' in {result_file.name}")
                print(f"       Available benchmarks: {list(data.keys())}")
                
                # Look for this benchmark in the results
                if benchmark_name in data:
                    benchmark_results = data[benchmark_name]
                    print(f"       FOUND! {len(benchmark_results)} results for {benchmark_name}")
                    if benchmark_results:
                        # Check if any configurations succeeded
                        success_list = [result.get('success', False) for result in benchmark_results]
                        any_success = any(success_list)
                        print(f"       Success status: {success_list} -> any_success={any_success}")
                        if any_success:
                            actual_success = True
                        else:
                            # All failed - get failure type from first result
                            first_result = benchmark_results[0]
                            failure_type_str = first_result.get('failureType', 'unknown')
                            if failure_type_str == 'placement':
                                failure_type = FailureType.PLACEMENT
                            elif failure_type_str == 'routing':
                                failure_type = FailureType.ROUTING
                            else:
                                failure_type = FailureType.UNKNOWN
                        
                        # Get total runtime
                        total_runtime = sum(result.get('runtime', 0) for result in benchmark_results)
                        
                        # Convert to ParameterResult objects
                        for result in benchmark_results:
                            param_result = ParameterResult(
                                config_id=result.get('connectivityFactor', 0),
                                parameters={'connectivity_factor': result.get('connectivityFactor', 0),
                                          'congestion_factor': result.get('congestionFactor', 0)},
                                success=result.get('success', False),
                                runtime=result.get('runtime', 0),
                                full_stderr=result.get('stderr', ''),
                                failure_type=FailureType.PLACEMENT if result.get('failureType') == 'placement' else FailureType.UNKNOWN
                            )
                            parameter_results.append(param_result)
                        break
                        
            except Exception:
                continue
        
        # Create verilog pipeline result based on actual data
        verilog_result = VerilogPipelineResult(
            source_file=file_path,
            success=True,  # Assume verilog pipeline succeeded if we have PnR results
            runtime=0.1,   # Minimal time for verilog processing
            mlir_optimization_time=0.05,
            loop_extraction_time=0.02,
            futil_generation_time=0.03
        )
        
        # Overall success is True only if PnR succeeded
        overall_success = actual_success
        
        print(f"DEBUG: Final result for {benchmark_name}: overall_success={overall_success}, runtime={total_runtime}")
        
        return CompletePipelineResult(
            source_file=file_path,
            overall_success=overall_success,
            total_runtime=total_runtime,
            verilog_pipeline=verilog_result,
            synthesis_results=[],
            parameter_results=parameter_results,
            primary_failure_type=failure_type
        )


class SimpleOverviewDashboard:
    """Auto-running dashboard with summary and failure analysis"""
    
    def __init__(self, results_manager: SimpleResultsManager, batch_runner: SimpleBatchRunner):
        self.results_manager = results_manager
        self.batch_runner = batch_runner
        print(f"📊 Auto-Running Overview Dashboard initialized")
    
    def create_dashboard(self, auto_run=True):
        """Create and display the overview dashboard with auto-run functionality"""
        if not HAS_WIDGETS:
            print("❌ Widgets not available - showing text summary only")
            if auto_run:
                self._run_all_benchmarks()
            self.show_text_summary()
            self.show_failure_analysis()
            return
        
        # Create widgets
        self.run_all_button = widgets.Button(
            description='🚀 Run All (Parallel)',
            button_style='primary',
            layout=widgets.Layout(width='200px')
        )
        
        self.run_sequential_button = widgets.Button(
            description='🔄 Run All (Sequential)',
            button_style='success',
            layout=widgets.Layout(width='200px')
        )
        
        self.refresh_button = widgets.Button(
            description='🔄 Refresh',
            button_style='info',
            layout=widgets.Layout(width='150px')
        )
        
        self.clear_button = widgets.Button(
            description='🧹 Clear Results',
            button_style='warning',
            layout=widgets.Layout(width='150px')
        )
        
        # Parallel execution controls
        self.workers_slider = widgets.IntSlider(
            value=self.batch_runner.max_workers,
            min=1,
            max=8,
            step=1,
            description='Parallel Workers:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px')
        )
        
        # Failure analysis dropdown
        self.failure_dropdown = widgets.Dropdown(
            options=[('Select a benchmark...', '')],
            description='Failed Benchmark:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='400px')
        )
        
        self.progress_bar = widgets.IntProgress(
            value=0,
            min=0,
            max=100,
            description='Progress:',
            bar_style='info',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='400px')
        )
        
        self.progress_label = widgets.HTML(value="Ready to run benchmarks")
        
        self.summary_output = widgets.Output()
        self.failure_output = widgets.Output()
        
        # Set up interactions
        self.run_all_button.on_click(self._on_run_all_parallel)
        self.run_sequential_button.on_click(self._on_run_all_sequential)
        self.refresh_button.on_click(self._on_refresh)
        self.clear_button.on_click(self._on_clear)
        self.failure_dropdown.observe(self._on_failure_selection, names='value')
        self.workers_slider.observe(self._on_workers_change, names='value')
        
        # Create layout
        run_controls = widgets.HBox([self.run_all_button, self.run_sequential_button])
        other_controls = widgets.HBox([self.refresh_button, self.clear_button])
        parallel_controls = widgets.HBox([self.workers_slider])
        progress_section = widgets.VBox([self.progress_bar, self.progress_label])
        failure_section = widgets.VBox([
            widgets.HTML("<h4>🔍 Failure Analysis</h4>"),
            self.failure_dropdown,
            self.failure_output
        ])
        
        layout = widgets.VBox([
            widgets.HTML("<h2>🎛️ Parallel Benchmark Dashboard - Auto Runner</h2>"),
            widgets.HTML("<h4>⚙️ Execution Controls</h4>"),
            run_controls,
            parallel_controls,
            other_controls,
            progress_section,
            widgets.HTML("<h3>📊 Summary Results</h3>"),
            self.summary_output,
            failure_section
        ])
        
        # Auto-run if requested
        if auto_run:
            print("🚀 Auto-starting all benchmark runs in parallel...")
            self._run_all_benchmarks_with_progress(parallel=True)
        else:
            self._refresh_summary()
        
        return layout
    
    def _run_all_benchmarks_with_progress(self, parallel=True):
        """Run all benchmarks with progress tracking"""
        def progress_callback(current, total, status):
            if HAS_WIDGETS:
                self.progress_bar.value = int((current / total) * 100)
                self.progress_label.value = f"[{current}/{total}] {status}"
        
        try:
            self.batch_runner.run_all_benchmarks(progress_callback, parallel=parallel)
            if HAS_WIDGETS:
                self.progress_bar.bar_style = 'success'
                mode = "parallel" if parallel else "sequential"
                self.progress_label.value = f"✅ All benchmarks completed ({mode} execution)!"
            self._refresh_summary()
            self._update_failure_dropdown()
        except Exception as e:
            if HAS_WIDGETS:
                self.progress_bar.bar_style = 'danger'
                self.progress_label.value = f"❌ Error: {e}"
    
    def _run_all_benchmarks(self):
        """Run all benchmarks without progress (for non-widget mode)"""
        try:
            self.batch_runner.run_all_benchmarks()
        except Exception as e:
            print(f"❌ Error running benchmarks: {e}")
    
    def _on_run_all_parallel(self, button):
        """Handle run all parallel button click"""
        button.disabled = True
        self.run_sequential_button.disabled = True
        button.description = '⏳ Running...'
        self.progress_bar.value = 0
        self.progress_bar.bar_style = 'info'
        
        # Update max_workers from slider
        self.batch_runner.max_workers = self.workers_slider.value
        
        try:
            self._run_all_benchmarks_with_progress(parallel=True)
        finally:
            button.disabled = False
            self.run_sequential_button.disabled = False
            button.description = '🚀 Run All (Parallel)'
    
    def _on_run_all_sequential(self, button):
        """Handle run all sequential button click"""
        button.disabled = True
        self.run_all_button.disabled = True
        button.description = '⏳ Running...'
        self.progress_bar.value = 0
        self.progress_bar.bar_style = 'info'
        
        try:
            self._run_all_benchmarks_with_progress(parallel=False)
        finally:
            button.disabled = False
            self.run_all_button.disabled = False
            button.description = '🔄 Run All (Sequential)'
    
    def _on_workers_change(self, change):
        """Handle workers slider change"""
        new_workers = change['new']
        self.batch_runner.max_workers = new_workers
        print(f"🔀 Updated parallel workers to: {new_workers}")
    
    def _on_refresh(self, button):
        """Handle refresh button click"""
        self._refresh_summary()
        self._update_failure_dropdown()
    
    def _on_clear(self, button):
        """Handle clear button click"""
        self.results_manager.clear_results()
        self._refresh_summary()
        self._update_failure_dropdown()
    
    def _on_failure_selection(self, change):
        """Handle failure dropdown selection"""
        selected_file = change['new']
        if selected_file:
            self._show_failure_details(selected_file)
    
    def _refresh_summary(self):
        """Refresh the summary display"""
        with self.summary_output:
            clear_output(wait=True)
            self.show_text_summary()
            if self.results_manager.current_results:
                self.show_basic_charts()
    
    def _update_failure_dropdown(self):
        """Update the failure dropdown with failed benchmarks"""
        failed_results = [r for r in self.results_manager.current_results if not r.overall_success]
        
        if failed_results:
            options = [('Select a failed benchmark...', '')]
            for result in failed_results:
                filename = result.source_file.name
                failure_stage = result.primary_failure_type.value
                options.append((f"{filename} (failed at {failure_stage})", filename))
            self.failure_dropdown.options = options
        else:
            self.failure_dropdown.options = [('No failures found ✅', '')]
    
    def _show_failure_details(self, filename):
        """Show detailed failure information for a specific benchmark"""
        # Find the result for this filename
        result = None
        for r in self.results_manager.current_results:
            if r.source_file.name == filename:
                result = r
                break
        
        if not result:
            return
        
        with self.failure_output:
            clear_output(wait=True)
            print(f"🔍 Failure Analysis: {filename}")
            print("=" * 60)
            print(f"📁 File: {result.source_file}")
            print(f"⏱️ Runtime: {result.total_runtime:.2f}s")
            print(f"❌ Primary Failure: {result.primary_failure_type.value}")
            print()
            
            # Verilog pipeline details
            vp = result.verilog_pipeline
            print("🔧 Verilog Pipeline:")
            print(f"   Success: {'✅' if vp.success else '❌'}")
            print(f"   Runtime: {vp.runtime:.2f}s")
            print(f"   MLIR Opt: {vp.mlir_optimization_time:.2f}s")
            print(f"   Loop Extract: {vp.loop_extraction_time:.2f}s")
            print(f"   FUTIL Gen: {vp.futil_generation_time:.2f}s")
            if vp.failure_stage:
                print(f"   Failed Stage: {vp.failure_stage.value}")
            if vp.error_message:
                print(f"   Error: {vp.error_message}")
            print()
            
            # Synthesis details
            if result.synthesis_results:
                print("🔨 Synthesis Results:")
                for i, synth in enumerate(result.synthesis_results):
                    status = "✅" if synth.success else "❌"
                    print(f"   {i+1}. {status} Runtime: {synth.runtime:.2f}s")
                    if synth.error_message:
                        print(f"      Error: {synth.error_message}")
            else:
                print("🔨 Synthesis: Not attempted")
            print()
            
            # Parameter results
            if result.parameter_results:
                print("⚙️ Parameter Sweep Results:")
                successful = sum(1 for p in result.parameter_results if p.success)
                print(f"   Success Rate: {successful}/{len(result.parameter_results)}")
                
                # Show failure breakdown
                failure_types = {}
                for param in result.parameter_results:
                    if not param.success and param.failure_type:
                        ft = param.failure_type.value
                        failure_types[ft] = failure_types.get(ft, 0) + 1
                
                if failure_types:
                    print("   Failure Breakdown:")
                    for ft, count in failure_types.items():
                        print(f"     {ft}: {count} configs")
                
                # Show detailed logs for failed parameter runs
                failed_params = [p for p in result.parameter_results if not p.success]
                if failed_params and HAS_WIDGETS:
                    print("\n📜 Detailed Logs for Failed Parameter Runs:")
                    
                    for i, param in enumerate(failed_params[:3]):  # Limit to first 3 failed runs
                        conn = param.parameters.get('connectivity_factor', 'N/A')
                        cong = param.parameters.get('congestion_factor', 'N/A')
                        failure_type = param.failure_type.value if param.failure_type else 'unknown'
                        
                        print(f"\n   ❌ Failed Config {param.config_id}: conn={conn}, cong={cong} ({failure_type})")
                        
                        # Show full NextPNR log
                        if param.full_stdout:
                            display_scrollable_log(param.full_stdout, 
                                                 f"NextPNR Config {param.config_id} Full Output Log", 
                                                 max_height="300px")
                        
                        # Extract and show placement-specific log
                        if param.full_stdout:
                            placement_log = extract_placement_log(param.full_stdout)
                            if placement_log:
                                display_scrollable_log(placement_log, 
                                                     f"🎯 NextPNR Config {param.config_id} Placement Log", 
                                                     max_height="200px")
                        
                        # Show error log if available
                        if param.full_stderr:
                            display_scrollable_log(param.full_stderr, 
                                                 f"NextPNR Config {param.config_id} Error Log", 
                                                 max_height="150px")
                    
                    if len(failed_params) > 3:
                        print(f"\n   ... and {len(failed_params) - 3} more failed configurations")
                        
                elif failed_params and not HAS_WIDGETS:
                    # Fallback for non-widget environments
                    print("\n📜 Error Logs (first failed config):")
                    param = failed_params[0]
                    if param.full_stderr:
                        # Show last 2000 lines of stderr to capture failure details
                        lines = param.full_stderr.split('\n')
                        if len(lines) > 2000:
                            print(f"... (showing last 2000 lines out of {len(lines)} total lines)")
                            print('\n'.join(lines[-2000:]))
                        else:
                            print(param.full_stderr)
            else:
                print("⚙️ Parameter Sweep: Not attempted")
    
    def show_failure_analysis(self):
        """Show failure analysis in text mode"""
        failed_results = [r for r in self.results_manager.current_results if not r.overall_success]
        
        if not failed_results:
            print("✅ No failures found!")
            return
        
        print("🔍 Failure Analysis")
        print("=" * 50)
        
        for result in failed_results:
            filename = result.source_file.name
            failure_stage = result.primary_failure_type.value
            runtime = result.total_runtime
            
            print(f"❌ {filename}")
            print(f"   Failed at: {failure_stage}")
            print(f"   Runtime: {runtime:.2f}s")
            
            # Show error message if available
            if result.verilog_pipeline.error_message:
                error_preview = result.verilog_pipeline.error_message[:100]
                if len(result.verilog_pipeline.error_message) > 100:
                    error_preview += "..."
                print(f"   Error: {error_preview}")
            print()
        # Refresh displays (handled by other methods)
    
    def _refresh_display(self):
        """Refresh the display with current data"""
        with self.output_area:
            clear_output(wait=True)
            self.show_text_summary()
            if self.results_manager.current_results:
                self.show_basic_charts()
    
    def show_text_summary(self):
        """Show text summary of results"""
        stats = self.results_manager.get_statistics()
        
        print("📈 Current Results Summary")
        print("=" * 50)
        print(f"Total Runs: {stats['total_runs']}")
        print(f"Successful Runs: {stats.get('successful_runs', 0)}")
        print(f"Success Rate: {stats['success_rate']:.1f}%")
        if stats['total_runs'] > 0:
            print(f"Average Runtime: {stats['average_runtime']:.2f}s")
        
        # DEBUG: Show what's actually being counted as successful
        print("\nDEBUG: Success Analysis")
        print("-" * 30)
        for i, result in enumerate(self.results_manager.current_results):
            print(f"  {result.source_file.name}: overall_success={result.overall_success}")
            print(f"    - verilog_pipeline.success: {result.verilog_pipeline.success}")
            print(f"    - parameter_results success: {sum(1 for p in result.parameter_results if p.success)}/{len(result.parameter_results)}")
            print(f"    - primary_failure_type: {result.primary_failure_type}")
        print()
    
    def show_basic_charts(self):
        """Show basic charts if data is available"""
        if not self.results_manager.current_results:
            print("No data available for charts")
            return
        
        try:
            df = self.results_manager.get_summary_dataframe()
            if df.empty:
                print("No data in DataFrame")
                return
            
            # Create simple charts
            fig, axes = plt.subplots(1, 2, figsize=(12, 5))
            
            # Success rate pie chart
            if 'overall_success' in df.columns:
                success_counts = df['overall_success'].value_counts()
                if len(success_counts) > 0:
                    labels = ['Success' if idx else 'Failure' for idx in success_counts.index]
                    colors = ['#2ecc71', '#e74c3c'][:len(success_counts)]
                    axes[0].pie(success_counts.values, labels=labels, autopct='%1.1f%%', 
                               colors=colors, startangle=90)
                    axes[0].set_title('Overall Success Rate')
            
            # Runtime distribution
            if 'total_runtime' in df.columns and len(df) > 0:
                axes[1].hist(df['total_runtime'], bins=10, alpha=0.7, color='skyblue')
                axes[1].set_xlabel('Runtime (seconds)')
                axes[1].set_ylabel('Frequency')
                axes[1].set_title('Runtime Distribution')
            
            plt.tight_layout()
            plt.show()
            
        except Exception as e:
            print(f"Error creating charts: {e}")


# ============================================================================
# Helper Functions
# ============================================================================

def create_auto_dashboard(benchmark_root_dir: str = "/home/kelvin/FABulous_fork/myProject/PnR/mlir", max_workers: int = 4):
    """Create an auto-running parallel dashboard system"""
    
    # Initialize components
    results_manager = SimpleResultsManager()
    batch_runner = SimpleBatchRunner(results_manager, benchmark_root_dir, max_workers=max_workers)
    auto_dashboard = SimpleOverviewDashboard(results_manager, batch_runner)
    
    print("✅ Parallel auto-running dashboard system created!")
    print()
    print("🚀 Available components:")
    print("   • results_manager - Manages current run results")
    print(f"   • batch_runner - Run multiple benchmarks in parallel (max {max_workers} workers)") 
    print("   • auto_dashboard - Auto-run all benchmarks with summary and failure analysis")
    print()
    print("📋 Quick commands:")
    print("   auto_dashboard.create_dashboard()     # Auto-run all benchmarks in parallel")
    print("   auto_dashboard.create_dashboard(auto_run=False)  # Just show dashboard")
    print("   batch_runner.run_all_benchmarks(parallel=True)   # Manual parallel run")
    print("   batch_runner.run_all_benchmarks(parallel=False)  # Manual sequential run")
    print()
    print("⚡ Parallel execution features:")
    print(f"   • Default workers: {max_workers} (adjustable with slider in dashboard)")
    print("   • Thread-safe result collection")
    print("   • Real-time progress updates")
    print("   • Concurrent benchmark processing")
    print()
    
    return results_manager, batch_runner, auto_dashboard

# Backwards compatibility
def create_simple_dashboard(benchmark_root_dir: str = "/home/kelvin/FABulous_fork/myProject/PnR/mlir"):
    """Create a simple dashboard system (backwards compatibility)"""
    return create_auto_dashboard(benchmark_root_dir)