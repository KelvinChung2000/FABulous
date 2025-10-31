# FABulous CLI — Features and Usage (clean)

This is a concise, accurate reference for FABulous' CLI styles and the interactive REPL conveniences you will use daily.

## Interactive mode (REPL)

- Start: `FABulous start` (alias `s`). Prompt example: `FABulous>`.
- Use the REPL for iterative development, inspecting internal objects, and editor-driven edits.

## Batch mode (single-invocation)

- Use `FABulous <subcommand>`, or `FABulous run` and `FABulous script`, for CI and automation.

## Core batch-mode commands (summary)

- `create-project` (alias: `c`)
- `install-oss-cad-suite`
- `install-fabulator`
- `update-project-version`
- `script <file>`
- `start` (alias: `s`)
- `run` (alias: `r`)

## Interactive-mode niceties (most-used features)

### Session variables

- `set <name> <value>` / `get <name>` (cmd2 Settable integration).

```bash
FABulous> set projectDir /path/to/project
FABulous> get projectDir
/path/to/project
```

### Persistent history and recall

History is stored under `.FABulous/.fabulous_history`. Use `history` to list entries and `!<n>` or `!<prefix>` to re-run commands.

### Tab completion

Argument and filesystem completion are available — press Tab to complete filenames and subcommands.

### Editor integration (`edit`)

You can open files from the REPL in your preferred editor and return to the CLI once the editor closes. The CLI chooses the editor from the following (in order): the environment variable `FABULOUS_EDITOR` (recommended), then `EDITOR` / `VISUAL`.

Examples:

```bash
# Start FABulous with VS Code as the editor (example for a code --wait invocation)
FABULOUS_EDITOR="/usr/bin/code --wait" FABulous start
FABulous> edit Fabric/myfabric_top.v
```

Notes and tips:
- If your editor supports a blocking/wait flag (e.g. `--wait` for VS Code, `-w` for many GUI editors), the CLI will wait until the editor process exits before returning to the prompt. Without a wait flag, `edit` may return immediately.
- You can also run the editor outside the FABulous process and use the CLI `history` or `run_script` to pick up saved edits.

### Macros, shortcuts, aliases (quick automation)

cmd2 supplies powerful interactive automation helpers:

- Macros: record sequences of CLI commands and replay them as a single named item.
- Shortcuts: map a short token to a longer command prefix so you can type less.
- Aliases: create command synonyms (useful for long or frequently used commands).

Common workflows (examples — exact subcommand names may differ slightly depending on cmd2 version):

1) Creating a macro (interactive):

```text
FABulous> macro create mybuild
Enter commands to store in the macro (blank line to finish):
load_fabric
gen_fabric
gen_top_wrapper

Macro 'mybuild' created.
```

Then run the macro by name:

```text
FABulous> macro run mybuild
```

2) Shortcuts (quick token expansion):

```text
FABulous> shortcut add gfg "gen_fabric; gen_top_wrapper"
FABulous> gfg
```

3) Aliases (persistent command synonyms):

```text
FABulous> alias add gf gen_fabric
FABulous> gf
```

If the exact macro/alias/shortcut subcommands are not available in your CLI version, you can always simulate them by creating a short text script and running `run_script` or by using a pyscript to call `app(...)` programmatically (see the pyscript examples below).

Useful commands to inspect and manage automation helpers:

- `history` — view previous commands and save ranges to a script.
- `macros` / `aliases` / `shortcuts` (or `macro list`) — list configured items.
- `macro delete NAME`, `alias delete NAME`, `shortcut delete NAME` — remove items.

### Shell integration (`shell` / `!`)

Use `shell <command>` or the shorthand `!<command>` to execute an operating-system command from the CLI. This is handy for quick filesystem checks or invoking tools (e.g. `ls`, `git`, `make`).

Examples:

```text
FABulous> shell ls -la Tile/
FABulous> !git status
```

Notes:
- `shell` runs commands in a subprocess and returns control when they finish. The CLI captures the return code in `last_result` which can be inspected by pyscripts or by checking `$?`-like semantics in your environment.
- Use `!` for convenience; `shell` is clearer in scripts.

### Script execution (`run_script`, transcripts)

`run_script <file>` executes a plain-text script where each line is a CLI command. This is the recommended way to record sequences you want to run unchanged across environments or CI runs, because `run_script` respects the CLI's parsing, hooks, and safety features.

Example `fab_build.txt` (text script):

```
load_fabric
gen_all_tile
gen_fabric
gen_bitStream_spec
gen_top_wrapper
```

Run it:

```text
FABulous> run_script fab_build.txt
```

If you want a transcript (command + output) for testing, use the `-t/--transcript` flag (if supported) or redirect the output into a file via the CLI's transcript facilities.

### When to use what

- Quick ad-hoc commands: `shell` or `!`.
- Repeatable sequences you want humans to read: `run_script` text scripts (store in `demo/` or `docs/examples/`).
- Conditional logic, result inspection, or complex orchestration: `run_pyscript` / `py` with `app(...)` (PyBridge) so you can write Python code that calls and inspects CLI commands' outputs.
- Interactive short-hands and single-key convenience: `shortcuts` and `aliases`.


## Notable cmd2-powered capabilities

- Persistent history, tab completion, macros/shortcuts, and shell integration.

## Reference

- cmd2 documentation: [cmd2 — Read the Docs (stable)](https://cmd2.readthedocs.io/en/stable/)

## Python scripting with cmd2

Prefer using text scripts and pyscripts for automation and reproducible runs. These two approaches are the recommended, supported ways to drive FABulous via its CLI:

- Text scripts (plain CLI commands) — use `run_script <file>` to execute a file containing one CLI command per line. This is the simplest, most portable approach and works well for CI, demos, and reproducible workflows.
- Python scripts / pyscripts — use `run_pyscript <file>` or `py` to run Python code inside the CLI process. Pyscripts get a small helper called `app` (the PyBridge) injected into their locals so they can call CLI commands and capture outputs programmatically.

If you require deeper integration (using FABulous as a library, calling internal APIs, or building complex pipelines), prefer the `FABulous_API` rather than relying on CLI internals — the API is designed for programmatic use and will remain the more stable integration surface.

Text script example (fab_build.txt):

```text
load_fabric
gen_all_tile
gen_fabric
gen_bitStream_spec
gen_top_wrapper
```

Run it from the FABulous prompt:

```text
FABulous> run_script fab_build.txt
```

Pyscript notes and example

Key points about pyscripts:

- Run a pyscript from the FABulous shell with: `run_pyscript my_script.py` (or start an interactive Python shell with `py`).
- Inside the pyscript an `app(...)` callable is available. Calling `app('some command')` runs that command using the same parsing and hooks as the REPL and returns a CommandResult namedtuple with `stdout`, `stderr`, `stop`, and `data` fields.
- `sys.argv` will be set for the pyscript (so you can parse script arguments). The script runs with `__name__ == '__main__'` and the script directory is temporarily added to `sys.path` just like regular Python script execution.
- By default the CLI does not expose the raw `self` (CLI instance) into pyscript locals. Some apps enable `self_in_py` to make `self` available; otherwise use `app(...)` to run commands or call the stable `FABulous_API` for direct API access.

Minimal pyscript example (`my_pipeline.py`):

```python
# my_pipeline.py
# Called with: FABulous> run_pyscript my_pipeline.py --arg1 value

res = app('load_fabric')           # run a CLI command and capture result
print('load_fabric stdout:', res.stdout)
if not res:
    print('load_fabric failed:', res.stderr)

# run a compound command and inspect return data (commands can populate app.last_result)
result = app('gen_fabric')
print('gen_fabric returned stop=', result.stop)
print('gen_fabric data=', result.data)

import sys
print('script argv:', sys.argv)
```

When to choose which:

- Use `run_script` for simple, line-oriented automation and reproducible CI runs.
- Use `run_pyscript` when you need conditional logic, to inspect command outputs, or interact with Python libraries as part of the run.

For embedding FABulous or writing production-grade integrations, use `FABulous_API` rather than driving the CLI programmatically.



## Quick examples

### Batch mode (CI)

```bash
FABulous script demo/FABulous.tcl --type tcl
FABulous run "load_fabric; gen_fabric; gen_top_wrapper"
```

### Interactive (day-to-day)

```bash
FABulous start
FABulous> load_fabric
FABulous> set target TILE_A
FABulous> edit Tile/TILE_A/TILE_A_ConfigMem.csv
FABulous> history
FABulous> !-1
FABulous> exit
```

## Next steps I can take

- Embed a generator that produces an up-to-date command index at docs-build time.
- Add a short `docs/examples/` REPL cheatsheet with copyable snippets.
- Run markdown lint and fix remaining style issues in the original file.
