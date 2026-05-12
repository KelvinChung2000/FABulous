"""End-to-end cocotb integration tests against generated FABulous fabrics.

Shared cocotb-time helpers (``PCF``, ``uploadBitstream``, ``zeroBitstream``)
and pytest fixtures live in :mod:`conftest`; cocotb test modules import them
via ``from conftest import ...``.
"""
