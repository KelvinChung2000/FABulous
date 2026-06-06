"""The top-level `FABulous plugins` group shares the management operations."""

from pytest_mock import MockerFixture
from typer.testing import CliRunner

from fabulous import fabulous as entry

runner = CliRunner()


def test_plugins_list_runs(mocker: MockerFixture) -> None:
    mocker.patch.object(
        entry.FABulousPluginManager, "for_management", return_value="MANAGER"
    )
    fmt = mocker.patch(
        "fabulous.plugins.management.format_plugin_list", return_value="LISTING"
    )
    result = runner.invoke(entry.plugins_app, ["list"])
    assert result.exit_code == 0
    assert "LISTING" in result.stdout
    fmt.assert_called_once_with("MANAGER")


def test_plugins_install_runs(mocker: MockerFixture) -> None:
    install = mocker.patch.object(
        entry.FABulousPluginManager, "install", return_value=["demo"]
    )
    result = runner.invoke(entry.plugins_app, ["install", "some-pkg"])
    assert result.exit_code == 0
    assert "demo" in result.stdout
    install.assert_called_once_with("some-pkg")


def test_plugins_group_skips_project_context(mocker: MockerFixture) -> None:
    """The `plugins` group runs without a FABulous project (no context init)."""
    init = mocker.patch.object(entry, "init_context")
    mocker.patch.object(
        entry.FABulousPluginManager, "for_management", return_value="MANAGER"
    )
    mocker.patch(
        "fabulous.plugins.management.format_plugin_list", return_value="LISTING"
    )

    result = runner.invoke(entry.app, ["plugins", "list"])

    assert result.exit_code == 0
    init.assert_not_called()  # plugin management never requires a project
