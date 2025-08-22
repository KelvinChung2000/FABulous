#!/usr/bin/env python3
"""Interactive Dashboard for FABulous Benchmark Analysis"""


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

# Data analysis
import pandas as pd
import numpy as np
from scipy import stats
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import classification_report

# Visualization
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import seaborn as sns

# Optional plotly imports
try:
    import plotly.graph_objects as go
    import plotly.express as px
    from plotly.subplots import make_subplots
    HAS_PLOTLY = True
except ImportError:
    HAS_PLOTLY = False
    # Create dummy objects to prevent import errors
    class DummyPlotly:
        def __init__(self):
            pass
        def __getattr__(self, name):
            def dummy_func(*args, **kwargs):
                print(f"Plotly not available - {name} visualization skipped")
                return None
            return dummy_func
    
    go = DummyPlotly()
    px = DummyPlotly()
    def make_subplots(*args, **kwargs):
        print("Plotly not available - interactive plot skipped")
        return None

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



# Advanced Visualizations and Analytics Features
# widgets and display already imported above
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
# plotly imports already handled above
import warnings

# Suppress warnings for cleaner output
warnings.filterwarnings('ignore')

# Set up plotting style
plt.style.use('default')
sns.set_palette("husl")


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
    synthesis_results: List[SynthesisResult]  # Updated to handle multiple synthesis results
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
# Dashboard Classes
# ============================================================================

class BenchmarkResultsManager:
    """Enhanced results management for dashboard functionality"""
    
    def __init__(self, results_dir: Path = Path("/home/kelvin/FABulous_fork/myProject/PnR/results")):
        self.results_dir = Path(results_dir)
        self.historical_results = []
        self.current_results = []
        self.summary_stats = {}
        
    def load_historical_results(self) -> List[Dict[str, Any]]:
        """Load all existing JSON results from the results directory"""
        json_files = list(self.results_dir.glob("benchmark_results_*.json"))
        json_files.sort(key=lambda x: x.name)  # Sort by filename (timestamp)
        
        all_results = []
        for json_file in json_files:
            try:
                with open(json_file, 'r') as f:
                    data = json.load(f)
                    # Add metadata
                    timestamp = json_file.stem.split('_')[-2] + '_' + json_file.stem.split('_')[-1]
                    for benchmark_name, results in data.items():
                        for result in results:
                            result['benchmark_name'] = benchmark_name
                            result['timestamp_file'] = timestamp
                            result['source_file'] = json_file
                            all_results.append(result)
            except Exception as e:
                print(f"Warning: Could not load {json_file}: {e}")
        
        self.historical_results = all_results
        print(f"✅ Loaded {len(all_results)} historical results from {len(json_files)} files")
        return all_results
    
    def create_summary_dataframe(self, include_historical: bool = True) -> pd.DataFrame:
        """Create a comprehensive summary DataFrame"""
        data_source = self.historical_results if include_historical else self.current_results
        
        if not data_source:
            print("No results available to create summary")
            return pd.DataFrame()
        
        # Convert to DataFrame for easier analysis
        df = pd.DataFrame(data_source)
        
        # Add derived columns for analysis
        if 'runtime' in df.columns:
            df['runtime_category'] = pd.cut(df['runtime'], 
                                          bins=[0, 0.5, 1.0, 5.0, float('inf')], 
                                          labels=['Fast (<0.5s)', 'Medium (0.5-1s)', 'Slow (1-5s)', 'Very Slow (>5s)'])
        
        return df
    
    def get_stage_success_rates(self, df: pd.DataFrame = None) -> Dict[str, float]:
        """Calculate success rates by stage"""
        if df is None:
            df = self.create_summary_dataframe()
        
        if df.empty:
            return {}
        
        total_runs = len(df)
        success_rates = {}
        
        # Overall success rate
        if 'success' in df.columns:
            success_rates['Overall'] = df['success'].sum() / total_runs * 100
        
        # Placement success rate
        if 'placementSuccess' in df.columns:
            success_rates['Placement'] = df['placementSuccess'].sum() / total_runs * 100
        
        # Routing success rate  
        if 'routingSuccess' in df.columns:
            success_rates['Routing'] = df['routingSuccess'].sum() / total_runs * 100
        
        # Failure type analysis
        if 'failureType' in df.columns:
            failure_counts = df['failureType'].value_counts()
            success_count = failure_counts.get('none', 0)
            success_rates['No Failures'] = success_count / total_runs * 100
        
        return success_rates
    
    def get_benchmark_summary(self) -> Dict[str, Any]:
        """Get comprehensive benchmark summary statistics"""
        df = self.create_summary_dataframe()
        
        if df.empty:
            return {"error": "No data available"}
        
        summary = {
            'total_runs': len(df),
            'unique_benchmarks': df['benchmark_name'].nunique() if 'benchmark_name' in df.columns else 0,
            'date_range': {
                'oldest': df['timestamp'].min() if 'timestamp' in df.columns else 'Unknown',
                'newest': df['timestamp'].max() if 'timestamp' in df.columns else 'Unknown'
            },
            'success_rates': self.get_stage_success_rates(df),
            'runtime_stats': {
                'mean': df['runtime'].mean() if 'runtime' in df.columns else 0,
                'median': df['runtime'].median() if 'runtime' in df.columns else 0,
                'std': df['runtime'].std() if 'runtime' in df.columns else 0,
                'min': df['runtime'].min() if 'runtime' in df.columns else 0,
                'max': df['runtime'].max() if 'runtime' in df.columns else 0
            }
        }
        
        # Parameter analysis if available
        if 'connectivityFactor' in df.columns and 'congestionFactor' in df.columns:
            summary['parameter_analysis'] = {
                'connectivity_range': [df['connectivityFactor'].min(), df['connectivityFactor'].max()],
                'congestion_range': [df['congestionFactor'].min(), df['congestionFactor'].max()],
                'best_params': self._find_best_parameters(df)
            }
        
        # Failure analysis
        if 'failureType' in df.columns:
            failure_counts = df['failureType'].value_counts().to_dict()
            summary['failure_analysis'] = failure_counts
        
        return summary
    
    def _find_best_parameters(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Find parameter combinations with highest success rates"""
        if df.empty or 'success' not in df.columns:
            return {}
        
        # Group by parameter combinations and calculate success rates
        param_groups = df.groupby(['connectivityFactor', 'congestionFactor']).agg({
            'success': ['count', 'sum', 'mean'],
            'runtime': 'mean'
        }).round(3)
        
        param_groups.columns = ['total_runs', 'successful_runs', 'success_rate', 'avg_runtime']
        param_groups = param_groups.reset_index()
        
        # Sort by success rate, then by runtime
        best_params = param_groups.sort_values(['success_rate', 'avg_runtime'], ascending=[False, True])
        
        if len(best_params) > 0:
            top_param = best_params.iloc[0]
            return {
                'connectivity': top_param['connectivityFactor'],
                'congestion': top_param['congestionFactor'],
                'success_rate': top_param['success_rate'],
                'avg_runtime': top_param['avg_runtime'],
                'total_runs': top_param['total_runs']
            }
        
        return {}
    
    def save_current_results(self, results: List[CompletePipelineResult], 
                           filename: str = None) -> Path:
        """Save current pipeline results to JSON file"""
        if filename is None:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"benchmark_results_{timestamp}.json"
        
        output_path = self.results_dir / filename
        
        # Convert results to JSON-serializable format
        json_data = {}
        for result in results:
            benchmark_name = Path(result.source_file).stem
            if benchmark_name not in json_data:
                json_data[benchmark_name] = []
            
            # Create compatible format with historical data
            for i, param_result in enumerate(result.parameter_results):
                entry = {
                    'sourceFileName': Path(result.source_file).name,
                    'connectivityFactor': param_result.parameters.get('connectivity_factor', 0),
                    'congestionFactor': param_result.parameters.get('congestion_factor', 0),
                    'success': param_result.success,
                    'runtime': param_result.runtime,
                    'returnCode': 0 if param_result.success else 1,
                    'stdout': param_result.full_stdout or "",
                    'stderr': param_result.full_stderr or "",
                    'timestamp': datetime.now().strftime("%Y%m%d_%H%M%S"),
                    'placementSuccess': param_result.placement_info.get('placement_success', False),
                    'routingSuccess': not param_result.routing_info.get('routing_failed', True),
                    'routingFailed': param_result.routing_info.get('routing_failed', False),
                    'failureType': param_result.failure_type.value if param_result.failure_type else 'none',
                    'benchmarkName': benchmark_name
                }
                json_data[benchmark_name].append(entry)
        
        # Save to file
        with open(output_path, 'w') as f:
            json.dump(json_data, f, indent=2)
        
        print(f"✅ Saved {len(results)} benchmark results to {output_path}")
        return output_path

# Initialize the results manager
results_manager = BenchmarkResultsManager()

# Load historical results immediately
historical_data = results_manager.load_historical_results()
summary_stats = results_manager.get_benchmark_summary()

print("📊 Benchmark Results Manager Initialized")
print(f"📁 Results Directory: {results_manager.results_dir}")
print(f"📈 Historical Results: {len(historical_data)} entries")
print(f"🎯 Unique Benchmarks: {summary_stats.get('unique_benchmarks', 0)}")
print(f"✅ Overall Success Rate: {summary_stats.get('success_rates', {}).get('Overall', 0):.1f}%")

class BatchBenchmarkRunner:
    """Interactive batch benchmark runner with progress tracking"""
    
    def __init__(self, results_manager: BenchmarkResultsManager):
        self.results_manager = results_manager
        self.is_running = False
        self.current_results = []
        self.widgets = {}
        self.execution_thread = None
        
    def create_dashboard(self):
        """Create the batch runner dashboard interface"""
        # Get available MLIR files
        available_files = list(Path(BENCHMARK_ROOT_DIR).glob("*.mlir"))
        if not available_files:
            print(f"❌ No MLIR files found in {BENCHMARK_ROOT_DIR}")
            return None
        
        available_files.sort(key=lambda f: f.name.lower())
        
        # File selection
        self.widgets['file_checkboxes'] = []
        file_checkboxes_container = []
        
        # Select All/None buttons
        select_all_btn = widgets.Button(description="Select All", button_style='info', layout=widgets.Layout(width='100px'))
        select_none_btn = widgets.Button(description="Select None", button_style='warning', layout=widgets.Layout(width='100px'))
        
        # Create checkboxes for each file
        for i, file_path in enumerate(available_files):
            checkbox = widgets.Checkbox(
                value=True if i < 5 else False,  # Select first 5 by default
                description=file_path.name,
                layout=widgets.Layout(width='300px'),
                style={'description_width': 'initial'}
            )
            self.widgets['file_checkboxes'].append(checkbox)
            file_checkboxes_container.append(checkbox)
        
        # Parameter configuration
        self.widgets['use_parameter_sweep'] = widgets.Checkbox(
            value=False,
            description='Use full parameter sweep (slower)',
            style={'description_width': 'initial'}
        )
        
        self.widgets['custom_connectivity'] = widgets.FloatSlider(
            value=0.0,
            min=0.0,
            max=2.0,
            step=0.1,
            description='Connectivity Factor:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='350px'),
            disabled=False
        )
        
        self.widgets['custom_congestion'] = widgets.FloatSlider(
            value=0.0,
            min=0.0,
            max=2.0,
            step=0.1,
            description='Congestion Factor:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='350px'),
            disabled=False
        )
        
        # Execution controls
        self.widgets['run_button'] = widgets.Button(
            description='🚀 Run Selected Benchmarks',
            button_style='primary',
            layout=widgets.Layout(width='200px', height='40px')
        )
        
        self.widgets['stop_button'] = widgets.Button(
            description='⏹️ Stop Execution',
            button_style='danger',
            layout=widgets.Layout(width='150px', height='40px'),
            disabled=True
        )
        
        self.widgets['clear_results_button'] = widgets.Button(
            description='🗑️ Clear Results',
            button_style='warning',
            layout=widgets.Layout(width='150px', height='40px')
        )
        
        # Progress tracking
        self.widgets['progress_bar'] = widgets.IntProgress(
            value=0,
            min=0,
            max=100,
            description='Progress:',
            bar_style='info',
            style={'bar_color': '#1f77b4'},
            layout=widgets.Layout(width='400px')
        )
        
        self.widgets['status_text'] = widgets.HTML(
            value="<b>Ready to run benchmarks</b>",
            layout=widgets.Layout(width='600px')
        )
        
        # Results summary
        self.widgets['results_summary'] = widgets.HTML(
            value="<i>No results yet</i>",
            layout=widgets.Layout(width='800px')
        )
        
        # Execution log
        self.widgets['execution_log'] = widgets.Output(
            layout=widgets.Layout(width='800px', height='300px', border='1px solid #ccc')
        )
        
        # Event handlers
        select_all_btn.on_click(self._select_all_files)
        select_none_btn.on_click(self._select_no_files)
        self.widgets['use_parameter_sweep'].observe(self._toggle_parameter_inputs, names='value')
        self.widgets['run_button'].on_click(self._start_batch_execution)
        self.widgets['stop_button'].on_click(self._stop_batch_execution)
        self.widgets['clear_results_button'].on_click(self._clear_results)
        
        # Layout
        file_selection_header = widgets.HTML("<h3>📁 Benchmark Selection</h3>")
        file_selection_controls = widgets.HBox([select_all_btn, select_none_btn])
        
        # Limit file checkboxes to show in columns for better UI
        checkbox_columns = []
        files_per_column = 8
        for i in range(0, len(file_checkboxes_container), files_per_column):
            column = widgets.VBox(file_checkboxes_container[i:i+files_per_column])
            checkbox_columns.append(column)
        
        file_selection_area = widgets.HBox(checkbox_columns)
        
        param_header = widgets.HTML("<h3>⚙️ Parameter Configuration</h3>")
        param_controls = widgets.VBox([
            self.widgets['use_parameter_sweep'],
            widgets.HBox([self.widgets['custom_connectivity'], self.widgets['custom_congestion']])
        ])
        
        execution_header = widgets.HTML("<h3>🎮 Execution Control</h3>")
        execution_controls = widgets.HBox([
            self.widgets['run_button'],
            self.widgets['stop_button'],
            self.widgets['clear_results_button']
        ])
        
        progress_header = widgets.HTML("<h3>📊 Progress Tracking</h3>")
        progress_area = widgets.VBox([
            self.widgets['progress_bar'],
            self.widgets['status_text'],
            self.widgets['results_summary']
        ])
        
        log_header = widgets.HTML("<h3>📝 Execution Log</h3>")
        
        return widgets.VBox([
            widgets.HTML("<h2>🏃‍♂️ Batch Benchmark Runner</h2>"),
            file_selection_header,
            file_selection_controls,
            file_selection_area,
            param_header,
            param_controls,
            execution_header,
            execution_controls,
            progress_header,
            progress_area,
            log_header,
            self.widgets['execution_log']
        ])
    
    def _select_all_files(self, button):
        """Select all benchmark files"""
        for checkbox in self.widgets['file_checkboxes']:
            checkbox.value = True
        self._update_status("📋 Selected all benchmarks")
    
    def _select_no_files(self, button):
        """Deselect all benchmark files"""
        for checkbox in self.widgets['file_checkboxes']:
            checkbox.value = False
        self._update_status("📋 Deselected all benchmarks")
    
    def _toggle_parameter_inputs(self, change):
        """Toggle custom parameter inputs based on sweep checkbox"""
        use_sweep = change['new']
        self.widgets['custom_connectivity'].disabled = use_sweep
        self.widgets['custom_congestion'].disabled = use_sweep
        
        if use_sweep:
            self._update_status("🎛️ Using full parameter sweep (100 configurations)")
        else:
            self._update_status("🎛️ Using custom parameter configuration")
    
    def _update_status(self, message: str):
        """Update status text"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.widgets['status_text'].value = f"<b>[{timestamp}]</b> {message}"
    
    def _update_progress(self, current: int, total: int, current_file: str = ""):
        """Update progress bar and status"""
        progress_percent = int((current / total) * 100) if total > 0 else 0
        self.widgets['progress_bar'].value = progress_percent
        
        status_msg = f"Processing {current}/{total} benchmarks"
        if current_file:
            status_msg += f" - Current: {current_file}"
        
        self._update_status(status_msg)
    
    def _log_message(self, message: str, clear: bool = False):
        """Add message to execution log"""
        with self.widgets['execution_log']:
            if clear:
                clear_output()
            timestamp = datetime.now().strftime("%H:%M:%S")
            print(f"[{timestamp}] {message}")
    
    def _start_batch_execution(self, button):
        """Start batch execution in a separate thread"""
        if self.is_running:
            self._log_message("⚠️ Execution already running!")
            return
        
        # Get selected files
        selected_files = []
        available_files = list(Path(BENCHMARK_ROOT_DIR).glob("*.mlir"))
        available_files.sort(key=lambda f: f.name.lower())
        
        for i, checkbox in enumerate(self.widgets['file_checkboxes']):
            if checkbox.value and i < len(available_files):
                selected_files.append(available_files[i])
        
        if not selected_files:
            self._log_message("❌ No files selected for execution!")
            return
        
        # Start execution thread
        self.execution_thread = threading.Thread(
            target=self._execute_batch,
            args=(selected_files,),
            daemon=True
        )
        self.execution_thread.start()
    
    def _execute_batch(self, selected_files: List[Path]):
        """Execute batch processing in background thread"""
        self.is_running = True
        self.current_results = []
        
        # Update UI state
        self.widgets['run_button'].disabled = True
        self.widgets['stop_button'].disabled = False
        self.widgets['progress_bar'].bar_style = 'info'
        
        total_files = len(selected_files)
        self._log_message(f"🚀 Starting batch execution of {total_files} benchmarks", clear=True)
        self._update_progress(0, total_files)
        
        # Get parameter configuration
        use_sweep = self.widgets['use_parameter_sweep'].value
        custom_params = None if use_sweep else {
            'connectivity_factor': self.widgets['custom_connectivity'].value,
            'congestion_factor': self.widgets['custom_congestion'].value
        }
        
        if custom_params:
            self._log_message(f"🎛️ Using custom parameters: conn={custom_params['connectivity_factor']}, cong={custom_params['congestion_factor']}")
        else:
            self._log_message("🎛️ Using full parameter sweep (100 configurations per benchmark)")
        
        try:
            for i, mlir_file in enumerate(selected_files):
                if not self.is_running:  # Check for stop signal
                    self._log_message("⏹️ Execution stopped by user")
                    break
                
                current_file = mlir_file.name
                self._update_progress(i, total_files, current_file)
                self._log_message(f"📝 Processing {current_file}...")
                
                try:
                    # Run the complete pipeline
                    start_time = time.time()
                    result = run_complete_pipeline(mlir_file)
                    execution_time = time.time() - start_time
                    
                    self.current_results.append(result)
                    
                    # Log result
                    status = "✅ SUCCESS" if result.overall_success else f"❌ FAILED ({result.primary_failure_type.value})"
                    self._log_message(f"  {status} - Runtime: {execution_time:.2f}s")
                    
                    # Update results summary
                    self._update_results_summary()
                    
                except Exception as e:
                    self._log_message(f"  💥 ERROR: {str(e)}")
                
                self._update_progress(i + 1, total_files)
        
        except Exception as e:
            self._log_message(f"💥 Batch execution failed: {str(e)}")
            self.widgets['progress_bar'].bar_style = 'danger'
        
        finally:
            # Update UI state
            self.is_running = False
            self.widgets['run_button'].disabled = False
            self.widgets['stop_button'].disabled = True
            
            if self.current_results:
                self.widgets['progress_bar'].bar_style = 'success'
                self._log_message(f"🏁 Batch execution completed! Processed {len(self.current_results)} benchmarks")
                
                # Save results automatically
                try:
                    output_path = self.results_manager.save_current_results(self.current_results)
                    self._log_message(f"💾 Results saved to {output_path.name}")
                except Exception as e:
                    self._log_message(f"⚠️ Failed to save results: {str(e)}")
            else:
                self.widgets['progress_bar'].bar_style = 'warning'
                self._log_message("⚠️ No results to save")
    
    def _stop_batch_execution(self, button):
        """Stop the batch execution"""
        if self.is_running:
            self.is_running = False
            self._update_status("⏹️ Stopping execution...")
            self._log_message("⏹️ Stop signal sent - waiting for current benchmark to complete...")
        else:
            self._log_message("⚠️ No execution to stop")
    
    def _clear_results(self, button):
        """Clear current results and reset UI"""
        self.current_results = []
        self.widgets['progress_bar'].value = 0
        self.widgets['progress_bar'].bar_style = 'info'
        self.widgets['results_summary'].value = "<i>No results yet</i>"
        self._update_status("🗑️ Results cleared")
        self._log_message("🗑️ Results cleared", clear=True)
    
    def _update_results_summary(self):
        """Update the results summary display"""
        if not self.current_results:
            return
        
        total_runs = len(self.current_results)
        successful_runs = sum(1 for r in self.current_results if r.overall_success)
        success_rate = (successful_runs / total_runs) * 100
        
        # Stage success rates
        verilog_success = sum(1 for r in self.current_results if r.verilog_pipeline.success)
        synthesis_success = sum(1 for r in self.current_results if any(s.success for s in r.synthesis_results))
        pnr_success = sum(1 for r in self.current_results if any(p.success for p in r.parameter_results))
        
        # Average runtime
        avg_runtime = sum(r.total_runtime for r in self.current_results) / total_runs
        
        summary_html = f"""
        <div style="background-color: #f0f8ff; padding: 10px; border-radius: 5px; border: 1px solid #ccc;">
            <b>Current Batch Results Summary:</b><br>
            📊 Total Benchmarks: {total_runs}<br>
            ✅ Overall Success: {successful_runs}/{total_runs} ({success_rate:.1f}%)<br>
            🔧 Verilog Generation: {verilog_success}/{total_runs} ({verilog_success/total_runs*100:.1f}%)<br>
            ⚙️ Synthesis: {synthesis_success}/{total_runs} ({synthesis_success/total_runs*100:.1f}%)<br>
            🎯 Place & Route: {pnr_success}/{total_runs} ({pnr_success/total_runs*100:.1f}%)<br>
            ⏱️ Average Runtime: {avg_runtime:.2f}s
        </div>
        """
        
        self.widgets['results_summary'].value = summary_html

# Create and display the batch runner dashboard
try:
    if 'batch_runner' in globals():
        del batch_runner
    
    batch_runner = BatchBenchmarkRunner(results_manager)
    batch_dashboard = batch_runner.create_dashboard()
    
    if batch_dashboard:
        display(batch_dashboard)
        print("✅ Batch Benchmark Runner Dashboard loaded successfully!")
        print("📝 Select benchmarks and click 'Run Selected Benchmarks' to start batch processing.")
    else:
        print("❌ Failed to create batch runner dashboard")

except Exception as e:
    print(f"❌ Batch runner dashboard creation failed: {str(e)}")
    import traceback
    print("Full error:")
    print(traceback.format_exc())

# Enhanced Data Loading and Results Management for Dashboard
import json
import glob
from typing import List, Dict, Any
import pandas as pd
import numpy as np
from pathlib import Path
from datetime import datetime
import matplotlib.pyplot as plt
import seaborn as sns
# widgets and display already imported above

# Set up plotting style
plt.style.use('default')
sns.set_palette("husl")

class OverviewAnalyticsDashboard:
    """Interactive overview analytics dashboard for benchmark results"""
    
    def __init__(self, results_manager: BenchmarkResultsManager):
        self.results_manager = results_manager
        self.widgets = {}
        self.current_df = pd.DataFrame()
        
    def create_dashboard(self):
        """Create the overview analytics dashboard"""
        
        # Data source selection
        self.widgets['data_source'] = widgets.RadioButtons(
            options=[('Historical Data', 'historical'), ('Current Batch', 'current'), ('Combined', 'combined')],
            value='historical',
            description='Data Source:',
            style={'description_width': 'initial'}
        )
        
        # Refresh data button
        self.widgets['refresh_button'] = widgets.Button(
            description='🔄 Refresh Data',
            button_style='info',
            layout=widgets.Layout(width='150px')
        )
        
        # Chart selection
        self.widgets['chart_selector'] = widgets.Dropdown(
            options=[
                ('Success Rate Overview', 'success_overview'),
                ('Stage Success Breakdown', 'stage_breakdown'),
                ('Runtime Distribution', 'runtime_dist'),
                ('Parameter Heatmap', 'param_heatmap'),
                ('Failure Analysis', 'failure_analysis'),
                ('Benchmark Comparison', 'benchmark_comparison')
            ],
            value='success_overview',
            description='Chart Type:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px')
        )
        
        # Data summary display
        self.widgets['data_summary'] = widgets.HTML(
            value="<i>Loading data summary...</i>",
            layout=widgets.Layout(width='800px')
        )
        
        # Chart output area
        self.widgets['chart_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='500px')
        )
        
        # Statistics table
        self.widgets['stats_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='200px')
        )
        
        # Event handlers
        self.widgets['data_source'].observe(self._on_data_source_change, names='value')
        self.widgets['chart_selector'].observe(self._on_chart_change, names='value')
        self.widgets['refresh_button'].on_click(self._refresh_data)
        
        # Initial data load
        self._load_data()
        
        # Layout
        controls_header = widgets.HTML("<h3>🎛️ Dashboard Controls</h3>")
        controls_area = widgets.HBox([
            self.widgets['data_source'],
            widgets.VBox([self.widgets['chart_selector'], self.widgets['refresh_button']])
        ])
        
        summary_header = widgets.HTML("<h3>📊 Data Summary</h3>")
        chart_header = widgets.HTML("<h3>📈 Visualization</h3>")
        stats_header = widgets.HTML("<h3>📋 Detailed Statistics</h3>")
        
        return widgets.VBox([
            widgets.HTML("<h2>📊 Overview Analytics Dashboard</h2>"),
            controls_header,
            controls_area,
            summary_header,
            self.widgets['data_summary'],
            chart_header,
            self.widgets['chart_output'],
            stats_header,
            self.widgets['stats_output']
        ])
    
    def _load_data(self):
        """Load data based on selected source"""
        data_source = self.widgets['data_source'].value
        
        if data_source == 'historical':
            # Load historical results
            historical_data = self.results_manager.load_historical_results()
            self.current_df = self.results_manager.create_summary_dataframe(include_historical=True)
        elif data_source == 'current':
            # Use current batch results if available
            if hasattr(self, 'batch_runner') and hasattr(batch_runner, 'current_results'):
                current_data = []
                for result in batch_runner.current_results:
                    # Convert CompletePipelineResult to DataFrame format
                    for param_result in result.parameter_results:
                        entry = {
                            'benchmark_name': Path(result.source_file).stem,
                            'success': param_result.success,
                            'runtime': param_result.runtime,
                            'connectivityFactor': param_result.parameters.get('connectivity_factor', 0),
                            'congestionFactor': param_result.parameters.get('congestion_factor', 0),
                            'placementSuccess': param_result.placement_info.get('placement_success', False),
                            'routingSuccess': not param_result.routing_info.get('routing_failed', True),
                            'failureType': param_result.failure_type.value if param_result.failure_type else 'none'
                        }
                        current_data.append(entry)
                self.current_df = pd.DataFrame(current_data)
            else:
                self.current_df = pd.DataFrame()
        else:  # combined
            # Combine historical and current data
            historical_df = self.results_manager.create_summary_dataframe(include_historical=True)
            current_df = pd.DataFrame()  # Would add current batch data here
            self.current_df = pd.concat([historical_df, current_df], ignore_index=True)
        
        # Update summary display
        self._update_data_summary()
        
        # Update chart
        self._update_chart()
    
    def _update_data_summary(self):
        """Update the data summary display"""
        if self.current_df.empty:
            summary_html = "<div style='color: orange;'>⚠️ No data available for selected source</div>"
        else:
            total_runs = len(self.current_df)
            unique_benchmarks = self.current_df['benchmark_name'].nunique() if 'benchmark_name' in self.current_df.columns else 0
            
            # Success rates
            overall_success = self.current_df['success'].mean() * 100 if 'success' in self.current_df.columns else 0
            placement_success = self.current_df['placementSuccess'].mean() * 100 if 'placementSuccess' in self.current_df.columns else 0
            routing_success = self.current_df['routingSuccess'].mean() * 100 if 'routingSuccess' in self.current_df.columns else 0
            
            # Runtime stats
            if 'runtime' in self.current_df.columns:
                avg_runtime = self.current_df['runtime'].mean()
                median_runtime = self.current_df['runtime'].median()
                max_runtime = self.current_df['runtime'].max()
            else:
                avg_runtime = median_runtime = max_runtime = 0
            
            summary_html = f"""
            <div style="background-color: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #dee2e6;">
                <div style="display: flex; justify-content: space-between;">
                    <div>
                        <b>📊 Dataset Overview:</b><br>
                        • Total Runs: <b>{total_runs:,}</b><br>
                        • Unique Benchmarks: <b>{unique_benchmarks}</b><br>
                        • Data Source: <b>{self.widgets['data_source'].value.title()}</b>
                    </div>
                    <div>
                        <b>✅ Success Rates:</b><br>
                        • Overall: <b>{overall_success:.1f}%</b><br>
                        • Placement: <b>{placement_success:.1f}%</b><br>
                        • Routing: <b>{routing_success:.1f}%</b>
                    </div>
                    <div>
                        <b>⏱️ Runtime Statistics:</b><br>
                        • Average: <b>{avg_runtime:.2f}s</b><br>
                        • Median: <b>{median_runtime:.2f}s</b><br>
                        • Maximum: <b>{max_runtime:.2f}s</b>
                    </div>
                </div>
            </div>
            """
        
        self.widgets['data_summary'].value = summary_html
    
    def _update_chart(self):
        """Update the chart based on selected type"""
        chart_type = self.widgets['chart_selector'].value
        
        with self.widgets['chart_output']:
            clear_output(wait=True)
            
            if self.current_df.empty:
                print("⚠️ No data available to chart")
                return
            
            plt.style.use('default')
            
            if chart_type == 'success_overview':
                self._plot_success_overview()
            elif chart_type == 'stage_breakdown':
                self._plot_stage_breakdown()
            elif chart_type == 'runtime_dist':
                self._plot_runtime_distribution()
            elif chart_type == 'param_heatmap':
                self._plot_parameter_heatmap()
            elif chart_type == 'failure_analysis':
                self._plot_failure_analysis()
            elif chart_type == 'benchmark_comparison':
                self._plot_benchmark_comparison()
            
            plt.tight_layout()
            plt.show()
        
        # Update statistics table
        self._update_statistics_table()
    
    def _plot_success_overview(self):
        """Plot overall success rate overview"""
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
        
        # Overall success pie chart
        if 'success' in self.current_df.columns:
            success_counts = self.current_df['success'].value_counts()
            colors = ['#2ecc71', '#e74c3c']  # Green for success, Red for failure
            ax1.pie(success_counts.values, labels=['Success', 'Failure'], autopct='%1.1f%%', 
                   colors=colors, startangle=90)
            ax1.set_title('Overall Success Rate')
        
        # Success rate by benchmark
        if 'benchmark_name' in self.current_df.columns and 'success' in self.current_df.columns:
            benchmark_success = self.current_df.groupby('benchmark_name')['success'].agg(['count', 'sum', 'mean']).sort_values('mean', ascending=True)
            benchmark_success['success_rate'] = benchmark_success['mean'] * 100
            
            # Limit to top/bottom benchmarks for readability
            if len(benchmark_success) > 15:
                top_bottom = pd.concat([
                    benchmark_success.head(7),
                    benchmark_success.tail(8)
                ])
            else:
                top_bottom = benchmark_success
            
            bars = ax2.barh(range(len(top_bottom)), top_bottom['success_rate'])
            ax2.set_yticks(range(len(top_bottom)))
            ax2.set_yticklabels([name[:20] + '...' if len(name) > 20 else name 
                                for name in top_bottom.index], fontsize=8)
            ax2.set_xlabel('Success Rate (%)')
            ax2.set_title('Success Rate by Benchmark')
            ax2.set_xlim(0, 100)
            
            # Color bars based on success rate
            for i, (bar, rate) in enumerate(zip(bars, top_bottom['success_rate'])):
                if rate >= 80:
                    bar.set_color('#2ecc71')  # Green
                elif rate >= 50:
                    bar.set_color('#f39c12')  # Orange  
                else:
                    bar.set_color('#e74c3c')  # Red
    
    def _plot_stage_breakdown(self):
        """Plot success rates by stage"""
        fig, ax = plt.subplots(1, 1, figsize=(10, 6))
        
        stages = []
        success_rates = []
        
        if 'success' in self.current_df.columns:
            stages.append('Overall')
            success_rates.append(self.current_df['success'].mean() * 100)
        
        if 'placementSuccess' in self.current_df.columns:
            stages.append('Placement')
            success_rates.append(self.current_df['placementSuccess'].mean() * 100)
        
        if 'routingSuccess' in self.current_df.columns:
            stages.append('Routing')
            success_rates.append(self.current_df['routingSuccess'].mean() * 100)
        
        if stages:
            bars = ax.bar(stages, success_rates, color=['#3498db', '#2ecc71', '#f39c12'])
            ax.set_ylabel('Success Rate (%)')
            ax.set_title('Success Rate by Pipeline Stage')
            ax.set_ylim(0, 100)
            
            # Add value labels on bars
            for bar, rate in zip(bars, success_rates):
                ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 1,
                       f'{rate:.1f}%', ha='center', va='bottom', fontweight='bold')
    
    def _plot_runtime_distribution(self):
        """Plot runtime distribution"""
        if 'runtime' not in self.current_df.columns:
            print("⚠️ No runtime data available")
            return
        
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
        
        # Runtime histogram
        runtime_data = self.current_df['runtime'].dropna()
        ax1.hist(runtime_data, bins=30, edgecolor='black', alpha=0.7, color='skyblue')
        ax1.set_xlabel('Runtime (seconds)')
        ax1.set_ylabel('Frequency')
        ax1.set_title('Runtime Distribution')
        ax1.axvline(runtime_data.mean(), color='red', linestyle='--', label=f'Mean: {runtime_data.mean():.2f}s')
        ax1.axvline(runtime_data.median(), color='green', linestyle='--', label=f'Median: {runtime_data.median():.2f}s')
        ax1.legend()
        
        # Runtime by success status
        if 'success' in self.current_df.columns:
            success_runtime = self.current_df[self.current_df['success'] == True]['runtime'].dropna()
            failed_runtime = self.current_df[self.current_df['success'] == False]['runtime'].dropna()
            
            if len(success_runtime) > 0 and len(failed_runtime) > 0:
                ax2.boxplot([success_runtime, failed_runtime], labels=['Success', 'Failure'])
                ax2.set_ylabel('Runtime (seconds)')
                ax2.set_title('Runtime by Success Status')
            else:
                ax2.text(0.5, 0.5, 'Insufficient data for comparison', 
                        transform=ax2.transAxes, ha='center', va='center')
    
    def _plot_parameter_heatmap(self):
        """Plot parameter success rate heatmap"""
        if not all(col in self.current_df.columns for col in ['connectivityFactor', 'congestionFactor', 'success']):
            print("⚠️ Parameter data not available for heatmap")
            return
        
        # Create parameter grid
        param_grid = self.current_df.groupby(['connectivityFactor', 'congestionFactor'])['success'].agg(['count', 'mean']).reset_index()
        param_grid = param_grid[param_grid['count'] >= 3]  # Only show cells with at least 3 samples
        
        if param_grid.empty:
            print("⚠️ Insufficient parameter data for heatmap")
            return
        
        # Create pivot table for heatmap
        heatmap_data = param_grid.pivot(index='congestionFactor', 
                                       columns='connectivityFactor', 
                                       values='mean')
        
        fig, ax = plt.subplots(1, 1, figsize=(10, 8))
        
        # Create heatmap
        sns.heatmap(heatmap_data, annot=True, fmt='.2f', cmap='RdYlGn', 
                   center=0.5, vmin=0, vmax=1, ax=ax,
                   cbar_kws={'label': 'Success Rate'})
        
        ax.set_title('Success Rate Heatmap\n(Connectivity vs Congestion Factors)')
        ax.set_xlabel('Connectivity Factor')
        ax.set_ylabel('Congestion Factor')
    
    def _plot_failure_analysis(self):
        """Plot failure type analysis"""
        if 'failureType' not in self.current_df.columns:
            print("⚠️ No failure type data available")
            return
        
        failure_counts = self.current_df['failureType'].value_counts()
        
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
        
        # Failure type pie chart
        colors = plt.cm.Set3(np.linspace(0, 1, len(failure_counts)))
        wedges, texts, autotexts = ax1.pie(failure_counts.values, labels=failure_counts.index, 
                                          autopct='%1.1f%%', colors=colors, startangle=90)
        ax1.set_title('Failure Type Distribution')
        
        # Make text more readable
        for autotext in autotexts:
            autotext.set_color('black')
            autotext.set_fontweight('bold')
        
        # Failure type bar chart
        bars = ax2.bar(range(len(failure_counts)), failure_counts.values, color=colors)
        ax2.set_xticks(range(len(failure_counts)))
        ax2.set_xticklabels(failure_counts.index, rotation=45, ha='right')
        ax2.set_ylabel('Count')
        ax2.set_title('Failure Type Frequency')
        
        # Add value labels on bars
        for bar, count in zip(bars, failure_counts.values):
            ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.1,
                    str(count), ha='center', va='bottom', fontweight='bold')
    
    def _plot_benchmark_comparison(self):
        """Plot benchmark comparison analysis"""
        if 'benchmark_name' not in self.current_df.columns:
            print("⚠️ No benchmark data available")
            return
        
        # Calculate statistics per benchmark
        benchmark_stats = self.current_df.groupby('benchmark_name').agg({
            'success': ['count', 'sum', 'mean'],
            'runtime': ['mean', 'std']
        }).round(3)
        
        benchmark_stats.columns = ['total_runs', 'successful_runs', 'success_rate', 'avg_runtime', 'runtime_std']
        benchmark_stats = benchmark_stats.reset_index()
        benchmark_stats = benchmark_stats.sort_values('success_rate', ascending=False)
        
        # Limit to top 20 for readability
        if len(benchmark_stats) > 20:
            benchmark_stats = benchmark_stats.head(20)
        
        fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 10))
        
        # Success rate comparison
        bars1 = ax1.bar(range(len(benchmark_stats)), benchmark_stats['success_rate'] * 100)
        ax1.set_xticks(range(len(benchmark_stats)))
        ax1.set_xticklabels([name[:15] + '...' if len(name) > 15 else name 
                            for name in benchmark_stats['benchmark_name']], 
                           rotation=45, ha='right', fontsize=8)
        ax1.set_ylabel('Success Rate (%)')
        ax1.set_title('Benchmark Success Rate Comparison')
        ax1.set_ylim(0, 100)
        
        # Color bars based on success rate
        for bar, rate in zip(bars1, benchmark_stats['success_rate'] * 100):
            if rate >= 80:
                bar.set_color('#2ecc71')
            elif rate >= 50:
                bar.set_color('#f39c12')
            else:
                bar.set_color('#e74c3c')
        
        # Average runtime comparison
        bars2 = ax2.bar(range(len(benchmark_stats)), benchmark_stats['avg_runtime'])
        ax2.set_xticks(range(len(benchmark_stats)))
        ax2.set_xticklabels([name[:15] + '...' if len(name) > 15 else name 
                            for name in benchmark_stats['benchmark_name']], 
                           rotation=45, ha='right', fontsize=8)
        ax2.set_ylabel('Average Runtime (s)')
        ax2.set_title('Benchmark Runtime Comparison')
        
        # Color bars based on runtime (blue gradient)
        max_runtime = benchmark_stats['avg_runtime'].max()
        for bar, runtime in zip(bars2, benchmark_stats['avg_runtime']):
            intensity = runtime / max_runtime if max_runtime > 0 else 0
            bar.set_color(plt.cm.Blues(0.3 + intensity * 0.7))
    
    def _update_statistics_table(self):
        """Update detailed statistics table"""
        with self.widgets['stats_output']:
            clear_output(wait=True)
            
            if self.current_df.empty:
                print("⚠️ No data available for statistics")
                return
            
            print("📊 Detailed Statistics Summary")
            print("=" * 50)
            
            # Basic statistics
            total_runs = len(self.current_df)
            print(f"Total Runs: {total_runs:,}")
            
            if 'benchmark_name' in self.current_df.columns:
                unique_benchmarks = self.current_df['benchmark_name'].nunique()
                print(f"Unique Benchmarks: {unique_benchmarks}")
            
            # Success statistics
            if 'success' in self.current_df.columns:
                success_rate = self.current_df['success'].mean() * 100
                successful_runs = self.current_df['success'].sum()
                print(f"Overall Success Rate: {success_rate:.2f}% ({successful_runs}/{total_runs})")
            
            # Runtime statistics
            if 'runtime' in self.current_df.columns:
                runtime_stats = self.current_df['runtime'].describe()
                print(f"\nRuntime Statistics:")
                print(f"  Mean: {runtime_stats['mean']:.3f}s")
                print(f"  Median (50%): {runtime_stats['50%']:.3f}s")
                print(f"  Std Dev: {runtime_stats['std']:.3f}s")
                print(f"  Min: {runtime_stats['min']:.3f}s")
                print(f"  Max: {runtime_stats['max']:.3f}s")
            
            # Top performing benchmarks
            if 'benchmark_name' in self.current_df.columns and 'success' in self.current_df.columns:
                benchmark_perf = self.current_df.groupby('benchmark_name')['success'].agg(['count', 'mean']).sort_values('mean', ascending=False)
                benchmark_perf = benchmark_perf[benchmark_perf['count'] >= 3]  # At least 3 runs
                
                if not benchmark_perf.empty:
                    print(f"\nTop 5 Performing Benchmarks (≥3 runs):")
                    for i, (name, stats) in enumerate(benchmark_perf.head().iterrows()):
                        print(f"  {i+1}. {name}: {stats['mean']*100:.1f}% ({stats['count']} runs)")
    
    def _on_data_source_change(self, change):
        """Handle data source change"""
        self._load_data()
    
    def _on_chart_change(self, change):
        """Handle chart type change"""
        self._update_chart()
    
    def _refresh_data(self, button):
        """Refresh data and update all displays"""
        self.results_manager.load_historical_results()  # Reload from files
        self._load_data()

# Create and display the overview analytics dashboard
try:
    if 'overview_dashboard' in globals():
        del overview_dashboard
    
    overview_dashboard = OverviewAnalyticsDashboard(results_manager)
    analytics_dashboard = overview_dashboard.create_dashboard()
    
    if analytics_dashboard:
        display(analytics_dashboard)
        print("✅ Overview Analytics Dashboard loaded successfully!")
        print("📈 Select different chart types to explore your benchmark data.")
    else:
        print("❌ Failed to create overview analytics dashboard")

except Exception as e:
    print(f"❌ Overview analytics dashboard creation failed: {str(e)}")
    import traceback
    print("Full error:")
    print(traceback.format_exc())

# Batch Benchmark Runner Dashboard
# widgets and display already imported above
import threading
import time
import concurrent.futures
from typing import List

class BenchmarkExplorer:
    """Interactive explorer for individual benchmark analysis"""
    
    def __init__(self, results_manager: BenchmarkResultsManager):
        self.results_manager = results_manager
        self.widgets = {}
        self.current_benchmark_data = pd.DataFrame()
        
    def create_dashboard(self):
        """Create the benchmark explorer dashboard"""
        
        # Get available benchmarks from data
        df = self.results_manager.create_summary_dataframe()
        if df.empty or 'benchmark_name' not in df.columns:
            return widgets.HTML("<div style='color: red;'>❌ No benchmark data available</div>")
        
        available_benchmarks = sorted(df['benchmark_name'].unique())
        
        # Benchmark selection
        self.widgets['benchmark_selector'] = widgets.Dropdown(
            options=[(name, name) for name in available_benchmarks],
            description='Benchmark:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='400px')
        )
        
        # Refresh button
        self.widgets['refresh_button'] = widgets.Button(
            description='🔄 Refresh',
            button_style='info',
            layout=widgets.Layout(width='120px')
        )
        
        # Analysis view selection
        self.widgets['view_selector'] = widgets.Dropdown(
            options=[
                ('Summary Overview', 'summary'),
                ('Parameter Analysis', 'parameters'),
                ('Runtime Analysis', 'runtime'),
                ('Failure Details', 'failures'),
                ('Raw Log View', 'logs')
            ],
            value='summary',
            description='View:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='250px')
        )
        
        # Export options
        self.widgets['export_button'] = widgets.Button(
            description='📁 Export Data',
            button_style='success',
            layout=widgets.Layout(width='120px')
        )
        
        # Benchmark summary
        self.widgets['benchmark_summary'] = widgets.HTML(
            value="<i>Select a benchmark to view analysis</i>",
            layout=widgets.Layout(width='100%')
        )
        
        # Main analysis area
        self.widgets['analysis_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='400px')
        )
        
        # Detailed information area
        self.widgets['details_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='300px')
        )
        
        # Event handlers
        self.widgets['benchmark_selector'].observe(self._on_benchmark_change, names='value')
        self.widgets['view_selector'].observe(self._on_view_change, names='value')
        self.widgets['refresh_button'].on_click(self._refresh_benchmark)
        self.widgets['export_button'].on_click(self._export_data)
        
        # Load initial data
        if available_benchmarks:
            self._load_benchmark_data(available_benchmarks[0])
        
        # Layout
        controls_header = widgets.HTML("<h3>🎯 Benchmark Selection</h3>")
        controls_area = widgets.HBox([
            self.widgets['benchmark_selector'],
            self.widgets['refresh_button'],
            self.widgets['view_selector'],
            self.widgets['export_button']
        ])
        
        summary_header = widgets.HTML("<h3>📊 Benchmark Summary</h3>")
        analysis_header = widgets.HTML("<h3>🔍 Detailed Analysis</h3>")
        details_header = widgets.HTML("<h3>📋 Additional Details</h3>")
        
        return widgets.VBox([
            widgets.HTML("<h2>🔍 Individual Benchmark Explorer</h2>"),
            controls_header,
            controls_area,
            summary_header,
            self.widgets['benchmark_summary'],
            analysis_header,
            self.widgets['analysis_output'],
            details_header,
            self.widgets['details_output']
        ])
    
    def _load_benchmark_data(self, benchmark_name: str):
        """Load data for specific benchmark"""
        df = self.results_manager.create_summary_dataframe()
        if df.empty:
            self.current_benchmark_data = pd.DataFrame()
            return
        
        self.current_benchmark_data = df[df['benchmark_name'] == benchmark_name].copy()
        self._update_benchmark_summary()
        self._update_analysis()
    
    def _update_benchmark_summary(self):
        """Update benchmark summary display"""
        if self.current_benchmark_data.empty:
            summary_html = "<div style='color: orange;'>⚠️ No data available for selected benchmark</div>"
        else:
            benchmark_name = self.widgets['benchmark_selector'].value
            total_runs = len(self.current_benchmark_data)
            
            # Success statistics
            overall_success = self.current_benchmark_data['success'].mean() * 100 if 'success' in self.current_benchmark_data.columns else 0
            successful_runs = self.current_benchmark_data['success'].sum() if 'success' in self.current_benchmark_data.columns else 0
            
            placement_success = self.current_benchmark_data['placementSuccess'].mean() * 100 if 'placementSuccess' in self.current_benchmark_data.columns else 0
            routing_success = self.current_benchmark_data['routingSuccess'].mean() * 100 if 'routingSuccess' in self.current_benchmark_data.columns else 0
            
            # Runtime statistics
            if 'runtime' in self.current_benchmark_data.columns:
                runtime_stats = self.current_benchmark_data['runtime'].describe()
                avg_runtime = runtime_stats['mean']
                min_runtime = runtime_stats['min']
                max_runtime = runtime_stats['max']
            else:
                avg_runtime = min_runtime = max_runtime = 0
            
            # Parameter range
            param_info = ""
            if 'connectivityFactor' in self.current_benchmark_data.columns and 'congestionFactor' in self.current_benchmark_data.columns:
                conn_range = (self.current_benchmark_data['connectivityFactor'].min(), 
                             self.current_benchmark_data['connectivityFactor'].max())
                cong_range = (self.current_benchmark_data['congestionFactor'].min(),
                             self.current_benchmark_data['congestionFactor'].max())
                param_info = f"""
                <div>
                    <b>🎛️ Parameter Ranges:</b><br>
                    • Connectivity: <b>{conn_range[0]:.1f} - {conn_range[1]:.1f}</b><br>
                    • Congestion: <b>{cong_range[0]:.1f} - {cong_range[1]:.1f}</b>
                </div>
                """
            
            # Most recent run info
            recent_run = ""
            if 'timestamp' in self.current_benchmark_data.columns:
                latest = self.current_benchmark_data.sort_values('timestamp').iloc[-1]
                recent_run = f"<br>• Last Run: <b>{latest.get('timestamp', 'Unknown')}</b>"
            
            summary_html = f"""
            <div style="background-color: #f0f8ff; padding: 15px; border-radius: 8px; border: 1px solid #ccc;">
                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                    <div>
                        <b>📁 Benchmark: {benchmark_name}</b><br>
                        • Total Runs: <b>{total_runs:,}</b>{recent_run}
                    </div>
                    <div>
                        <b>✅ Success Rates:</b><br>
                        • Overall: <b>{overall_success:.1f}%</b> ({successful_runs}/{total_runs})<br>
                        • Placement: <b>{placement_success:.1f}%</b><br>
                        • Routing: <b>{routing_success:.1f}%</b>
                    </div>
                    <div>
                        <b>⏱️ Runtime:</b><br>
                        • Average: <b>{avg_runtime:.3f}s</b><br>
                        • Range: <b>{min_runtime:.3f}s - {max_runtime:.3f}s</b>
                    </div>
                    {param_info}
                </div>
            </div>
            """
        
        self.widgets['benchmark_summary'].value = summary_html
    
    def _update_analysis(self):
        """Update analysis view based on selected view type"""
        view_type = self.widgets['view_selector'].value
        
        with self.widgets['analysis_output']:
            clear_output(wait=True)
            
            if self.current_benchmark_data.empty:
                print("⚠️ No data available for analysis")
                return
            
            if view_type == 'summary':
                self._show_summary_view()
            elif view_type == 'parameters':
                self._show_parameter_analysis()
            elif view_type == 'runtime':
                self._show_runtime_analysis()
            elif view_type == 'failures':
                self._show_failure_analysis()
            elif view_type == 'logs':
                self._show_log_view()
        
        self._update_details()
    
    def _show_summary_view(self):
        """Show summary overview"""
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(12, 8))
        
        # Success rate over time (if timestamp available)
        if 'timestamp' in self.current_benchmark_data.columns:
            time_success = self.current_benchmark_data.sort_values('timestamp').reset_index(drop=True)
            success_rolling = time_success['success'].rolling(window=min(10, len(time_success)), center=True).mean()
            
            ax1.plot(range(len(time_success)), time_success['success'], 'o-', alpha=0.6, label='Individual Runs')
            ax1.plot(range(len(time_success)), success_rolling, 'r-', linewidth=2, label='Rolling Average')
            ax1.set_xlabel('Run Number')
            ax1.set_ylabel('Success (1=Success, 0=Failure)')
            ax1.set_title('Success Rate Over Time')
            ax1.legend()
            ax1.grid(True, alpha=0.3)
        else:
            ax1.text(0.5, 0.5, 'No timestamp data available', transform=ax1.transAxes, ha='center')
        
        # Success vs failure pie chart
        if 'success' in self.current_benchmark_data.columns:
            success_counts = self.current_benchmark_data['success'].value_counts()
            colors = ['#2ecc71' if idx else '#e74c3c' for idx in success_counts.index]
            labels = ['Success' if idx else 'Failure' for idx in success_counts.index]
            
            ax2.pie(success_counts.values, labels=labels, autopct='%1.1f%%', colors=colors, startangle=90)
            ax2.set_title('Success Rate Distribution')
        
        # Runtime distribution
        if 'runtime' in self.current_benchmark_data.columns:
            ax3.hist(self.current_benchmark_data['runtime'], bins=20, edgecolor='black', alpha=0.7, color='skyblue')
            ax3.axvline(self.current_benchmark_data['runtime'].mean(), color='red', linestyle='--', 
                       label=f'Mean: {self.current_benchmark_data["runtime"].mean():.3f}s')
            ax3.set_xlabel('Runtime (seconds)')
            ax3.set_ylabel('Frequency')
            ax3.set_title('Runtime Distribution')
            ax3.legend()
        
        # Stage success comparison
        stages = []
        success_rates = []
        
        if 'success' in self.current_benchmark_data.columns:
            stages.append('Overall')
            success_rates.append(self.current_benchmark_data['success'].mean() * 100)
        
        if 'placementSuccess' in self.current_benchmark_data.columns:
            stages.append('Placement')
            success_rates.append(self.current_benchmark_data['placementSuccess'].mean() * 100)
        
        if 'routingSuccess' in self.current_benchmark_data.columns:
            stages.append('Routing')
            success_rates.append(self.current_benchmark_data['routingSuccess'].mean() * 100)
        
        if stages:
            bars = ax4.bar(stages, success_rates, color=['#3498db', '#2ecc71', '#f39c12'])
            ax4.set_ylabel('Success Rate (%)')
            ax4.set_title('Success Rate by Stage')
            ax4.set_ylim(0, 100)
            
            # Add value labels
            for bar, rate in zip(bars, success_rates):
                ax4.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 1,
                        f'{rate:.1f}%', ha='center', va='bottom')
        
        plt.tight_layout()
        plt.show()
    
    def _show_parameter_analysis(self):
        """Show parameter space analysis"""
        required_cols = ['connectivityFactor', 'congestionFactor', 'success']
        if not all(col in self.current_benchmark_data.columns for col in required_cols):
            print("⚠️ Parameter data not available for this benchmark")
            return
        
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(12, 8))
        
        # Parameter scatter plot
        successful = self.current_benchmark_data[self.current_benchmark_data['success'] == True]
        failed = self.current_benchmark_data[self.current_benchmark_data['success'] == False]
        
        if not successful.empty:
            ax1.scatter(successful['connectivityFactor'], successful['congestionFactor'], 
                       c='green', alpha=0.7, label='Success', s=50)
        if not failed.empty:
            ax1.scatter(failed['connectivityFactor'], failed['congestionFactor'], 
                       c='red', alpha=0.7, label='Failure', s=50, marker='x')
        
        ax1.set_xlabel('Connectivity Factor')
        ax1.set_ylabel('Congestion Factor')
        ax1.set_title('Parameter Space (Success/Failure)')
        ax1.legend()
        ax1.grid(True, alpha=0.3)
        
        # Success rate by connectivity factor
        conn_success = self.current_benchmark_data.groupby('connectivityFactor')['success'].agg(['count', 'mean']).reset_index()
        ax2.bar(conn_success['connectivityFactor'], conn_success['mean'] * 100, alpha=0.7)
        ax2.set_xlabel('Connectivity Factor')
        ax2.set_ylabel('Success Rate (%)')
        ax2.set_title('Success Rate by Connectivity Factor')
        ax2.set_ylim(0, 100)
        
        # Success rate by congestion factor
        cong_success = self.current_benchmark_data.groupby('congestionFactor')['success'].agg(['count', 'mean']).reset_index()
        ax3.bar(cong_success['congestionFactor'], cong_success['mean'] * 100, alpha=0.7, color='orange')
        ax3.set_xlabel('Congestion Factor')
        ax3.set_ylabel('Success Rate (%)')
        ax3.set_title('Success Rate by Congestion Factor')
        ax3.set_ylim(0, 100)
        
        # Runtime vs parameters (if both successful and failed runs exist)
        if 'runtime' in self.current_benchmark_data.columns:
            # Color by success rate
            scatter = ax4.scatter(self.current_benchmark_data['connectivityFactor'], 
                                self.current_benchmark_data['runtime'],
                                c=self.current_benchmark_data['success'], 
                                cmap='RdYlGn', alpha=0.7, s=50)
            ax4.set_xlabel('Connectivity Factor')
            ax4.set_ylabel('Runtime (seconds)')
            ax4.set_title('Runtime vs Connectivity (Green=Success)')
            plt.colorbar(scatter, ax=ax4, label='Success')
        
        plt.tight_layout()
        plt.show()
    
    def _show_runtime_analysis(self):
        """Show detailed runtime analysis"""
        if 'runtime' not in self.current_benchmark_data.columns:
            print("⚠️ No runtime data available for this benchmark")
            return
        
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(12, 8))
        
        runtime_data = self.current_benchmark_data['runtime']
        
        # Runtime histogram with statistics
        ax1.hist(runtime_data, bins=20, edgecolor='black', alpha=0.7, color='lightblue')
        ax1.axvline(runtime_data.mean(), color='red', linestyle='--', label=f'Mean: {runtime_data.mean():.3f}s')
        ax1.axvline(runtime_data.median(), color='green', linestyle='--', label=f'Median: {runtime_data.median():.3f}s')
        ax1.axvline(runtime_data.quantile(0.25), color='orange', linestyle=':', label=f'Q1: {runtime_data.quantile(0.25):.3f}s')
        ax1.axvline(runtime_data.quantile(0.75), color='orange', linestyle=':', label=f'Q3: {runtime_data.quantile(0.75):.3f}s')
        ax1.set_xlabel('Runtime (seconds)')
        ax1.set_ylabel('Frequency')
        ax1.set_title('Runtime Distribution with Statistics')
        ax1.legend()
        
        # Runtime by success status
        if 'success' in self.current_benchmark_data.columns:
            success_runtime = self.current_benchmark_data[self.current_benchmark_data['success'] == True]['runtime']
            failed_runtime = self.current_benchmark_data[self.current_benchmark_data['success'] == False]['runtime']
            
            data_to_plot = []
            labels = []
            if not success_runtime.empty:
                data_to_plot.append(success_runtime)
                labels.append('Success')
            if not failed_runtime.empty:
                data_to_plot.append(failed_runtime)
                labels.append('Failure')
            
            if data_to_plot:
                ax2.boxplot(data_to_plot, labels=labels)
                ax2.set_ylabel('Runtime (seconds)')
                ax2.set_title('Runtime by Success Status')
        
        # Runtime over time
        if 'timestamp' in self.current_benchmark_data.columns:
            time_sorted = self.current_benchmark_data.sort_values('timestamp').reset_index(drop=True)
            ax3.plot(range(len(time_sorted)), time_sorted['runtime'], 'o-', alpha=0.7)
            ax3.set_xlabel('Run Number (chronological)')
            ax3.set_ylabel('Runtime (seconds)')
            ax3.set_title('Runtime Over Time')
            ax3.grid(True, alpha=0.3)
        
        # Runtime vs parameters (if available)
        if 'connectivityFactor' in self.current_benchmark_data.columns:
            scatter = ax4.scatter(self.current_benchmark_data['connectivityFactor'], 
                                runtime_data, alpha=0.7, c=runtime_data, cmap='viridis')
            ax4.set_xlabel('Connectivity Factor')
            ax4.set_ylabel('Runtime (seconds)')
            ax4.set_title('Runtime vs Connectivity Factor')
            plt.colorbar(scatter, ax=ax4, label='Runtime (s)')
        
        plt.tight_layout()
        plt.show()
    
    def _show_failure_analysis(self):
        """Show failure analysis"""
        if 'failureType' not in self.current_benchmark_data.columns:
            print("⚠️ No failure type data available for this benchmark")
            return
        
        failure_data = self.current_benchmark_data[self.current_benchmark_data['success'] == False]
        
        if failure_data.empty:
            print("🎉 No failures found for this benchmark!")
            return
        
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
        
        # Failure type distribution
        failure_counts = failure_data['failureType'].value_counts()
        colors = plt.cm.Set3(np.linspace(0, 1, len(failure_counts)))
        
        wedges, texts, autotexts = ax1.pie(failure_counts.values, labels=failure_counts.index, 
                                          autopct='%1.1f%%', colors=colors, startangle=90)
        ax1.set_title('Failure Type Distribution')
        
        # Failure frequency bar chart
        bars = ax2.bar(range(len(failure_counts)), failure_counts.values, color=colors)
        ax2.set_xticks(range(len(failure_counts)))
        ax2.set_xticklabels(failure_counts.index, rotation=45, ha='right')
        ax2.set_ylabel('Count')
        ax2.set_title('Failure Type Frequency')
        
        # Add value labels on bars
        for bar, count in zip(bars, failure_counts.values):
            ax2.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.1,
                    str(count), ha='center', va='bottom')
        
        plt.tight_layout()
        plt.show()
        
        # Print detailed failure summary
        print("\\n📋 Detailed Failure Analysis")
        print("=" * 40)
        print(f"Total Failures: {len(failure_data)}")
        print(f"Failure Rate: {len(failure_data)/len(self.current_benchmark_data)*100:.1f}%")
        print("\\nFailure Types:")
        for failure_type, count in failure_counts.items():
            percentage = count / len(failure_data) * 100
            print(f"  • {failure_type}: {count} ({percentage:.1f}%)")
    
    def _show_log_view(self):
        """Show raw log data for selected runs"""
        print("📝 Raw Log Data View")
        print("=" * 50)
        
        # Show recent runs with their logs
        recent_runs = self.current_benchmark_data.sort_values('timestamp').tail(5) if 'timestamp' in self.current_benchmark_data.columns else self.current_benchmark_data.head(5)
        
        for i, (_, run) in enumerate(recent_runs.iterrows()):
            timestamp = run.get('timestamp', f'Run {i+1}')
            success = "✅ SUCCESS" if run.get('success', False) else "❌ FAILURE"
            runtime = f"{run.get('runtime', 0):.3f}s"
            
            print(f"\\n--- {timestamp} | {success} | Runtime: {runtime} ---")
            
            # Show stdout if available
            if 'stdout' in run and run['stdout']:
                stdout_preview = str(run['stdout'])[:500] + "..." if len(str(run['stdout'])) > 500 else str(run['stdout'])
                print("STDOUT (preview):")
                print(stdout_preview)
            
            # Show stderr if available
            if 'stderr' in run and run['stderr']:
                stderr_preview = str(run['stderr'])[:500] + "..." if len(str(run['stderr'])) > 500 else str(run['stderr'])
                print("\\nSTDERR (preview):")
                print(stderr_preview)
            
            print("\\n" + "-" * 80)
    
    def _update_details(self):
        """Update detailed information area"""
        with self.widgets['details_output']:
            clear_output(wait=True)
            
            if self.current_benchmark_data.empty:
                print("⚠️ No detailed data available")
                return
            
            print("📊 Statistical Summary")
            print("=" * 30)
            
            # Basic statistics
            total_runs = len(self.current_benchmark_data)
            print(f"Total Runs: {total_runs}")
            
            # Success statistics
            if 'success' in self.current_benchmark_data.columns:
                success_count = self.current_benchmark_data['success'].sum()
                success_rate = success_count / total_runs * 100
                print(f"Successful Runs: {success_count} ({success_rate:.1f}%)")
            
            # Runtime statistics
            if 'runtime' in self.current_benchmark_data.columns:
                runtime_stats = self.current_benchmark_data['runtime'].describe()
                print(f"\\nRuntime Statistics:")
                print(f"  Mean: {runtime_stats['mean']:.4f}s")
                print(f"  Std:  {runtime_stats['std']:.4f}s")
                print(f"  Min:  {runtime_stats['min']:.4f}s")
                print(f"  Max:  {runtime_stats['max']:.4f}s")
            
            # Parameter coverage
            if 'connectivityFactor' in self.current_benchmark_data.columns and 'congestionFactor' in self.current_benchmark_data.columns:
                unique_params = self.current_benchmark_data[['connectivityFactor', 'congestionFactor']].drop_duplicates()
                print(f"\\nParameter Configurations Tested: {len(unique_params)}")
                print(f"Connectivity Range: {self.current_benchmark_data['connectivityFactor'].min():.1f} - {self.current_benchmark_data['connectivityFactor'].max():.1f}")
                print(f"Congestion Range: {self.current_benchmark_data['congestionFactor'].min():.1f} - {self.current_benchmark_data['congestionFactor'].max():.1f}")
            
            # Best and worst runs
            if 'runtime' in self.current_benchmark_data.columns and 'success' in self.current_benchmark_data.columns:
                successful_runs = self.current_benchmark_data[self.current_benchmark_data['success'] == True]
                if not successful_runs.empty:
                    fastest_run = successful_runs.loc[successful_runs['runtime'].idxmin()]
                    print(f"\\nFastest Successful Run: {fastest_run['runtime']:.4f}s")
                    if 'connectivityFactor' in fastest_run:
                        print(f"  Parameters: conn={fastest_run['connectivityFactor']:.1f}, cong={fastest_run['congestionFactor']:.1f}")
    
    def _on_benchmark_change(self, change):
        """Handle benchmark selection change"""
        new_benchmark = change['new']
        self._load_benchmark_data(new_benchmark)
    
    def _on_view_change(self, change):
        """Handle view selection change"""
        self._update_analysis()
    
    def _refresh_benchmark(self, button):
        """Refresh current benchmark data"""
        current_benchmark = self.widgets['benchmark_selector'].value
        self.results_manager.load_historical_results()  # Reload from files
        self._load_benchmark_data(current_benchmark)
    
    def _export_data(self, button):
        """Export current benchmark data"""
        if self.current_benchmark_data.empty:
            print("⚠️ No data to export")
            return
        
        benchmark_name = self.widgets['benchmark_selector'].value
        timestamp = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        filename = f"{benchmark_name}_analysis_{timestamp}.csv"
        
        try:
            # Save to results directory
            output_path = self.results_manager.results_dir / filename
            self.current_benchmark_data.to_csv(output_path, index=False)
            print(f"✅ Data exported to: {output_path}")
        except Exception as e:
            print(f"❌ Export failed: {str(e)}")

# Create and display the benchmark explorer
try:
    if 'benchmark_explorer' in globals():
        del benchmark_explorer
    
    benchmark_explorer = BenchmarkExplorer(results_manager)
    explorer_dashboard = benchmark_explorer.create_dashboard()
    
    if explorer_dashboard:
        display(explorer_dashboard)
        print("✅ Individual Benchmark Explorer loaded successfully!")
        print("🔍 Select a benchmark and view type to explore detailed analysis.")
    else:
        print("❌ Failed to create benchmark explorer")

except Exception as e:
    print(f"❌ Benchmark explorer creation failed: {str(e)}")
    import traceback
    print("Full error:")
    print(traceback.format_exc())

# Overview Analytics Dashboard with Interactive Charts
import matplotlib.pyplot as plt
import seaborn as sns
# widgets and display already imported above
import numpy as np
import pandas as pd
from matplotlib.patches import Rectangle

class FailureAnalysisInterface:
    """Advanced failure analysis and categorization interface"""
    
    def __init__(self, results_manager: BenchmarkResultsManager):
        self.results_manager = results_manager
        self.widgets = {}
        self.failure_data = pd.DataFrame()
        self.filtered_data = pd.DataFrame()
        
    def create_dashboard(self):
        """Create the failure analysis dashboard"""
        
        # Load and process failure data
        self._load_failure_data()
        
        if self.failure_data.empty:
            return widgets.HTML("<div style='color: orange;'>⚠️ No failure data available for analysis</div>")
        
        # Filter controls
        self.widgets['failure_type_filter'] = widgets.SelectMultiple(
            options=sorted(self.failure_data['failureType'].unique()),
            value=list(self.failure_data['failureType'].unique()),
            description='Failure Types:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px', height='120px')
        )
        
        self.widgets['benchmark_filter'] = widgets.SelectMultiple(
            options=sorted(self.failure_data['benchmark_name'].unique()),
            value=list(self.failure_data['benchmark_name'].unique()),
            description='Benchmarks:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px', height='120px')
        )
        
        self.widgets['runtime_filter'] = widgets.FloatRangeSlider(
            value=[self.failure_data['runtime'].min(), self.failure_data['runtime'].max()],
            min=self.failure_data['runtime'].min(),
            max=self.failure_data['runtime'].max(),
            step=0.01,
            description='Runtime Range:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='400px')
        )
        
        # Analysis type selection
        self.widgets['analysis_type'] = widgets.Dropdown(
            options=[
                ('Failure Overview', 'overview'),
                ('Error Pattern Analysis', 'patterns'),
                ('Parameter Correlation', 'parameters'),
                ('Benchmark Comparison', 'benchmarks'),
                ('Time Series Analysis', 'timeseries'),
                ('Error Message Clustering', 'clustering')
            ],
            value='overview',
            description='Analysis Type:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px')
        )
        
        # Control buttons
        self.widgets['apply_filters_btn'] = widgets.Button(
            description='🔍 Apply Filters',
            button_style='primary',
            layout=widgets.Layout(width='150px')
        )
        
        self.widgets['reset_filters_btn'] = widgets.Button(
            description='🔄 Reset Filters',
            button_style='warning',
            layout=widgets.Layout(width='150px')
        )
        
        self.widgets['export_failures_btn'] = widgets.Button(
            description='📁 Export Failures',
            button_style='success',
            layout=widgets.Layout(width='150px')
        )
        
        # Summary display
        self.widgets['failure_summary'] = widgets.HTML(
            value="<i>Loading failure summary...</i>",
            layout=widgets.Layout(width='100%')
        )
        
        # Main analysis area
        self.widgets['analysis_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='400px')
        )
        
        # Detailed insights area
        self.widgets['insights_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='300px')
        )
        
        # Event handlers
        self.widgets['apply_filters_btn'].on_click(self._apply_filters)
        self.widgets['reset_filters_btn'].on_click(self._reset_filters)
        self.widgets['export_failures_btn'].on_click(self._export_failures)
        self.widgets['analysis_type'].observe(self._on_analysis_change, names='value')
        
        # Initial filtering and analysis
        self._apply_filters(None)
        
        # Layout
        controls_header = widgets.HTML("<h3>🎛️ Failure Analysis Controls</h3>")
        
        filter_controls = widgets.HBox([
            widgets.VBox([
                widgets.HTML("<b>Filter by Failure Type:</b>"),
                self.widgets['failure_type_filter']
            ]),
            widgets.VBox([
                widgets.HTML("<b>Filter by Benchmark:</b>"),
                self.widgets['benchmark_filter']
            ]),
            widgets.VBox([
                widgets.HTML("<b>Runtime Range:</b>"),
                self.widgets['runtime_filter'],
                widgets.HTML("<br><b>Analysis Type:</b>"),
                self.widgets['analysis_type']
            ])
        ])
        
        button_controls = widgets.HBox([
            self.widgets['apply_filters_btn'],
            self.widgets['reset_filters_btn'],
            self.widgets['export_failures_btn']
        ])
        
        summary_header = widgets.HTML("<h3>📊 Failure Summary</h3>")
        analysis_header = widgets.HTML("<h3>🔍 Detailed Analysis</h3>")
        insights_header = widgets.HTML("<h3>💡 Insights & Recommendations</h3>")
        
        return widgets.VBox([
            widgets.HTML("<h2>💥 Failure Analysis Interface</h2>"),
            controls_header,
            filter_controls,
            button_controls,
            summary_header,
            self.widgets['failure_summary'],
            analysis_header,
            self.widgets['analysis_output'],
            insights_header,
            self.widgets['insights_output']
        ])
    
    def _load_failure_data(self):
        """Load and prepare failure data"""
        df = self.results_manager.create_summary_dataframe()
        if df.empty:
            self.failure_data = pd.DataFrame()
            return
        
        # Filter only failed runs
        self.failure_data = df[df['success'] == False].copy()
        
        # Add derived columns for analysis
        if not self.failure_data.empty:
            # Categorize runtime
            if 'runtime' in self.failure_data.columns:
                self.failure_data['runtime_category'] = pd.cut(
                    self.failure_data['runtime'],
                    bins=[0, 0.1, 0.5, 2.0, float('inf')],
                    labels=['Very Fast', 'Fast', 'Medium', 'Slow']
                )
            
            # Extract error keywords from stderr
            if 'stderr' in self.failure_data.columns:
                self.failure_data['error_keywords'] = self.failure_data['stderr'].apply(self._extract_error_keywords)
                self.failure_data['error_severity'] = self.failure_data['stderr'].apply(self._classify_error_severity)
        
        print(f"📊 Loaded {len(self.failure_data)} failure records for analysis")
    
    def _extract_error_keywords(self, stderr_text):
        """Extract key error terms from stderr"""
        if pd.isna(stderr_text) or not stderr_text:
            return []
        
        # Common error patterns
        error_patterns = [
            r'ERROR[:\s]+([^\\n]+)',
            r'FATAL[:\s]+([^\\n]+)',  
            r'failed[:\s]+([^\\n]+)',
            r'timeout',
            r'out of memory',
            r'segmentation fault',
            r'assertion.*failed',
            r'cannot.*route',
            r'placement.*failed'
        ]
        
        keywords = []
        text_lower = str(stderr_text).lower()
        
        for pattern in error_patterns:
            matches = re.findall(pattern, text_lower)
            keywords.extend(matches[:2])  # Limit to first 2 matches per pattern
        
        return keywords[:5]  # Limit total keywords
    
    def _classify_error_severity(self, stderr_text):
        """Classify error severity based on content"""
        if pd.isna(stderr_text) or not stderr_text:
            return 'Unknown'
        
        text_lower = str(stderr_text).lower()
        
        if any(word in text_lower for word in ['fatal', 'segmentation', 'crash', 'abort']):
            return 'Critical'
        elif any(word in text_lower for word in ['error', 'failed', 'timeout']):
            return 'High'
        elif any(word in text_lower for word in ['warning', 'deprecated']):
            return 'Medium'
        else:
            return 'Low'
    
    def _apply_filters(self, button):
        """Apply current filters to the data"""
        if self.failure_data.empty:
            self.filtered_data = pd.DataFrame()
            return
        
        # Apply filters
        filtered = self.failure_data.copy()
        
        # Filter by failure type
        selected_failures = self.widgets['failure_type_filter'].value
        if selected_failures:
            filtered = filtered[filtered['failureType'].isin(selected_failures)]
        
        # Filter by benchmark
        selected_benchmarks = self.widgets['benchmark_filter'].value
        if selected_benchmarks:
            filtered = filtered[filtered['benchmark_name'].isin(selected_benchmarks)]
        
        # Filter by runtime range
        runtime_range = self.widgets['runtime_filter'].value
        if 'runtime' in filtered.columns:
            filtered = filtered[
                (filtered['runtime'] >= runtime_range[0]) & 
                (filtered['runtime'] <= runtime_range[1])
            ]
        
        self.filtered_data = filtered
        self._update_summary()
        self._update_analysis()
    
    def _reset_filters(self, button):
        """Reset all filters to defaults"""
        # Reset filter widgets
        self.widgets['failure_type_filter'].value = list(self.failure_data['failureType'].unique())
        self.widgets['benchmark_filter'].value = list(self.failure_data['benchmark_name'].unique())
        if 'runtime' in self.failure_data.columns:
            self.widgets['runtime_filter'].value = [
                self.failure_data['runtime'].min(),
                self.failure_data['runtime'].max()
            ]
        
        # Apply filters
        self._apply_filters(None)
    
    def _update_summary(self):
        """Update failure summary display"""
        if self.filtered_data.empty:
            summary_html = "<div style='color: orange;'>⚠️ No failures match current filters</div>"
        else:
            total_failures = len(self.filtered_data)
            unique_benchmarks = self.filtered_data['benchmark_name'].nunique()
            
            # Failure type breakdown
            failure_counts = self.filtered_data['failureType'].value_counts()
            top_failure = failure_counts.index[0] if not failure_counts.empty else 'None'
            
            # Runtime statistics
            if 'runtime' in self.filtered_data.columns:
                avg_runtime = self.filtered_data['runtime'].mean()
                median_runtime = self.filtered_data['runtime'].median()
            else:
                avg_runtime = median_runtime = 0
            
            # Most problematic benchmarks
            benchmark_failure_counts = self.filtered_data['benchmark_name'].value_counts()
            most_problematic = benchmark_failure_counts.index[0] if not benchmark_failure_counts.empty else 'None'
            
            summary_html = f"""
            <div style="background-color: #fff3cd; padding: 15px; border-radius: 8px; border: 1px solid #ffeaa7;">
                <div style="display: flex; justify-content: space-between;">
                    <div>
                        <b>💥 Failure Overview:</b><br>
                        • Total Failures: <b>{total_failures:,}</b><br>
                        • Affected Benchmarks: <b>{unique_benchmarks}</b><br>
                        • Top Failure Type: <b>{top_failure}</b> ({failure_counts.iloc[0] if not failure_counts.empty else 0})
                    </div>
                    <div>
                        <b>⏱️ Runtime Impact:</b><br>
                        • Average Runtime: <b>{avg_runtime:.3f}s</b><br>
                        • Median Runtime: <b>{median_runtime:.3f}s</b><br>
                        • Most Problematic: <b>{most_problematic}</b>
                    </div>
                    <div>
                        <b>🔍 Filter Status:</b><br>
                        • Failure Types: <b>{len(self.widgets['failure_type_filter'].value)}</b> selected<br>
                        • Benchmarks: <b>{len(self.widgets['benchmark_filter'].value)}</b> selected<br>
                        • Runtime Range: <b>{self.widgets['runtime_filter'].value[0]:.2f}s - {self.widgets['runtime_filter'].value[1]:.2f}s</b>
                    </div>
                </div>
            </div>
            """
        
        self.widgets['failure_summary'].value = summary_html
    
    def _update_analysis(self):
        """Update analysis display based on selected type"""
        analysis_type = self.widgets['analysis_type'].value
        
        with self.widgets['analysis_output']:
            clear_output(wait=True)
            
            if self.filtered_data.empty:
                print("⚠️ No failure data available for analysis")
                return
            
            plt.style.use('default')
            
            if analysis_type == 'overview':
                self._show_failure_overview()
            elif analysis_type == 'patterns':
                self._show_error_patterns()
            elif analysis_type == 'parameters':
                self._show_parameter_correlation()
            elif analysis_type == 'benchmarks':
                self._show_benchmark_comparison()
            elif analysis_type == 'timeseries':
                self._show_time_series()
            elif analysis_type == 'clustering':
                self._show_error_clustering()
            
            plt.tight_layout()
            plt.show()
        
        self._update_insights()
    
    def _show_failure_overview(self):
        """Show failure overview analysis"""
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Failure type distribution
        failure_counts = self.filtered_data['failureType'].value_counts()
        colors = plt.cm.Set3(np.linspace(0, 1, len(failure_counts)))
        
        wedges, texts, autotexts = ax1.pie(failure_counts.values, labels=failure_counts.index,
                                          autopct='%1.1f%%', colors=colors, startangle=90)
        ax1.set_title('Failure Type Distribution')
        
        # Failure frequency by benchmark (top 10)
        benchmark_failures = self.filtered_data['benchmark_name'].value_counts().head(10)
        bars1 = ax2.barh(range(len(benchmark_failures)), benchmark_failures.values)
        ax2.set_yticks(range(len(benchmark_failures)))
        ax2.set_yticklabels([name[:20] + '...' if len(name) > 20 else name 
                            for name in benchmark_failures.index], fontsize=8)
        ax2.set_xlabel('Failure Count')
        ax2.set_title('Top 10 Most Problematic Benchmarks')
        
        # Color bars by failure intensity
        max_failures = benchmark_failures.max()
        for bar, count in zip(bars1, benchmark_failures.values):
            intensity = count / max_failures
            bar.set_color(plt.cm.Reds(0.3 + intensity * 0.7))
        
        # Runtime distribution of failures
        if 'runtime' in self.filtered_data.columns:
            ax3.hist(self.filtered_data['runtime'], bins=30, edgecolor='black', alpha=0.7, color='salmon')
            ax3.axvline(self.filtered_data['runtime'].mean(), color='red', linestyle='--',
                       label=f'Mean: {self.filtered_data["runtime"].mean():.3f}s')
            ax3.set_xlabel('Runtime (seconds)')
            ax3.set_ylabel('Frequency')
            ax3.set_title('Runtime Distribution of Failed Runs')
            ax3.legend()
        
        # Error severity distribution (if available)
        if 'error_severity' in self.filtered_data.columns:
            severity_counts = self.filtered_data['error_severity'].value_counts()
            severity_colors = {'Critical': '#e74c3c', 'High': '#f39c12', 'Medium': '#f1c40f', 'Low': '#27ae60', 'Unknown': '#95a5a6'}
            colors = [severity_colors.get(sev, '#95a5a6') for sev in severity_counts.index]
            
            bars4 = ax4.bar(severity_counts.index, severity_counts.values, color=colors)
            ax4.set_ylabel('Count')
            ax4.set_title('Error Severity Distribution')
            ax4.tick_params(axis='x', rotation=45)
            
            # Add value labels
            for bar, count in zip(bars4, severity_counts.values):
                ax4.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.5,
                        str(count), ha='center', va='bottom')
    
    def _show_error_patterns(self):
        """Show error pattern analysis"""
        if 'stderr' not in self.filtered_data.columns:
            print("⚠️ No stderr data available for pattern analysis")
            return
        
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Extract common error keywords
        all_keywords = []
        for keywords in self.filtered_data['error_keywords'].dropna():
            if isinstance(keywords, list):
                all_keywords.extend(keywords)
        
        if all_keywords:
            keyword_counts = Counter(all_keywords).most_common(15)
            keywords, counts = zip(*keyword_counts)
            
            bars1 = ax1.barh(range(len(keywords)), counts)
            ax1.set_yticks(range(len(keywords)))
            ax1.set_yticklabels([kw[:30] + '...' if len(kw) > 30 else kw for kw in keywords], fontsize=8)
            ax1.set_xlabel('Frequency')
            ax1.set_title('Most Common Error Keywords')
        
        # Error message length distribution
        stderr_lengths = self.filtered_data['stderr'].dropna().str.len()
        ax2.hist(stderr_lengths, bins=30, edgecolor='black', alpha=0.7, color='lightcoral')
        ax2.set_xlabel('Error Message Length (characters)')
        ax2.set_ylabel('Frequency')
        ax2.set_title('Error Message Length Distribution')
        
        # Failure type vs runtime
        if 'runtime' in self.filtered_data.columns:
            failure_runtime = self.filtered_data.groupby('failureType')['runtime'].mean().sort_values(ascending=False)
            bars3 = ax3.bar(range(len(failure_runtime)), failure_runtime.values)
            ax3.set_xticks(range(len(failure_runtime)))
            ax3.set_xticklabels(failure_runtime.index, rotation=45, ha='right')
            ax3.set_ylabel('Average Runtime (seconds)')
            ax3.set_title('Average Runtime by Failure Type')
            
            # Color by runtime
            max_runtime = failure_runtime.max()
            for bar, runtime in zip(bars3, failure_runtime.values):
                intensity = runtime / max_runtime if max_runtime > 0 else 0
                bar.set_color(plt.cm.Oranges(0.3 + intensity * 0.7))
        
        # Error patterns over time (if timestamp available)
        if 'timestamp' in self.filtered_data.columns:
            # Group failures by date and failure type
            self.filtered_data['date'] = pd.to_datetime(self.filtered_data['timestamp'], errors='coerce').dt.date
            daily_failures = self.filtered_data.groupby(['date', 'failureType']).size().unstack(fill_value=0)
            
            if not daily_failures.empty:
                daily_failures.plot(kind='area', stacked=True, ax=ax4, alpha=0.7)
                ax4.set_xlabel('Date')
                ax4.set_ylabel('Failure Count')
                ax4.set_title('Failure Patterns Over Time')
                ax4.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
        else:
            ax4.text(0.5, 0.5, 'No timestamp data available', transform=ax4.transAxes, ha='center')
    
    def _show_parameter_correlation(self):
        """Show parameter correlation with failures"""
        required_cols = ['connectivityFactor', 'congestionFactor']
        if not all(col in self.filtered_data.columns for col in required_cols):
            print("⚠️ Parameter data not available")
            return
        
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Parameter scatter plot colored by failure type
        failure_types = self.filtered_data['failureType'].unique()
        colors = plt.cm.Set3(np.linspace(0, 1, len(failure_types)))
        
        for i, failure_type in enumerate(failure_types):
            subset = self.filtered_data[self.filtered_data['failureType'] == failure_type]
            ax1.scatter(subset['connectivityFactor'], subset['congestionFactor'],
                       c=[colors[i]], label=failure_type, alpha=0.7, s=50)
        
        ax1.set_xlabel('Connectivity Factor')
        ax1.set_ylabel('Congestion Factor')
        ax1.set_title('Failure Distribution in Parameter Space')
        ax1.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
        ax1.grid(True, alpha=0.3)
        
        # Failure rate heatmap
        param_failures = self.filtered_data.groupby(['connectivityFactor', 'congestionFactor']).size()
        total_df = self.results_manager.create_summary_dataframe()
        param_totals = total_df.groupby(['connectivityFactor', 'congestionFactor']).size()
        
        failure_rates = (param_failures / param_totals).fillna(0)
        failure_rate_matrix = failure_rates.unstack(fill_value=0)
        
        if not failure_rate_matrix.empty:
            sns.heatmap(failure_rate_matrix, annot=True, fmt='.2f', cmap='Reds', ax=ax2,
                       cbar_kws={'label': 'Failure Rate'})
            ax2.set_title('Failure Rate Heatmap')
            ax2.set_xlabel('Connectivity Factor')
            ax2.set_ylabel('Congestion Factor')
        
        # Connectivity factor failure distribution
        conn_failures = self.filtered_data.groupby('connectivityFactor')['failureType'].value_counts().unstack(fill_value=0)
        conn_failures.plot(kind='bar', stacked=True, ax=ax3, color=colors[:len(conn_failures.columns)])
        ax3.set_xlabel('Connectivity Factor')
        ax3.set_ylabel('Failure Count')
        ax3.set_title('Failures by Connectivity Factor')
        ax3.tick_params(axis='x', rotation=0)
        
        # Congestion factor failure distribution  
        cong_failures = self.filtered_data.groupby('congestionFactor')['failureType'].value_counts().unstack(fill_value=0)
        cong_failures.plot(kind='bar', stacked=True, ax=ax4, color=colors[:len(cong_failures.columns)])
        ax4.set_xlabel('Congestion Factor')
        ax4.set_ylabel('Failure Count')
        ax4.set_title('Failures by Congestion Factor')
        ax4.tick_params(axis='x', rotation=0)
    
    def _show_benchmark_comparison(self):
        """Show benchmark failure comparison"""
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Top failing benchmarks
        benchmark_failures = self.filtered_data['benchmark_name'].value_counts().head(15)
        bars1 = ax1.barh(range(len(benchmark_failures)), benchmark_failures.values)
        ax1.set_yticks(range(len(benchmark_failures)))
        ax1.set_yticklabels([name[:25] + '...' if len(name) > 25 else name 
                            for name in benchmark_failures.index], fontsize=8)
        ax1.set_xlabel('Failure Count')
        ax1.set_title('Top 15 Benchmarks by Failure Count')
        
        # Color bars by intensity
        max_failures = benchmark_failures.max()
        for bar, count in zip(bars1, benchmark_failures.values):
            intensity = count / max_failures
            bar.set_color(plt.cm.Reds(0.3 + intensity * 0.7))
        
        # Failure type distribution by top benchmarks
        top_benchmarks = benchmark_failures.head(8).index
        top_benchmark_failures = self.filtered_data[
            self.filtered_data['benchmark_name'].isin(top_benchmarks)
        ]
        
        failure_matrix = top_benchmark_failures.groupby(['benchmark_name', 'failureType']).size().unstack(fill_value=0)
        failure_matrix.plot(kind='bar', stacked=True, ax=ax2, figsize=(10, 6))
        ax2.set_xlabel('Benchmark')
        ax2.set_ylabel('Failure Count')
        ax2.set_title('Failure Types by Top Benchmarks')
        ax2.tick_params(axis='x', rotation=45, labelsize=8)
        ax2.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
        
        # Runtime vs failure count scatter
        if 'runtime' in self.filtered_data.columns:
            benchmark_stats = self.filtered_data.groupby('benchmark_name').agg({
                'runtime': 'mean',
                'benchmark_name': 'count'
            }).rename(columns={'benchmark_name': 'failure_count'})
            
            scatter = ax3.scatter(benchmark_stats['failure_count'], benchmark_stats['runtime'],
                                alpha=0.7, c=benchmark_stats['failure_count'], cmap='Reds', s=60)
            ax3.set_xlabel('Failure Count')
            ax3.set_ylabel('Average Runtime (seconds)')
            ax3.set_title('Failure Count vs Average Runtime')
            plt.colorbar(scatter, ax=ax3, label='Failure Count')
        
        # Benchmark failure rate (if total data available)
        total_df = self.results_manager.create_summary_dataframe()
        if not total_df.empty:
            benchmark_totals = total_df['benchmark_name'].value_counts()
            benchmark_failure_rates = (benchmark_failures / benchmark_totals * 100).dropna().sort_values(ascending=False).head(12)
            
            bars4 = ax4.bar(range(len(benchmark_failure_rates)), benchmark_failure_rates.values)
            ax4.set_xticks(range(len(benchmark_failure_rates)))
            ax4.set_xticklabels([name[:15] + '...' if len(name) > 15 else name 
                               for name in benchmark_failure_rates.index], rotation=45, ha='right', fontsize=8)
            ax4.set_ylabel('Failure Rate (%)')
            ax4.set_title('Top 12 Benchmarks by Failure Rate')
            
            # Color by failure rate
            max_rate = benchmark_failure_rates.max()
            for bar, rate in zip(bars4, benchmark_failure_rates.values):
                intensity = rate / max_rate if max_rate > 0 else 0
                bar.set_color(plt.cm.Reds(0.3 + intensity * 0.7))
    
    def _show_time_series(self):
        """Show time series analysis of failures"""
        if 'timestamp' not in self.filtered_data.columns:
            print("⚠️ No timestamp data available for time series analysis")
            return
        
        # Convert timestamp to datetime
        self.filtered_data['datetime'] = pd.to_datetime(self.filtered_data['timestamp'], errors='coerce')
        valid_timestamps = self.filtered_data.dropna(subset=['datetime'])
        
        if valid_timestamps.empty:
            print("⚠️ No valid timestamps found")
            return
        
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Daily failure trend
        daily_failures = valid_timestamps.groupby(valid_timestamps['datetime'].dt.date).size()
        ax1.plot(daily_failures.index, daily_failures.values, 'o-', linewidth=2, markersize=6)
        ax1.set_xlabel('Date')
        ax1.set_ylabel('Failure Count')
        ax1.set_title('Daily Failure Trend')
        ax1.grid(True, alpha=0.3)
        ax1.tick_params(axis='x', rotation=45)
        
        # Hourly failure pattern
        valid_timestamps['hour'] = valid_timestamps['datetime'].dt.hour
        hourly_failures = valid_timestamps.groupby('hour').size()
        ax2.bar(hourly_failures.index, hourly_failures.values, alpha=0.7, color='coral')
        ax2.set_xlabel('Hour of Day')
        ax2.set_ylabel('Failure Count')
        ax2.set_title('Failure Pattern by Hour')
        ax2.set_xticks(range(0, 24, 2))
        
        # Failure type evolution over time
        failure_evolution = valid_timestamps.groupby([valid_timestamps['datetime'].dt.date, 'failureType']).size().unstack(fill_value=0)
        failure_evolution.plot(kind='area', stacked=True, ax=ax3, alpha=0.7)
        ax3.set_xlabel('Date')
        ax3.set_ylabel('Failure Count')
        ax3.set_title('Failure Type Evolution Over Time')
        ax3.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
        ax3.tick_params(axis='x', rotation=45)
        
        # Recent failure trend (last 30 data points)
        recent_failures = valid_timestamps.sort_values('datetime').tail(30)
        recent_daily = recent_failures.groupby(recent_failures['datetime'].dt.date).size()
        
        ax4.plot(recent_daily.index, recent_daily.values, 'o-', color='red', linewidth=2, markersize=6)
        ax4.set_xlabel('Date')
        ax4.set_ylabel('Failure Count')
        ax4.set_title('Recent Failure Trend (Last 30 points)')
        ax4.grid(True, alpha=0.3)
        ax4.tick_params(axis='x', rotation=45)
    
    def _show_error_clustering(self):
        """Show error message clustering analysis"""
        if 'stderr' not in self.filtered_data.columns:
            print("⚠️ No stderr data available for clustering")
            return
        
        print("📊 Error Message Clustering Analysis")
        print("=" * 50)
        
        # Analyze error message patterns
        error_messages = self.filtered_data['stderr'].dropna()
        
        if error_messages.empty:
            print("⚠️ No error messages to analyze")
            return
        
        # Group similar error messages
        error_patterns = {}
        
        for msg in error_messages:
            msg_str = str(msg)
            # Extract key patterns
            key_patterns = []
            
            if 'timeout' in msg_str.lower():
                key_patterns.append('Timeout')
            if 'memory' in msg_str.lower():
                key_patterns.append('Memory')
            if 'route' in msg_str.lower():
                key_patterns.append('Routing')
            if 'place' in msg_str.lower():
                key_patterns.append('Placement')
            if 'synthesis' in msg_str.lower():
                key_patterns.append('Synthesis')
            if any(word in msg_str.lower() for word in ['error', 'failed', 'cannot']):
                key_patterns.append('General Error')
            
            pattern_key = ', '.join(key_patterns) if key_patterns else 'Uncategorized'
            error_patterns[pattern_key] = error_patterns.get(pattern_key, 0) + 1
        
        # Display clustering results
        sorted_patterns = sorted(error_patterns.items(), key=lambda x: x[1], reverse=True)
        
        print("🔍 Error Pattern Clusters:")
        for i, (pattern, count) in enumerate(sorted_patterns[:10], 1):
            percentage = count / len(error_messages) * 100
            print(f"  {i}. {pattern}: {count} occurrences ({percentage:.1f}%)")
        
        # Show example messages for top patterns
        print("\\n📝 Example Error Messages:")
        for pattern, _ in sorted_patterns[:3]:
            print(f"\\n--- {pattern} Examples ---")
            pattern_examples = []
            
            for msg in error_messages:
                msg_str = str(msg)
                if pattern == 'Uncategorized':
                    if not any(word in msg_str.lower() for word in ['timeout', 'memory', 'route', 'place', 'synthesis', 'error', 'failed', 'cannot']):
                        pattern_examples.append(msg_str[:200] + "..." if len(msg_str) > 200 else msg_str)
                else:
                    pattern_words = pattern.lower().split(', ')
                    if any(word.lower() in msg_str.lower() for word in pattern_words):
                        pattern_examples.append(msg_str[:200] + "..." if len(msg_str) > 200 else msg_str)
                
                if len(pattern_examples) >= 2:  # Limit examples
                    break
            
            for j, example in enumerate(pattern_examples, 1):
                print(f"  Example {j}: {example}")
        
        # Create visualization
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))
        
        # Pattern frequency
        patterns, counts = zip(*sorted_patterns[:8])
        bars1 = ax1.barh(range(len(patterns)), counts)
        ax1.set_yticks(range(len(patterns)))
        ax1.set_yticklabels([p[:30] + '...' if len(p) > 30 else p for p in patterns], fontsize=10)
        ax1.set_xlabel('Frequency')
        ax1.set_title('Error Pattern Clusters')
        
        # Color bars by frequency
        max_count = max(counts)
        for bar, count in zip(bars1, counts):
            intensity = count / max_count
            bar.set_color(plt.cm.Reds(0.3 + intensity * 0.7))
        
        # Pie chart of pattern distribution
        colors = plt.cm.Set3(np.linspace(0, 1, len(sorted_patterns[:6])))
        other_count = sum(count for _, count in sorted_patterns[6:])
        
        pie_data = [count for _, count in sorted_patterns[:6]]
        pie_labels = [pattern[:20] + '...' if len(pattern) > 20 else pattern for pattern, _ in sorted_patterns[:6]]
        
        if other_count > 0:
            pie_data.append(other_count)
            pie_labels.append('Other')
        
        ax2.pie(pie_data, labels=pie_labels, autopct='%1.1f%%', colors=colors, startangle=90)
        ax2.set_title('Error Pattern Distribution')
        
        plt.tight_layout()
        plt.show()
    
    def _update_insights(self):
        """Update insights and recommendations"""
        with self.widgets['insights_output']:
            clear_output(wait=True)
            
            if self.filtered_data.empty:
                print("⚠️ No data available for insights")
                return
            
            print("💡 Failure Analysis Insights & Recommendations")
            print("=" * 60)
            
            # Key statistics
            total_failures = len(self.filtered_data)
            unique_benchmarks = self.filtered_data['benchmark_name'].nunique()
            
            print(f"📊 Summary Statistics:")
            print(f"  • Total Failures Analyzed: {total_failures:,}")
            print(f"  • Affected Benchmarks: {unique_benchmarks}")
            
            # Top failure types
            failure_counts = self.filtered_data['failureType'].value_counts()
            print(f"\\n🎯 Primary Failure Types:")
            for i, (failure_type, count) in enumerate(failure_counts.head(3).items(), 1):
                percentage = count / total_failures * 100
                print(f"  {i}. {failure_type}: {count} failures ({percentage:.1f}%)")
            
            # Most problematic benchmarks
            benchmark_failures = self.filtered_data['benchmark_name'].value_counts().head(5)
            print(f"\\n🚨 Most Problematic Benchmarks:")
            for i, (benchmark, count) in enumerate(benchmark_failures.items(), 1):
                print(f"  {i}. {benchmark}: {count} failures")
            
            # Parameter insights
            if all(col in self.filtered_data.columns for col in ['connectivityFactor', 'congestionFactor']):
                print(f"\\n🎛️ Parameter Analysis:")
                
                # Most problematic parameter ranges
                param_failures = self.filtered_data.groupby(['connectivityFactor', 'congestionFactor']).size()
                worst_params = param_failures.sort_values(ascending=False).head(3)
                
                print(f"  Most problematic parameter combinations:")
                for i, ((conn, cong), count) in enumerate(worst_params.items(), 1):
                    print(f"    {i}. Connectivity={conn:.1f}, Congestion={cong:.1f}: {count} failures")
            
            # Runtime insights
            if 'runtime' in self.filtered_data.columns:
                avg_failure_runtime = self.filtered_data['runtime'].mean()
                print(f"\\n⏱️ Runtime Analysis:")
                print(f"  • Average failure runtime: {avg_failure_runtime:.3f}s")
                
                # Compare with successful runs
                total_df = self.results_manager.create_summary_dataframe()
                if not total_df.empty:
                    success_df = total_df[total_df['success'] == True]
                    if not success_df.empty and 'runtime' in success_df.columns:
                        avg_success_runtime = success_df['runtime'].mean()
                        runtime_impact = ((avg_failure_runtime / avg_success_runtime) - 1) * 100
                        print(f"  • Failed runs are {runtime_impact:+.1f}% slower than successful runs")
            
            # Recommendations
            print(f"\\n🔧 Recommendations:")
            
            # Based on failure types
            top_failure = failure_counts.index[0] if not failure_counts.empty else None
            if top_failure == 'routing':
                print(f"  1. Focus on routing optimization - consider adjusting congestion factors")
            elif top_failure == 'placement':
                print(f"  1. Review placement constraints and connectivity factors")
            elif top_failure == 'synthesis':
                print(f"  1. Investigate synthesis issues - check for unsupported constructs")
            else:
                print(f"  1. Investigate {top_failure} failures as the primary concern")
            
            # Based on benchmarks
            if unique_benchmarks < 5:
                print(f"  2. Consider expanding benchmark coverage for better analysis")
            else:
                worst_benchmark = benchmark_failures.index[0] if not benchmark_failures.empty else None
                if worst_benchmark:
                    print(f"  2. Prioritize fixing issues with '{worst_benchmark}' benchmark")
            
            # Based on parameters
            if all(col in self.filtered_data.columns for col in ['connectivityFactor', 'congestionFactor']):
                conn_var = self.filtered_data['connectivityFactor'].var()
                cong_var = self.filtered_data['congestionFactor'].var()
                
                if conn_var > cong_var:
                    print(f"  3. Connectivity factor shows more variance in failures - focus optimization here")
                else:
                    print(f"  3. Congestion factor shows more variance in failures - focus optimization here")
            
            print(f"\\n📈 Next Steps:")
            print(f"  • Use the Individual Benchmark Explorer to deep-dive into problematic benchmarks")
            print(f"  • Run targeted parameter sweeps on failing configurations")
            print(f"  • Consider infrastructure improvements if runtime is consistently high")
            print(f"  • Export failure data for further offline analysis")
    
    def _on_analysis_change(self, change):
        """Handle analysis type change"""
        self._update_analysis()
    
    def _export_failures(self, button):
        """Export filtered failure data"""
        if self.filtered_data.empty:
            print("⚠️ No failure data to export")
            return
        
        timestamp = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        filename = f"failure_analysis_{timestamp}.csv"
        
        try:
            output_path = self.results_manager.results_dir / filename
            self.filtered_data.to_csv(output_path, index=False)
            print(f"✅ Failure data exported to: {output_path}")
        except Exception as e:
            print(f"❌ Export failed: {str(e)}")

# Create and display the failure analysis interface
try:
    if 'failure_analyzer' in globals():
        del failure_analyzer
    
    failure_analyzer = FailureAnalysisInterface(results_manager)
    failure_dashboard = failure_analyzer.create_dashboard()
    
    if failure_dashboard:
        display(failure_dashboard)
        print("✅ Failure Analysis Interface loaded successfully!")
        print("💥 Use filters to narrow down failures and select different analysis types.")
    else:
        print("❌ Failed to create failure analysis interface")

except Exception as e:
    print(f"❌ Failure analysis interface creation failed: {str(e)}")
    import traceback
    print("Full error:")
    print(traceback.format_exc())

# Individual Benchmark Explorer with Detailed Analysis
# widgets and display already imported above, HTML
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

class AdvancedVisualizationInterface:
    """Advanced visualization and analytics interface for comprehensive analysis"""
    
    def __init__(self, results_manager: BenchmarkResultsManager):
        self.results_manager = results_manager
        self.widgets = {}
        self.data = pd.DataFrame()
        
    def create_dashboard(self):
        """Create the advanced visualization dashboard"""
        
        # Load and prepare data
        self._load_data()
        
        if self.data.empty:
            return widgets.HTML("<div style='color: orange;'>⚠️ No data available for advanced visualization</div>")
        
        # Visualization type selection
        self.widgets['viz_type'] = widgets.Dropdown(
            options=[
                ('Performance Optimization Map', 'performance_map'),
                ('Multi-dimensional Analysis', 'multidim'),
                ('Predictive Success Modeling', 'predictive'),
                ('Benchmark Clustering', 'clustering'),
                ('Interactive Parameter Explorer', 'interactive_params'),
                ('Time-based Performance Trends', 'time_trends'),
                ('Correlation Network Analysis', 'correlation_network'),
                ('Statistical Distribution Analysis', 'statistical_dist')
            ],
            value='performance_map',
            description='Visualization:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='350px')
        )
        
        # Data filtering options
        self.widgets['success_filter'] = widgets.Dropdown(
            options=[('All Data', 'all'), ('Successful Only', 'success'), ('Failed Only', 'failed')],
            value='all',
            description='Success Filter:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='250px')
        )
        
        self.widgets['sample_size'] = widgets.IntSlider(
            value=min(1000, len(self.data)),
            min=100,
            max=len(self.data),
            step=100,
            description='Sample Size:',
            style={'description_width': 'initial'},
            layout=widgets.Layout(width='300px')
        )
        
        # Control buttons
        self.widgets['generate_viz_btn'] = widgets.Button(
            description='🎨 Generate Visualization',
            button_style='primary',
            layout=widgets.Layout(width='200px')
        )
        
        self.widgets['export_viz_btn'] = widgets.Button(
            description='💾 Export Analysis',
            button_style='success',
            layout=widgets.Layout(width='150px')
        )
        
        # Analysis output
        self.widgets['viz_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='600px')
        )
        
        # Insights output
        self.widgets['insights_output'] = widgets.Output(
            layout=widgets.Layout(width='100%', height='300px')
        )
        
        # Event handlers
        self.widgets['generate_viz_btn'].on_click(self._generate_visualization)
        self.widgets['export_viz_btn'].on_click(self._export_analysis)
        self.widgets['viz_type'].observe(self._on_viz_change, names='value')
        
        # Initial visualization
        self._generate_visualization(None)
        
        # Layout
        controls_header = widgets.HTML("<h3>🎛️ Advanced Visualization Controls</h3>")
        controls_area = widgets.HBox([
            self.widgets['viz_type'],
            self.widgets['success_filter'],
            self.widgets['sample_size'],
            self.widgets['generate_viz_btn'],
            self.widgets['export_viz_btn']
        ])
        
        viz_header = widgets.HTML("<h3>📊 Advanced Visualization</h3>")
        insights_header = widgets.HTML("<h3>🧠 Advanced Insights</h3>")
        
        return widgets.VBox([
            widgets.HTML("<h2>🚀 Advanced Visualizations & Analytics</h2>"),
            controls_header,
            controls_area,
            viz_header,
            self.widgets['viz_output'],
            insights_header,
            self.widgets['insights_output']
        ])
    
    def _load_data(self):
        """Load and prepare data for analysis"""
        self.data = self.results_manager.create_summary_dataframe()
        
        # Add derived features for analysis
        if not self.data.empty:
            # Performance score (inverse of runtime for successful runs)
            self.data['performance_score'] = np.where(
                self.data['success'] == True,
                1.0 / (self.data['runtime'] + 1e-6),  # Add small epsilon to avoid division by zero
                0.0
            )
            
            # Efficiency metric (success rate / runtime)
            benchmark_stats = self.data.groupby('benchmark_name').agg({
                'success': ['mean', 'count'],
                'runtime': 'mean'
            }).round(4)
            
            benchmark_stats.columns = ['success_rate', 'total_runs', 'avg_runtime']
            benchmark_stats['efficiency'] = benchmark_stats['success_rate'] / (benchmark_stats['avg_runtime'] + 1e-6)
            
            # Merge back to main dataset
            self.data = self.data.merge(
                benchmark_stats[['efficiency']], 
                left_on='benchmark_name', 
                right_index=True, 
                how='left'
            )
        
        print(f"📊 Loaded {len(self.data)} records for advanced visualization")
    
    def _filter_data(self):
        """Apply current filters to the data"""
        filtered_data = self.data.copy()
        
        # Apply success filter
        success_filter = self.widgets['success_filter'].value
        if success_filter == 'success':
            filtered_data = filtered_data[filtered_data['success'] == True]
        elif success_filter == 'failed':
            filtered_data = filtered_data[filtered_data['success'] == False]
        
        # Apply sampling
        sample_size = self.widgets['sample_size'].value
        if len(filtered_data) > sample_size:
            filtered_data = filtered_data.sample(n=sample_size, random_state=42)
        
        return filtered_data
    
    def _generate_visualization(self, button):
        """Generate the selected visualization"""
        viz_type = self.widgets['viz_type'].value
        
        with self.widgets['viz_output']:
            clear_output(wait=True)
            
            filtered_data = self._filter_data()
            
            if filtered_data.empty:
                print("⚠️ No data available after filtering")
                return
            
            try:
                if viz_type == 'performance_map':
                    self._show_performance_map(filtered_data)
                elif viz_type == 'multidim':
                    self._show_multidimensional_analysis(filtered_data)
                elif viz_type == 'predictive':
                    self._show_predictive_modeling(filtered_data)
                elif viz_type == 'clustering':
                    self._show_benchmark_clustering(filtered_data)
                elif viz_type == 'interactive_params':
                    self._show_interactive_parameters(filtered_data)
                elif viz_type == 'time_trends':
                    self._show_time_trends(filtered_data)
                elif viz_type == 'correlation_network':
                    self._show_correlation_network(filtered_data)
                elif viz_type == 'statistical_dist':
                    self._show_statistical_distributions(filtered_data)
                
            except Exception as e:
                print(f"❌ Visualization error: {str(e)}")
                import traceback
                print("Error details:", traceback.format_exc())
        
        self._generate_insights(filtered_data)
    
    def _show_performance_map(self, data):
        """Show performance optimization map"""
        print("🗺️ Performance Optimization Map")
        print("=" * 40)
        
        if not all(col in data.columns for col in ['connectivityFactor', 'congestionFactor', 'success', 'runtime']):
            print("⚠️ Required columns not available for performance map")
            return
        
        # Create performance heatmap
        param_performance = data.groupby(['connectivityFactor', 'congestionFactor']).agg({
            'success': ['mean', 'count'],
            'runtime': 'mean',
            'performance_score': 'mean'
        }).round(3)
        
        param_performance.columns = ['success_rate', 'total_runs', 'avg_runtime', 'performance_score']
        param_performance = param_performance.reset_index()
        
        # Filter out parameter combinations with too few samples
        param_performance = param_performance[param_performance['total_runs'] >= 3]
        
        if param_performance.empty:
            print("⚠️ Insufficient data for performance map")
            return
        
        fig = make_subplots(
            rows=2, cols=2,
            subplot_titles=[
                'Success Rate Heatmap',
                'Average Runtime Heatmap', 
                'Performance Score Heatmap',
                'Sample Count Heatmap'
            ]
        )
        
        # Success rate heatmap
        success_pivot = param_performance.pivot(
            index='congestionFactor', 
            columns='connectivityFactor', 
            values='success_rate'
        )
        
        fig.add_trace(
            go.Heatmap(
                z=success_pivot.values,
                x=success_pivot.columns,
                y=success_pivot.index,
                colorscale='RdYlGn',
                name='Success Rate',
                showscale=False
            ),
            row=1, col=1
        )
        
        # Runtime heatmap
        runtime_pivot = param_performance.pivot(
            index='congestionFactor',
            columns='connectivityFactor', 
            values='avg_runtime'
        )
        
        fig.add_trace(
            go.Heatmap(
                z=runtime_pivot.values,
                x=runtime_pivot.columns,
                y=runtime_pivot.index,
                colorscale='Viridis',
                name='Avg Runtime',
                showscale=False
            ),
            row=1, col=2
        )
        
        # Performance score heatmap
        perf_pivot = param_performance.pivot(
            index='congestionFactor',
            columns='connectivityFactor',
            values='performance_score'
        )
        
        fig.add_trace(
            go.Heatmap(
                z=perf_pivot.values,
                x=perf_pivot.columns,
                y=perf_pivot.index,
                colorscale='Plasma',
                name='Performance Score',
                showscale=False
            ),
            row=2, col=1
        )
        
        # Sample count heatmap
        count_pivot = param_performance.pivot(
            index='congestionFactor',
            columns='connectivityFactor',
            values='total_runs'
        )
        
        fig.add_trace(
            go.Heatmap(
                z=count_pivot.values,
                x=count_pivot.columns,
                y=count_pivot.index,
                colorscale='Blues',
                name='Sample Count',
                showscale=False
            ),
            row=2, col=2
        )
        
        fig.update_layout(
            title='Performance Optimization Map - Parameter Space Analysis',
            height=800,
            showlegend=False
        )
        
        # Update axes labels
        fig.update_xaxes(title_text='Connectivity Factor')
        fig.update_yaxes(title_text='Congestion Factor')
        
        fig.show()
        
        # Find optimal parameters
        best_performance = param_performance.loc[param_performance['performance_score'].idxmax()]
        print(f"\\n🎯 Optimal Parameters (Best Performance):")
        print(f"  • Connectivity: {best_performance['connectivityFactor']:.1f}")
        print(f"  • Congestion: {best_performance['congestionFactor']:.1f}")
        print(f"  • Success Rate: {best_performance['success_rate']*100:.1f}%")
        print(f"  • Average Runtime: {best_performance['avg_runtime']:.3f}s")
        print(f"  • Performance Score: {best_performance['performance_score']:.3f}")
    
    def _show_multidimensional_analysis(self, data):
        """Show multi-dimensional analysis using parallel coordinates"""
        print("📐 Multi-dimensional Analysis")
        print("=" * 40)
        
        # Select numeric columns for analysis
        numeric_cols = data.select_dtypes(include=[np.number]).columns.tolist()
        
        # Remove ID-like columns
        exclude_cols = ['timestamp', 'returnCode']
        analysis_cols = [col for col in numeric_cols if col not in exclude_cols][:8]  # Limit to 8 dimensions
        
        if len(analysis_cols) < 3:
            print("⚠️ Insufficient numeric columns for multi-dimensional analysis")
            return
        
        # Sample data for visualization
        viz_data = data[analysis_cols + ['success', 'benchmark_name']].dropna()
        if len(viz_data) > 500:
            viz_data = viz_data.sample(n=500, random_state=42)
        
        # Create parallel coordinates plot
        fig = go.Figure(data=
            go.Parcoords(
                line=dict(
                    color=viz_data['success'].astype(int),
                    colorscale=[[0, 'red'], [1, 'green']],
                    showscale=True,
                    colorbar=dict(title="Success")
                ),
                dimensions=list([
                    dict(
                        range=[viz_data[col].min(), viz_data[col].max()],
                        label=col.replace('_', ' ').title(),
                        values=viz_data[col]
                    ) for col in analysis_cols
                ])
            )
        )
        
        fig.update_layout(
            title='Multi-dimensional Analysis - Parallel Coordinates Plot',
            height=600
        )
        
        fig.show()
        
        # Correlation analysis
        correlation_matrix = viz_data[analysis_cols].corr()
        
        plt.figure(figsize=(10, 8))
        sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', center=0,
                   square=True, linewidths=0.5)
        plt.title('Feature Correlation Matrix')
        plt.tight_layout()
        plt.show()
        
        # Principal Component Analysis
        try:
            from sklearn.decomposition import PCA
            
            # Standardize the data
            scaler = StandardScaler()
            scaled_data = scaler.fit_transform(viz_data[analysis_cols])
            
            # Apply PCA
            pca = PCA(n_components=min(3, len(analysis_cols)))
            pca_result = pca.fit_transform(scaled_data)
            
            # Create 3D scatter plot if we have 3+ components
            if pca_result.shape[1] >= 3:
                fig = go.Figure(data=go.Scatter3d(
                    x=pca_result[:, 0],
                    y=pca_result[:, 1],
                    z=pca_result[:, 2],
                    mode='markers',
                    marker=dict(
                        color=viz_data['success'].astype(int),
                        colorscale=[[0, 'red'], [1, 'green']],
                        size=5
                    ),
                    text=viz_data['benchmark_name'],
                    hovertemplate='<b>%{text}</b><br>' +
                                  'PC1: %{x:.2f}<br>' +
                                  'PC2: %{y:.2f}<br>' +
                                  'PC3: %{z:.2f}<extra></extra>'
                ))
                
                fig.update_layout(
                    title='PCA Analysis - 3D Projection',
                    scene=dict(
                        xaxis_title=f'PC1 ({pca.explained_variance_ratio_[0]*100:.1f}%)',
                        yaxis_title=f'PC2 ({pca.explained_variance_ratio_[1]*100:.1f}%)',
                        zaxis_title=f'PC3 ({pca.explained_variance_ratio_[2]*100:.1f}%)' if len(pca.explained_variance_ratio_) > 2 else 'PC3'
                    ),
                    height=600
                )
                
                fig.show()
            
            print(f"\\n📊 PCA Results:")
            for i, variance in enumerate(pca.explained_variance_ratio_):
                print(f"  • PC{i+1}: {variance*100:.1f}% of variance")
            print(f"  • Total explained variance: {sum(pca.explained_variance_ratio_)*100:.1f}%")
            
        except ImportError:
            print("⚠️ scikit-learn not available for PCA analysis")
    
    def _show_predictive_modeling(self, data):
        """Show predictive success modeling"""
        print("🔮 Predictive Success Modeling")
        print("=" * 40)
        
        # Prepare features for modeling
        feature_cols = ['connectivityFactor', 'congestionFactor', 'runtime']
        if not all(col in data.columns for col in feature_cols):
            print("⚠️ Required features not available for predictive modeling")
            return
        
        model_data = data[feature_cols + ['success']].dropna()
        
        if len(model_data) < 50:
            print("⚠️ Insufficient data for predictive modeling")
            return
        
        try:
            from sklearn.model_selection import train_test_split
            from sklearn.ensemble import RandomForestClassifier
            from sklearn.metrics import classification_report, confusion_matrix
            from sklearn.preprocessing import StandardScaler
            
            X = model_data[feature_cols]
            y = model_data['success']
            
            # Split data
            X_train, X_test, y_train, y_test = train_test_split(
                X, y, test_size=0.3, random_state=42, stratify=y
            )
            
            # Scale features
            scaler = StandardScaler()
            X_train_scaled = scaler.fit_transform(X_train)
            X_test_scaled = scaler.transform(X_test)
            
            # Train Random Forest model
            rf_model = RandomForestClassifier(n_estimators=100, random_state=42)
            rf_model.fit(X_train_scaled, y_train)
            
            # Make predictions
            y_pred = rf_model.predict(X_test_scaled)
            y_pred_proba = rf_model.predict_proba(X_test_scaled)[:, 1]
            
            # Feature importance
            feature_importance = pd.DataFrame({
                'feature': feature_cols,
                'importance': rf_model.feature_importances_
            }).sort_values('importance', ascending=False)
            
            # Visualizations
            fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(15, 10))
            
            # Feature importance
            bars = ax1.bar(feature_importance['feature'], feature_importance['importance'])
            ax1.set_title('Feature Importance for Success Prediction')
            ax1.set_ylabel('Importance')
            ax1.tick_params(axis='x', rotation=45)
            
            # Color bars by importance
            max_importance = feature_importance['importance'].max()
            for bar, importance in zip(bars, feature_importance['importance']):
                intensity = importance / max_importance
                bar.set_color(plt.cm.Greens(0.3 + intensity * 0.7))
            
            # Confusion Matrix
            cm = confusion_matrix(y_test, y_pred)
            sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', ax=ax2,
                       xticklabels=['Failed', 'Success'],
                       yticklabels=['Failed', 'Success'])
            ax2.set_title('Confusion Matrix')
            ax2.set_xlabel('Predicted')
            ax2.set_ylabel('Actual')
            
            # Prediction probability distribution
            ax3.hist(y_pred_proba[y_test == True], alpha=0.7, label='Actual Success', bins=20, color='green')
            ax3.hist(y_pred_proba[y_test == False], alpha=0.7, label='Actual Failure', bins=20, color='red')
            ax3.set_xlabel('Predicted Success Probability')
            ax3.set_ylabel('Frequency')
            ax3.set_title('Prediction Probability Distribution')
            ax3.legend()
            
            # Success probability surface (if we have connectivity and congestion factors)
            if all(col in feature_cols for col in ['connectivityFactor', 'congestionFactor']):
                # Create a grid of parameter values
                conn_range = np.linspace(X['connectivityFactor'].min(), X['connectivityFactor'].max(), 20)
                cong_range = np.linspace(X['congestionFactor'].min(), X['congestionFactor'].max(), 20)
                conn_grid, cong_grid = np.meshgrid(conn_range, cong_range)
                
                # Use mean runtime for prediction
                mean_runtime = X['runtime'].mean()
                
                # Prepare prediction grid
                pred_grid = np.column_stack([
                    conn_grid.ravel(),
                    cong_grid.ravel(),
                    np.full(conn_grid.size, mean_runtime)
                ])
                
                # Scale and predict
                pred_grid_scaled = scaler.transform(pred_grid)
                success_proba = rf_model.predict_proba(pred_grid_scaled)[:, 1]
                success_surface = success_proba.reshape(conn_grid.shape)
                
                # Plot success probability surface
                contour = ax4.contourf(conn_grid, cong_grid, success_surface, levels=20, cmap='RdYlGn')
                ax4.set_xlabel('Connectivity Factor')
                ax4.set_ylabel('Congestion Factor')
                ax4.set_title('Predicted Success Probability Surface')
                plt.colorbar(contour, ax=ax4, label='Success Probability')
            
            plt.tight_layout()
            plt.show()
            
            # Print model performance
            print(f"\\n📈 Model Performance:")
            print(f"  • Training Accuracy: {rf_model.score(X_train_scaled, y_train)*100:.1f}%")
            print(f"  • Test Accuracy: {rf_model.score(X_test_scaled, y_test)*100:.1f}%")
            
            print(f"\\n🎯 Feature Importance Rankings:")
            for i, (feature, importance) in feature_importance.iterrows():
                print(f"  {i+1}. {feature}: {importance:.3f}")
            
        except ImportError:
            print("⚠️ scikit-learn not available for predictive modeling")
        except Exception as e:
            print(f"⚠️ Modeling error: {str(e)}")
    
    def _show_benchmark_clustering(self, data):
        """Show benchmark clustering analysis"""
        print("🎯 Benchmark Clustering Analysis")
        print("=" * 40)
        
        # Aggregate benchmark statistics
        benchmark_stats = data.groupby('benchmark_name').agg({
            'success': ['mean', 'count'],
            'runtime': ['mean', 'std'],
            'connectivityFactor': ['mean', 'std'],
            'congestionFactor': ['mean', 'std']
        }).round(4)
        
        benchmark_stats.columns = [
            'success_rate', 'total_runs', 'avg_runtime', 'runtime_std',
            'avg_connectivity', 'connectivity_std', 'avg_congestion', 'congestion_std'
        ]
        
        # Filter benchmarks with sufficient data
        benchmark_stats = benchmark_stats[benchmark_stats['total_runs'] >= 5]
        
        if len(benchmark_stats) < 3:
            print("⚠️ Insufficient benchmarks for clustering analysis")
            return
        
        # Prepare features for clustering
        cluster_features = ['success_rate', 'avg_runtime', 'avg_connectivity', 'avg_congestion']
        cluster_data = benchmark_stats[cluster_features].fillna(0)
        
        try:
            from sklearn.cluster import KMeans
            from sklearn.preprocessing import StandardScaler
            
            # Standardize features
            scaler = StandardScaler()
            scaled_features = scaler.fit_transform(cluster_data)
            
            # Determine optimal number of clusters using elbow method
            max_k = min(8, len(benchmark_stats) - 1)
            inertias = []
            K_range = range(2, max_k + 1)
            
            for k in K_range:
                kmeans = KMeans(n_clusters=k, random_state=42)
                kmeans.fit(scaled_features)
                inertias.append(kmeans.inertia_)
            
            # Use 3 clusters as default (or find elbow point)
            optimal_k = 3 if len(K_range) >= 2 else 2
            
            # Apply K-means clustering
            kmeans = KMeans(n_clusters=optimal_k, random_state=42)
            cluster_labels = kmeans.fit_predict(scaled_features)
            
            benchmark_stats['cluster'] = cluster_labels
            
            # Visualizations
            fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(15, 10))
            
            # Elbow curve
            ax1.plot(K_range, inertias, 'bo-')
            ax1.set_xlabel('Number of Clusters (k)')
            ax1.set_ylabel('Inertia')
            ax1.set_title('Elbow Method for Optimal k')
            ax1.grid(True, alpha=0.3)
            
            # Cluster scatter plot (Success Rate vs Runtime)
            colors = plt.cm.Set1(np.linspace(0, 1, optimal_k))
            for i in range(optimal_k):
                cluster_data_i = benchmark_stats[benchmark_stats['cluster'] == i]
                ax2.scatter(cluster_data_i['success_rate'], cluster_data_i['avg_runtime'],
                           c=[colors[i]], label=f'Cluster {i+1}', s=60, alpha=0.7)
            
            ax2.set_xlabel('Success Rate')
            ax2.set_ylabel('Average Runtime (s)')
            ax2.set_title('Benchmark Clusters (Success Rate vs Runtime)')
            ax2.legend()
            ax2.grid(True, alpha=0.3)
            
            # Cluster heatmap
            cluster_summary = benchmark_stats.groupby('cluster')[cluster_features].mean()
            sns.heatmap(cluster_summary.T, annot=True, fmt='.3f', cmap='viridis', ax=ax3)
            ax3.set_title('Cluster Characteristics Heatmap')
            ax3.set_ylabel('Features')
            ax3.set_xlabel('Clusters')
            
            # Cluster size distribution
            cluster_counts = benchmark_stats['cluster'].value_counts().sort_index()
            bars = ax4.bar(range(len(cluster_counts)), cluster_counts.values, color=colors[:len(cluster_counts)])
            ax4.set_xlabel('Cluster')
            ax4.set_ylabel('Number of Benchmarks')
            ax4.set_title('Cluster Size Distribution')
            ax4.set_xticks(range(len(cluster_counts)))
            ax4.set_xticklabels([f'Cluster {i+1}' for i in range(len(cluster_counts))])
            
            # Add value labels on bars
            for bar, count in zip(bars, cluster_counts.values):
                ax4.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 0.1,
                        str(count), ha='center', va='bottom')
            
            plt.tight_layout()
            plt.show()
            
            # Print cluster analysis
            print(f"\\n🎯 Cluster Analysis Results:")
            for cluster_id in range(optimal_k):
                cluster_benchmarks = benchmark_stats[benchmark_stats['cluster'] == cluster_id]
                print(f"\\n  📊 Cluster {cluster_id + 1} ({len(cluster_benchmarks)} benchmarks):")
                print(f"    • Average Success Rate: {cluster_benchmarks['success_rate'].mean()*100:.1f}%")
                print(f"    • Average Runtime: {cluster_benchmarks['avg_runtime'].mean():.3f}s")
                print(f"    • Representative Benchmarks: {', '.join(cluster_benchmarks.index[:3].tolist())}")
            
        except ImportError:
            print("⚠️ scikit-learn not available for clustering analysis")
        except Exception as e:
            print(f"⚠️ Clustering error: {str(e)}")
    
    def _show_interactive_parameters(self, data):
        """Show interactive parameter exploration"""
        print("🎮 Interactive Parameter Explorer")
        print("=" * 40)
        
        if not all(col in data.columns for col in ['connectivityFactor', 'congestionFactor', 'success', 'runtime']):
            print("⚠️ Required parameter columns not available")
            return
        
        # Create interactive 3D scatter plot
        fig = go.Figure()
        
        # Successful runs
        success_data = data[data['success'] == True]
        if not success_data.empty:
            fig.add_trace(go.Scatter3d(
                x=success_data['connectivityFactor'],
                y=success_data['congestionFactor'],
                z=success_data['runtime'],
                mode='markers',
                name='Successful',
                marker=dict(
                    color='green',
                    size=4,
                    opacity=0.7
                ),
                text=success_data['benchmark_name'],
                hovertemplate='<b>%{text}</b><br>' +
                              'Connectivity: %{x:.2f}<br>' +
                              'Congestion: %{y:.2f}<br>' +
                              'Runtime: %{z:.3f}s<br>' +
                              'Status: Success<extra></extra>'
            ))
        
        # Failed runs
        failed_data = data[data['success'] == False]
        if not failed_data.empty:
            fig.add_trace(go.Scatter3d(
                x=failed_data['connectivityFactor'],
                y=failed_data['congestionFactor'],
                z=failed_data['runtime'],
                mode='markers',
                name='Failed',
                marker=dict(
                    color='red',
                    size=4,
                    opacity=0.7,
                    symbol='x'
                ),
                text=failed_data['benchmark_name'],
                hovertemplate='<b>%{text}</b><br>' +
                              'Connectivity: %{x:.2f}<br>' +
                              'Congestion: %{y:.2f}<br>' +
                              'Runtime: %{z:.3f}s<br>' +
                              'Status: Failed<extra></extra>'
            ))
        
        fig.update_layout(
            title='Interactive 3D Parameter Space Explorer',
            scene=dict(
                xaxis_title='Connectivity Factor',
                yaxis_title='Congestion Factor',
                zaxis_title='Runtime (seconds)'
            ),
            height=600
        )
        
        fig.show()
        
        # Parameter range analysis
        param_stats = data.groupby(['connectivityFactor', 'congestionFactor']).agg({
            'success': ['mean', 'count'],
            'runtime': ['mean', 'min', 'max']
        }).round(4)
        
        param_stats.columns = ['success_rate', 'count', 'avg_runtime', 'min_runtime', 'max_runtime']
        param_stats = param_stats.reset_index()
        param_stats = param_stats[param_stats['count'] >= 2]  # Filter combinations with at least 2 runs
        
        print(f"\\n📊 Parameter Space Statistics:")
        print(f"  • Total parameter combinations tested: {len(param_stats)}")
        print(f"  • Best performing combination:")
        
        if not param_stats.empty:
            best_combo = param_stats.loc[param_stats['success_rate'].idxmax()]
            print(f"    - Connectivity: {best_combo['connectivityFactor']:.1f}")
            print(f"    - Congestion: {best_combo['congestionFactor']:.1f}")
            print(f"    - Success Rate: {best_combo['success_rate']*100:.1f}%")
            print(f"    - Average Runtime: {best_combo['avg_runtime']:.3f}s")
    
    def _show_time_trends(self, data):
        """Show time-based performance trends"""
        print("📈 Time-based Performance Trends")
        print("=" * 40)
        
        if 'timestamp' not in data.columns:
            print("⚠️ No timestamp data available for trend analysis")
            return
        
        # Convert timestamp and filter valid dates
        data['datetime'] = pd.to_datetime(data['timestamp'], errors='coerce')
        time_data = data.dropna(subset=['datetime']).copy()
        
        if time_data.empty:
            print("⚠️ No valid timestamp data found")
            return
        
        # Sort by datetime
        time_data = time_data.sort_values('datetime')
        
        # Calculate rolling statistics
        time_data['date'] = time_data['datetime'].dt.date
        daily_stats = time_data.groupby('date').agg({
            'success': ['mean', 'count'],
            'runtime': ['mean', 'std']
        }).round(4)
        
        daily_stats.columns = ['success_rate', 'total_runs', 'avg_runtime', 'runtime_std']
        daily_stats = daily_stats.reset_index()
        
        # Calculate rolling averages
        window_size = min(7, len(daily_stats))
        daily_stats['success_rate_ma'] = daily_stats['success_rate'].rolling(window=window_size, center=True).mean()
        daily_stats['runtime_ma'] = daily_stats['avg_runtime'].rolling(window=window_size, center=True).mean()
        
        # Create interactive time series plot
        fig = make_subplots(
            rows=2, cols=2,
            subplot_titles=[
                'Success Rate Trend',
                'Runtime Trend', 
                'Daily Run Volume',
                'Performance Score Trend'
            ]
        )
        
        # Success rate trend
        fig.add_trace(
            go.Scatter(
                x=daily_stats['date'],
                y=daily_stats['success_rate'],
                mode='lines+markers',
                name='Daily Success Rate',
                line=dict(color='lightblue', width=1),
                marker=dict(size=4)
            ),
            row=1, col=1
        )
        
        fig.add_trace(
            go.Scatter(
                x=daily_stats['date'],
                y=daily_stats['success_rate_ma'],
                mode='lines',
                name='Success Rate (Moving Avg)',
                line=dict(color='blue', width=2)
            ),
            row=1, col=1
        )
        
        # Runtime trend
        fig.add_trace(
            go.Scatter(
                x=daily_stats['date'],
                y=daily_stats['avg_runtime'],
                mode='lines+markers',
                name='Daily Avg Runtime',
                line=dict(color='lightcoral', width=1),
                marker=dict(size=4)
            ),
            row=1, col=2
        )
        
        fig.add_trace(
            go.Scatter(
                x=daily_stats['date'],
                y=daily_stats['runtime_ma'],
                mode='lines',
                name='Runtime (Moving Avg)',
                line=dict(color='red', width=2)
            ),
            row=1, col=2
        )
        
        # Daily run volume
        fig.add_trace(
            go.Bar(
                x=daily_stats['date'],
                y=daily_stats['total_runs'],
                name='Daily Runs',
                marker_color='lightgreen'
            ),
            row=2, col=1
        )
        
        # Performance score (inverse of runtime for successful runs)
        daily_stats['performance_score'] = daily_stats['success_rate'] / (daily_stats['avg_runtime'] + 1e-6)
        fig.add_trace(
            go.Scatter(
                x=daily_stats['date'],
                y=daily_stats['performance_score'],
                mode='lines+markers',
                name='Performance Score',
                line=dict(color='purple', width=2),
                marker=dict(size=4)
            ),
            row=2, col=2
        )
        
        fig.update_layout(
            title='Time-based Performance Trends',
            height=800,
            showlegend=False
        )
        
        fig.show()
        
        # Trend analysis summary
        if len(daily_stats) > 1:
            recent_period = daily_stats.tail(min(7, len(daily_stats)))
            early_period = daily_stats.head(min(7, len(daily_stats)))
            
            success_trend = recent_period['success_rate'].mean() - early_period['success_rate'].mean()
            runtime_trend = recent_period['avg_runtime'].mean() - early_period['avg_runtime'].mean()
            
            print(f"\\n📊 Trend Analysis:")
            print(f"  • Success Rate Trend: {success_trend:+.3f} ({'↗️ Improving' if success_trend > 0 else '↘️ Declining' if success_trend < 0 else '➡️ Stable'})")
            print(f"  • Runtime Trend: {runtime_trend:+.3f}s ({'↗️ Slower' if runtime_trend > 0 else '↘️ Faster' if runtime_trend < 0 else '➡️ Stable'})")
            print(f"  • Data Span: {len(daily_stats)} days")
            print(f"  • Total Runs Analyzed: {time_data['total_runs'].sum() if 'total_runs' in time_data.columns else len(time_data)}")
    
    def _show_correlation_network(self, data):
        """Show correlation network analysis"""
        print("🕸️ Correlation Network Analysis")
        print("=" * 40)
        
        # Select numeric columns for correlation analysis
        numeric_cols = data.select_dtypes(include=[np.number]).columns.tolist()
        exclude_cols = ['timestamp', 'returnCode']
        analysis_cols = [col for col in numeric_cols if col not in exclude_cols]
        
        if len(analysis_cols) < 3:
            print("⚠️ Insufficient numeric columns for network analysis")
            return
        
        # Calculate correlation matrix
        corr_data = data[analysis_cols].dropna()
        correlation_matrix = corr_data.corr()
        
        # Create network visualization using matplotlib
        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
        
        # Correlation heatmap
        mask = np.triu(np.ones_like(correlation_matrix, dtype=bool))
        sns.heatmap(correlation_matrix, mask=mask, annot=True, cmap='coolwarm', 
                   center=0, square=True, ax=ax1, fmt='.2f')
        ax1.set_title('Correlation Matrix (Lower Triangle)')
        
        # Network graph representation
        try:
            import networkx as nx
            
            # Create network graph
            G = nx.Graph()
            
            # Add nodes
            for col in analysis_cols:
                G.add_node(col)
            
            # Add edges for significant correlations
            threshold = 0.3  # Minimum correlation threshold
            for i in range(len(analysis_cols)):
                for j in range(i+1, len(analysis_cols)):
                    corr_val = correlation_matrix.iloc[i, j]
                    if abs(corr_val) >= threshold:
                        G.add_edge(analysis_cols[i], analysis_cols[j], 
                                 weight=abs(corr_val), correlation=corr_val)
            
            # Layout and visualization
            pos = nx.spring_layout(G, k=1, iterations=50)
            
            # Draw nodes
            nx.draw_networkx_nodes(G, pos, node_color='lightblue', 
                                 node_size=1000, ax=ax2)
            
            # Draw edges with different colors for positive/negative correlations
            edges = G.edges(data=True)
            for (u, v, d) in edges:
                corr = d['correlation']
                color = 'red' if corr > 0 else 'blue'
                width = abs(corr) * 3  # Edge width proportional to correlation strength
                nx.draw_networkx_edges(G, pos, [(u, v)], edge_color=color, 
                                     width=width, alpha=0.7, ax=ax2)
            
            # Draw labels
            nx.draw_networkx_labels(G, pos, font_size=8, ax=ax2)
            
            ax2.set_title('Correlation Network Graph\\n(Red=Positive, Blue=Negative)')
            ax2.axis('off')
            
        except ImportError:
            # Fallback: show correlation strengths as bar chart
            # Get upper triangle correlations
            upper_triangle = correlation_matrix.where(
                np.triu(np.ones(correlation_matrix.shape), k=1).astype(bool)
            )
            
            # Flatten and get absolute values
            correlations = []
            for i in range(len(analysis_cols)):
                for j in range(i+1, len(analysis_cols)):
                    corr_val = correlation_matrix.iloc[i, j]
                    if abs(corr_val) >= 0.1:  # Only show significant correlations
                        correlations.append({
                            'pair': f"{analysis_cols[i]} - {analysis_cols[j]}",
                            'correlation': corr_val
                        })
            
            correlations = sorted(correlations, key=lambda x: abs(x['correlation']), reverse=True)[:15]
            
            if correlations:
                pairs = [c['pair'] for c in correlations]
                values = [c['correlation'] for c in correlations]
                colors = ['red' if v > 0 else 'blue' for v in values]
                
                bars = ax2.barh(range(len(pairs)), [abs(v) for v in values], color=colors, alpha=0.7)
                ax2.set_yticks(range(len(pairs)))
                ax2.set_yticklabels([p.replace(' - ', '\\n') for p in pairs], fontsize=8)
                ax2.set_xlabel('Absolute Correlation')
                ax2.set_title('Strongest Correlations\\n(Red=Positive, Blue=Negative)')
        
        plt.tight_layout()
        plt.show()
        
        # Print strongest correlations
        upper_triangle = correlation_matrix.where(
            np.triu(np.ones(correlation_matrix.shape), k=1).astype(bool)
        )
        
        strong_correlations = []
        for i in range(len(analysis_cols)):
            for j in range(i+1, len(analysis_cols)):
                corr_val = correlation_matrix.iloc[i, j]
                if abs(corr_val) >= 0.3:
                    strong_correlations.append((analysis_cols[i], analysis_cols[j], corr_val))
        
        strong_correlations.sort(key=lambda x: abs(x[2]), reverse=True)
        
        print(f"\\n🔗 Strongest Correlations (|r| ≥ 0.3):")
        for i, (var1, var2, corr) in enumerate(strong_correlations[:10], 1):
            direction = "positive" if corr > 0 else "negative"
            print(f"  {i}. {var1} ↔ {var2}: {corr:.3f} ({direction})")
    
    def _show_statistical_distributions(self, data):
        """Show statistical distribution analysis"""
        print("📊 Statistical Distribution Analysis")
        print("=" * 40)
        
        # Select key numeric variables
        key_vars = ['runtime', 'connectivityFactor', 'congestionFactor']
        available_vars = [var for var in key_vars if var in data.columns]
        
        if not available_vars:
            print("⚠️ No key numeric variables available for distribution analysis")
            return
        
        n_vars = len(available_vars)
        fig, axes = plt.subplots(2, n_vars, figsize=(5*n_vars, 10))
        if n_vars == 1:
            axes = axes.reshape(-1, 1)
        
        for i, var in enumerate(available_vars):
            var_data = data[var].dropna()
            
            # Histogram with density curve
            axes[0, i].hist(var_data, bins=30, density=True, alpha=0.7, color='skyblue', edgecolor='black')
            
            # Add density curve
            try:
                from scipy import stats
                # Fit normal distribution
                mu, sigma = stats.norm.fit(var_data)
                x = np.linspace(var_data.min(), var_data.max(), 100)
                axes[0, i].plot(x, stats.norm.pdf(x, mu, sigma), 'r-', linewidth=2, label='Normal Fit')
                axes[0, i].legend()
            except ImportError:
                pass
            
            axes[0, i].set_title(f'{var.replace("_", " ").title()} Distribution')
            axes[0, i].set_xlabel(var)
            axes[0, i].set_ylabel('Density')
            
            # Q-Q plot
            try:
                from scipy import stats
                stats.probplot(var_data, dist="norm", plot=axes[1, i])
                axes[1, i].set_title(f'{var.replace("_", " ").title()} Q-Q Plot')
            except ImportError:
                # Fallback: Box plot
                box_data = []
                labels = []
                
                if 'success' in data.columns:
                    success_data = data[data['success'] == True][var].dropna()
                    failed_data = data[data['success'] == False][var].dropna()
                    
                    if not success_data.empty:
                        box_data.append(success_data)
                        labels.append('Success')
                    if not failed_data.empty:
                        box_data.append(failed_data)
                        labels.append('Failed')
                else:
                    box_data = [var_data]
                    labels = [var]
                
                if box_data:
                    axes[1, i].boxplot(box_data, labels=labels)
                    axes[1, i].set_title(f'{var.replace("_", " ").title()} Box Plot')
                    axes[1, i].set_ylabel(var)
        
        plt.tight_layout()
        plt.show()
        
        # Statistical summary
        print(f"\\n📈 Statistical Summary:")
        for var in available_vars:
            var_data = data[var].dropna()
            if not var_data.empty:
                print(f"\\n  {var.replace('_', ' ').title()}:")
                print(f"    • Mean: {var_data.mean():.4f}")
                print(f"    • Median: {var_data.median():.4f}")
                print(f"    • Std Dev: {var_data.std():.4f}")
                print(f"    • Min: {var_data.min():.4f}")
                print(f"    • Max: {var_data.max():.4f}")
                print(f"    • Skewness: {var_data.skew():.4f}")
                print(f"    • Kurtosis: {var_data.kurtosis():.4f}")
    
    def _generate_insights(self, data):
        """Generate advanced insights based on current visualization"""
        with self.widgets['insights_output']:
            clear_output(wait=True)
            
            if data.empty:
                print("⚠️ No data available for insights")
                return
            
            viz_type = self.widgets['viz_type'].value
            
            print("🧠 Advanced Analytics Insights")
            print("=" * 50)
            
            # General insights
            total_records = len(data)
            success_rate = data['success'].mean() * 100 if 'success' in data.columns else 0
            
            print(f"📊 Dataset Overview:")
            print(f"  • Records Analyzed: {total_records:,}")
            print(f"  • Overall Success Rate: {success_rate:.1f}%")
            
            # Specific insights based on visualization type
            if viz_type == 'performance_map':
                print(f"\\n🗺️ Performance Map Insights:")
                if all(col in data.columns for col in ['connectivityFactor', 'congestionFactor', 'success']):
                    param_performance = data.groupby(['connectivityFactor', 'congestionFactor'])['success'].mean()
                    best_params = param_performance.idxmax()
                    best_rate = param_performance.max()
                    print(f"  • Optimal parameter combination: Connectivity={best_params[0]:.1f}, Congestion={best_params[1]:.1f}")
                    print(f"  • Best success rate achieved: {best_rate*100:.1f}%")
                    
                    # Identify parameter sensitivity
                    conn_sensitivity = data.groupby('connectivityFactor')['success'].std().mean()
                    cong_sensitivity = data.groupby('congestionFactor')['success'].std().mean()
                    
                    if conn_sensitivity > cong_sensitivity:
                        print(f"  • Connectivity factor shows higher sensitivity (σ={conn_sensitivity:.3f})")
                    else:
                        print(f"  • Congestion factor shows higher sensitivity (σ={cong_sensitivity:.3f})")
            
            elif viz_type == 'multidim':
                print(f"\\n📐 Multi-dimensional Analysis Insights:")
                numeric_cols = data.select_dtypes(include=[np.number]).columns.tolist()
                if len(numeric_cols) >= 3:
                    # Calculate feature diversity
                    correlation_matrix = data[numeric_cols].corr().abs()
                    avg_correlation = correlation_matrix.values[np.triu_indices_from(correlation_matrix.values, k=1)].mean()
                    print(f"  • Average inter-feature correlation: {avg_correlation:.3f}")
                    if avg_correlation > 0.7:
                        print(f"  • High correlation detected - consider dimensionality reduction")
                    elif avg_correlation < 0.3:
                        print(f"  • Features show good independence - suitable for analysis")
            
            elif viz_type == 'predictive':
                print(f"\\n🔮 Predictive Modeling Insights:")
                if 'success' in data.columns:
                    class_balance = data['success'].value_counts()
                    minority_class = class_balance.min()
                    majority_class = class_balance.max()
                    imbalance_ratio = majority_class / minority_class
                    
                    print(f"  • Class balance ratio: {imbalance_ratio:.2f}:1")
                    if imbalance_ratio > 3:
                        print(f"  • Significant class imbalance detected - consider resampling techniques")
            
            elif viz_type == 'clustering':
                print(f"\\n🎯 Clustering Analysis Insights:")
                if 'benchmark_name' in data.columns:
                    unique_benchmarks = data['benchmark_name'].nunique()
                    if unique_benchmarks >= 3:
                        benchmark_variance = data.groupby('benchmark_name')['success'].var().mean()
                        print(f"  • Average benchmark success variance: {benchmark_variance:.3f}")
                        if benchmark_variance > 0.2:
                            print(f"  • High benchmark variability - clustering could reveal distinct groups")
            
            # Performance recommendations
            print(f"\\n🚀 Performance Optimization Recommendations:")
            
            if 'runtime' in data.columns:
                runtime_stats = data['runtime'].describe()
                if runtime_stats['75%'] > 2 * runtime_stats['25%']:
                    print(f"  • High runtime variability detected - investigate outliers")
                
                if 'success' in data.columns:
                    success_runtime = data[data['success'] == True]['runtime']
                    failed_runtime = data[data['success'] == False]['runtime']
                    
                    if not success_runtime.empty and not failed_runtime.empty:
                        if failed_runtime.mean() > success_runtime.mean():
                            print(f"  • Failed runs take longer - early termination could improve efficiency")
            
            # Data quality assessment
            print(f"\\n📊 Data Quality Assessment:")
            missing_data = data.isnull().sum().sum()
            total_cells = len(data) * len(data.columns)
            completeness = ((total_cells - missing_data) / total_cells) * 100
            
            print(f"  • Data Completeness: {completeness:.1f}%")
            if completeness < 95:
                print(f"  • Consider data imputation or collection improvement")
            
            # Statistical significance
            if 'success' in data.columns and len(data) > 30:
                success_count = data['success'].sum()
                confidence_interval = 1.96 * np.sqrt((success_rate/100 * (1-success_rate/100)) / len(data))
                print(f"  • Success rate 95% CI: {success_rate-confidence_interval*100:.1f}% - {success_rate+confidence_interval*100:.1f}%")
    
    def _on_viz_change(self, change):
        """Handle visualization type change"""
        # Auto-generate new visualization when type changes
        self._generate_visualization(None)
    
    def _export_analysis(self, button):
        """Export current analysis results"""
        viz_type = self.widgets['viz_type'].value
        timestamp = pd.Timestamp.now().strftime("%Y%m%d_%H%M%S")
        
        try:
            # Export filtered data
            filtered_data = self._filter_data()
            
            if not filtered_data.empty:
                filename = f"advanced_analysis_{viz_type}_{timestamp}.csv"
                output_path = self.results_manager.results_dir / filename
                filtered_data.to_csv(output_path, index=False)
                print(f"✅ Analysis data exported to: {output_path}")
            else:
                print("⚠️ No data to export")
                
        except Exception as e:
            print(f"❌ Export failed: {str(e)}")

# Create and display the advanced visualization interface
try:
    if 'advanced_viz' in globals():
        del advanced_viz
    
    advanced_viz = AdvancedVisualizationInterface(results_manager)
    advanced_dashboard = advanced_viz.create_dashboard()
    
    if advanced_dashboard:
        display(advanced_dashboard)
        print("✅ Advanced Visualizations & Analytics Interface loaded successfully!")
        print("🚀 Select different visualization types to explore advanced analysis features.")
    else:
        print("❌ Failed to create advanced visualization interface")

except Exception as e:
    print(f"❌ Advanced visualization interface creation failed: {str(e)}")
    import traceback
    print("Full error:")
    print(traceback.format_exc())

# Failure Analysis Interface with Categorization and Filtering
# widgets and display already imported above
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from collections import Counter
import re

