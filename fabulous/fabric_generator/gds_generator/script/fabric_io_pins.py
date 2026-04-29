# Copyright (c) 2026 Leo Moser <leo.moser@pm.me>
# SPDX-License-Identifier: Apache-2.0
"""Place fabric IO pins."""

from typing import Any

import click
import odb
from reader import click_odb


@click.command()
@click_odb
def pins(
    reader: Any,  # noqa: ANN401
) -> None:
    """Place fabric I/O pins based on macro tile pin locations."""
    chip = reader.db.getChip()
    block = chip.getBlock()

    for bterm in block.getBTerms():
        if bterm.getSigType() == "SIGNAL":
            bterm_bpin = odb.dbBPin_create(bterm)
            net = bterm.getNet()

            for iterm in net.getITerms():
                instance = iterm.getInst()
                location = instance.getLocation()

                for mpins in iterm.getMTerm().getMPins():
                    for dbbox in mpins.getGeometry():
                        layer = dbbox.getTechLayer()
                        xmin = dbbox.xMin()
                        ymin = dbbox.yMin()
                        xmax = dbbox.xMax()
                        ymax = dbbox.yMax()

                        odb.dbBox_create(
                            bterm_bpin,
                            layer,
                            location[0] + xmin,
                            location[1] + ymin,
                            location[0] + xmax,
                            location[1] + ymax,
                        )

            bterm_bpin.setPlacementStatus("FIRM")


if __name__ == "__main__":
    pins()
