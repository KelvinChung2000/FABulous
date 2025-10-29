# FABulous: an Embedded FPGA Framework

FABulous is designed to fulfill the objectives of ease of use, maximum portability to different process nodes, good control for customization, and delivering good area, power, and performance characteristics of the generated FPGA fabrics. The framework provides templates for logic, arithmetic, memory, and I/O blocks that can be easily stitched together, whilst enabling users to add their own fully customized blocks and primitives.

The FABulous ecosystem generates the embedded FPGA fabric for chip fabrication, integrates [SymbiFlow](https://symbiflow.github.io/)
toolchain release packages, deals with the bitstream generation and after fabrication tests. Additionally, we will provide an emulation path for system development.

This documentation has been organised into thematic "parts" to improve navigation. Use the sections below to find user-facing guidance, developer notes, tooling information and API references.

```{image} ./figs/workflows.*
:alt: FABulous workflow
:width: 80%
:align: center

```

```{image} ./figs/fabulous_ecosystem.*
:alt: FABulous ecosystem
:width: 80%
:align: center
```

:::{note}
:class: tip
This project is under active development.
:::

## Contents

```{toctree}
:titlesonly:
getting_started/index
user_guide/index
developer_guide/development
gallery/index
misc/contact
misc/publications
generated_doc/index
```
