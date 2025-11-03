# FABulous: an Embedded FPGA Framework

FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates [SymbiFlow](https://symbiflow.github.io/)
toolchain release packages, deals with the bitstream generation and after fabrication tests. Additionally, we will provide an emulation path for system development.

This guide describes everything you need to set up your system to develop for FABulous ecosystem.

:::{figure} figs/workflows.*
:align: center
:alt: Fabulous workflows and dependencies
:width: 80%

FABulous workflows and dependencies.
:::

:::{figure} figs/fabulous_ecosystem.*
:align: center
:width: 80%
:::

Check out the {doc}`Usage` section for further information, including {ref}`setup`.

:::{note}
This project is under active development.
:::

## Contents

```{toctree}
:maxdepth: 2

getting_started/index
user_guide/index
developer_guide/development
gallery/index
misc/contact
misc/publications
generated_doc/index
```
