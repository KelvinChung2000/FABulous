# Copyright 2021 University of Manchester
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0


import os

from loguru import logger

from FABulous.fabric_definition.Fabric import Fabric
from FABulous.fabric_generator.code_generator import codeGenerator


class FabricGenerator:
    """This class contains all the functionality required to generate the fabric as an
    RTL file from CSV files. To use the class, the information will need to be parsed
    first using the function from file_parser.py.

    Attributes
    ----------
    fabric : Fabric
        The fabric object parsed from CSV definition files
    writer : codeGenerator
        The code generator object to write the RTL files
    """

    fabric: Fabric
    writer: codeGenerator

    def __init__(self, fabric: Fabric, writer: codeGenerator) -> None:
        self.fabric = fabric
        self.writer = writer
        # check if switch matrix debug signals should be generated, defaults to True
        sm_dbg = os.getenv("FAB_SWITCH_MATRIX_DEBUG_SIGNAL", "True")
        self.switch_matrix_debug_signal = (
            False if sm_dbg.lower().strip() == "false" else True
        )
        logger.info(
            f"Generate switch matrix debug signals: {self.switch_matrix_debug_signal}"
        )
