"""Tests for FABulousPower (ODB power connection) step.

This step has custom get_command() logic that adds the metal layer parameter.
"""

from librelane.config.config import Config
from librelane.state.state import State
from pytest_mock import MockerFixture

from fabulous.fabric_generator.gds_generator.steps.odb_connect_pdn import (
    FABulousPDN,
)


def test_get_command_includes_power_ground_flags(
    mock_config: Config, mock_state: State, mocker: MockerFixture
) -> None:
    """Test that get_command() includes the --power-names and
    --ground-names parameter at least once each.
    """
    # Mock the parent class get_command to return a base command
    mocker.patch(
        "librelane.steps.odb.OdbpyStep.get_command",
        return_value=["python", "script.py", "--input", "test.odb"],
    )

    step = FABulousPDN(mock_config, mock_state)
    step.config = mock_config
    command = step.get_command()

    # Verify the command includes the power and ground name parameters
    assert "--power-names" in command, "Command should include --power-names flag"
    assert "--ground-names" in command, "Command should include --ground-names flag"


def test_get_command_includes_config_nets(
    mock_config: Config, mock_state: State, mocker: MockerFixture
) -> None:
    """Test that get_command() includes the power nets from the configuration nets."""
    # Mock the parent class get_command to return a base command
    mocker.patch(
        "librelane.steps.odb.OdbpyStep.get_command",
        return_value=["python", "script.py", "--input", "test.odb"],
    )

    step = FABulousPDN(mock_config, mock_state)
    step.config = mock_config
    command = step.get_command()

    assert "--power-names" in command
    power_idx = command.index("--power-names")
    assert command[power_idx + 1] == "VDD"

    assert "--power-names" in command
    ground_idx = command.index("--ground-names")
    assert command[ground_idx + 1] == "VSS"


def test_get_command_reverts_to_default_nets(
    mock_config: Config, mock_state: State, mocker: MockerFixture
) -> None:
    """Test that get_command() falls back to the PDK VDD_PIN/GND_PIN when
    VDD_NETS/GND_NETS are unset (None), rather than hardcoded VPWR/VGND.

    The tile macros expose exactly the PDK power/ground pins, so on PDKs where
    those are VDD/VSS (gf180mcuD, ihp-sg13g2) a hardcoded VPWR/VGND fallback
    leaves the fabric power pins disconnected.
    """
    # Mock the parent class get_command to return a base command
    mocker.patch(
        "librelane.steps.odb.OdbpyStep.get_command",
        return_value=["python", "script.py", "--input", "test.odb"],
    )

    # VDD_PIN/GND_PIN come from mock_config (VDD/VSS)
    config = mock_config.copy(VDD_NETS=None, GND_NETS=None)

    step = FABulousPDN(config, mock_state)
    step.config = config
    command = step.get_command()

    assert "--power-names" in command
    power_idx = command.index("--power-names")
    assert command[power_idx + 1] == "VDD"

    assert "--ground-names" in command
    ground_idx = command.index("--ground-names")
    assert command[ground_idx + 1] == "VSS"


def test_get_command_supports_multple_power_nets(
    mock_config: Config, mock_state: State, mocker: MockerFixture
) -> None:
    """Test that get_command() includes multiple power nets when more than 1 value is
    specified in the configuration."""
    # Mock the parent class get_command to return a base command
    mocker.patch(
        "librelane.steps.odb.OdbpyStep.get_command",
        return_value=["python", "script.py", "--input", "test.odb"],
    )

    # Add required config values for IO placement
    config = mock_config.copy(
        VDD_NETS=["VDD1", "VDD2"],
        GND_NETS=["GND1", "GND2"],
    )

    step = FABulousPDN(config, mock_state)
    step.config = config
    command = step.get_command()

    assert "--power-names" in command
    power_idx = command.index("--power-names")
    assert command[power_idx + 1] == "VDD1"
    power_idx = command.index("--power-names", power_idx + 1)
    assert command[power_idx + 1] == "VDD2"

    assert "--ground-names" in command
    ground_idx = command.index("--ground-names")
    assert command[ground_idx + 1] == "GND1"
    ground_idx = command.index("--ground-names", ground_idx + 1)
    assert command[ground_idx + 1] == "GND2"
