# Writing a FABulous plugin

FABulous loads functionality through [pluggy](https://pluggy.readthedocs.io/).
A plugin is a Python package that exposes one or more `@hookimpl` functions from
`fabulous.plugins`.

## The smallest plugin

```python
from cmd2 import CommandSet, with_default_category

from fabulous.plugins import hookimpl


@with_default_category("Hello")
class HelloCommands(CommandSet):
    def do_hello(self, _statement) -> None:
        self._cmd.poutput("hello")


@hookimpl
def fabulous_register_commands():
    return HelloCommands()
```

## Available hooks

- `fabulous_register_commands(cli)` returns a cmd2 `CommandSet` (or a list).
- `fabulous_register_code_generators()` returns `CodeGeneratorProvider`s.
- `fabulous_register_parsers()` returns `ParserProvider`s.
- `fabulous_after_fabric_loaded(api)` runs after a fabric is loaded.
- `fabulous_register_settings()` returns your `PluginSettings` subclass.
- `fabulous_startup(manager)` runs once after discovery.

A hookimpl only declares the arguments it needs, so the `hello` example above
omits `cli`.

## Typed settings

Subclass `PluginSettings` (a `pydantic-settings` model) to declare your plugin's
own configuration. Set `group` (its key on the settings singleton) and an env
prefix, then return the class from `fabulous_register_settings`:

```python
from pydantic_settings import SettingsConfigDict

from fabulous.fabulous_settings import PluginSettings
from fabulous.plugins import hookimpl


class MySettings(PluginSettings):
    group = "my_plugin"
    model_config = SettingsConfigDict(env_prefix="FAB_MY_PLUGIN__")
    jobs: int = 4


@hookimpl
def fabulous_register_settings() -> type[PluginSettings]:
    return MySettings
```

After discovery the manager instantiates your model (reading `FAB_MY_PLUGIN__*`
from the environment) and stores it on the settings singleton. Read it back
anywhere with full typing through `from_context`, which uses `get_context()`
under the hood:

```python
MySettings.from_context().jobs  # -> int, the configured value
```

This is the recommended way to reach configuration from a plugin: it keeps the
single `get_context()` source of truth while giving you a precisely typed handle
instead of dictionary lookups.

## Distributing

Declare the entry point so FABulous discovers your package:

```toml
[project.entry-points."fabulous.plugins"]
my_plugin = "my_plugin"
```

Install it with `FABulous plugins install <spec>` and restart. For a ready-made
starting point, fork the
[FABulous plugin template](https://github.com/FPGA-Research/fabulous-plugin-template).

## Developing without installing

```bash
FABulous -m ./path/to/my_plugin <project-dir> start
```

`-m`/`--plugin` is repeatable and takes either a dotted module path or a directory.
