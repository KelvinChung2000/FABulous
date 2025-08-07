def test_show_all_configs(switchmatrix_config):
    """Test to show all generated configurations."""
    print(f"Config: {switchmatrix_config.name}")
    assert switchmatrix_config is not None
