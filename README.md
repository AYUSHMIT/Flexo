# Flexo

![Language](https://img.shields.io/badge/Language-C%2B%2B-blue.svg)
![LLVM](https://img.shields.io/badge/LLVM-17-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey.svg)
![Build](https://img.shields.io/badge/Build-CMake%20%2B%20Ninja-red.svg)

A revolutionary compiler for microarchitectural weird machines - code that computes purely through microarchitectural side effects, providing strong obfuscation against both static and dynamic analysis.

**📚 Quick Links:** [Demo](DEMO.md) | [Quick Start](docs/QUICKSTART.md) | [Examples](docs/EXAMPLES.md) | [Benchmarks](docs/BENCHMARKS.md) | [Architecture](docs/ARCHITECTURE.md)

---

## 🎯 Features

- **🔒 Strong Obfuscation**: Resists debuggers, emulators, and static analysis
- **⚡ Practical Performance**: Microsecond-scale execution for simple circuits
- **🎨 Flexible Design**: Support for C/C++ and Verilog circuit descriptions
- **🛡️ Error Detection**: Built-in reliability through dual weird registers
- **🔧 LLVM Integration**: Seamless integration with LLVM compiler infrastructure
- **📦 Real-World Application**: UPFlexo packer for binary protection
- **🔬 Research-Backed**: Published at USENIX Security 2024

---

## 🚀 Interactive Demo

**New!** Try our comprehensive interactive demo:

```bash
bash demo/interactive-demo.sh
```

Or explore individual examples:
- 🔲 Logic Gates: `bash demo/examples/demo-gates.sh`
- ➕ Arithmetic: `bash demo/examples/demo-arithmetic.sh`
- 🧮 4-bit ALU: `bash demo/examples/demo-alu.sh`
- 🔐 Cryptography: `bash demo/examples/demo-crypto.sh`
- 📦 UPFlexo: `bash demo/examples/demo-upflexo.sh`

---

## 📖 Research & Papers

This work was published at **USENIX Security 2024**:

> Ping-Lun Wang, Riccardo Paccagnella, Riad S. Wahby, Fraser Brown.  
> **"Bending microarchitectural weird machines towards practicality."**  
> USENIX Security Symposium, 2024.

**Key Contributions:**
- Novel weird register designs (Baseline, NoBranch, Dual)
- Practical LLVM-based compiler implementation
- Demonstration of complex circuits (AES, SHA-1, Simon)
- UPFlexo: Real-world packer application

---

---

## 📋 Table of Contents

| Getting Started | Advanced Topics | Reference |
|----------------|-----------------|-----------|
| [What are µWMs?](#-what-are-microarchitectural-weird-machines) | [Configure Compiler](#configure-the-flexo-compiler) | [Hardware Requirements](#-hardware-requirements) |
| [🚀 Quick Start](docs/QUICKSTART.md) | [Create New WM](#create-a-new-weird-machine-with-cc) | [📊 Benchmarks](docs/BENCHMARKS.md) |
| [Install Compiler](#install-the-flexo-compiler) | [UPFlexo Packer](#upflexo-upx-packer-with-flexo-weird-machines) | [🏗️ Architecture](docs/ARCHITECTURE.md) |
| [Compile a WM](#compile-a-weird-machine) | [Unsupported Processors](#run-flexo-on-an-unsupported-processor) | [📚 Examples](docs/EXAMPLES.md) |
| [Basic Gates Example](#example-basic-logic-gates) | [Reproduce Results](#reproduce-our-results) | [Contact](#-contacts) |

---

## 🤔 What are microarchitectural weird machines?

Microarchitectural weird machines (µWMs) are code gadgets that perform computation purely through microarchitectural side effects.
They work similarly to a binary circuit: they use **weird registers** to store values and use **weird gates** to compute with them.

### How It Works

**Traditional Computing:**
```
CPU Instruction → ALU → Result in Register
```

**Weird Machine Computing:**
```
Memory Access → Cache Side Effect → Result in Cache State
```

### Example: AND Gate

Here is a weird AND gate with two inputs and one output:

```c
Out[In1[0] + In2[0]]
```

**Visualization:**
```
Input1 (cached=1) ──┐
                    ├─→ Access Memory[In1 + In2] ─→ Output (cache state)
Input2 (cached=1) ──┘
```

`In1` and `In2` are the two input weird registers, and this AND gate outputs to the weird register `Out`.
Section 2.2 of our paper explains how a µWM works in details.

> **Note:** The code snippets in our paper (Listing 1-5) are for illustrative purposes and can be different from our actual implementation, which we show in Listing 7 in the appendix.

### Why Are They Powerful?

These µWMs can prevent both static and dynamic analysis because they convert computations into memory operations:

- 🔍 **Anti-Static Analysis**: No visible computation in the binary
- 🐛 **Anti-Debug**: Single-stepping breaks transient execution
- 🖥️ **Anti-Emulation**: Requires real microarchitecture behavior
- ⏱️ **Side-Channel Based**: Uses cache timing for computation

Therefore, they are a great candidate for program obfuscation and potentially many other security applications.

**Learn More:** See [DEMO.md](DEMO.md) for detailed visualizations and [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for technical details.

## 🖥️ Hardware Requirements

The following list is the AWS EC2 instances that we used to run our Flexo weird machines.

| Microarchitecture | Instance type | Processor         |
| ----------------- | ------------- | ----------------- |
| Zen 1             | t3a.xlarge    | AMD EPYC 7571     |
| Zen 2             | c5a.xlarge    | AMD EPYC 7R32     |
| Zen 3             | c6a.xlarge    | AMD EPYC 7R13     |
| Zen 4             | m7a.xlarge    | AMD EPYC 9R14     |
| Skylake           | c5n.xlarge    | Intel Xeon 8124M  |
| Cascade Lake      | m5n.xlarge    | Intel Xeon 8259CL |
| Icelake           | m6in.xlarge   | Intel Xeon 8375C  |
| Sapphire Rapids   | m7i.xlarge    | Intel Xeon 8488C  |

> [!WARNING]
> When using a processor not included in this list, the weird machines may fail to generate correct results.
> While a processor with similar microarchitecture may be able to run our weird machines, we cannot guarantee the accuracy and performance when using other processors.
> For instructions about running our Flexo weird machine on an unsupported processor, please refer to "[Run Flexo on an unsupported processor](#run-flexo-on-an-unsupported-processor)".

## Reproduce our results

Follow the instructions in the [README](reproduce/README.md) file under `reproduce/` to run the experiments in our paper.

## Install the Flexo compiler

We suggest installing the Flexo compiler using a Docker or Podman container.
The script below creates a container using the provided [Docker file](./Dockerfile) and runs the [build script](./build.sh) to build the compiler.
For installation using Podman, simply replace `docker` with `podman` in these commands.

```sh
docker build -t flexo .
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./build.sh"
```

The compiler will be stored inside the `build/` folder when the installation process is complete.

## Compile a weird machine

### 1. C/C++ to LLVM IR

The Flexo compiler takes a LLVM IR file as input, so the first step of compiling a weird machine is to compile a C/C++ program implementing the weird machine into LLVM IR.
The following command uses `clang` (version 17) to compile a C/C++ program into LLVM IR.
Replace `[INPUT_WM_SOURCE]` with the filename of the input C/C++ program and `[LLVM_IR_FILE]` with the filename of the output LLVM IR.

```sh
clang-17 -fno-discard-value-names -fno-inline-functions -O1 -S -emit-llvm [INPUT_WM_SOURCE] -o [LLVM_IR_FILE]
```

For more information about how to write a C/C++ program that implements a weird machine, please refer to #TODO.
It is also possible to implement a weird machine using structural Verilog.
For more information about using Verilog to create a weird machine, please refer to #TODO.

### 2. Use the Flexo compiler to generate a weird machine

After that, run `compile.sh` to execute the Flexo compiler and generate the weird machine, which is also in the form of LLVM IR.
The following command performs this step.
Remember to replace `[INPUT_LLVM_IR_FILE]` with the filename of the LLVM IR file generated in the previous step and `[OUTPUT_LLVM_IR_FILE]` with the filename of the output LLVM IR file that contains the weird machine.

```sh
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./compile.sh [INPUT_LLVM_IR_FILE] [OUTPUT_LLVM_IR_FILE]"
```

The Flexo compiler provides several compile options to adjust the construction of a weird machine.
For the details of these compiler options, please refer to #TODO

### 3. Generate an executable file

Finally, you can generate an executable file from the output LLVM IR file using the following command.
Remember to replace `[OUTPUT_LLVM_IR_FILE]` with the filename of the LLVM IR file generated from the previous step and `[OUTPUT_EXECUTABLE_FILE]` with the filename of the executable file to be generated.

```sh
clang-17 [OUTPUT_LLVM_IR_FILE] -o [OUTPUT_EXECUTABLE_FILE] -lm -lstdc++
```

## Example: basic logic gates

We implemented several weird machines: basic logic gates, adders, multipliers, a 4-bit ALU, the SHA-1 hash function, the AES block cipher, and the Simon block cipher.
These examples can be found in the [`circuits/`](./circuits/) folder.

The [readme file](./circuits/gates/README.md) under [`circuits/gates`](./circuits/gates/) provides instructions regarding how to build a simple weird machine that computes basic logic gates (`AND`, `OR`, `NOT`, `NAND`, and `MUX`).

## Configure the Flexo compiler

The Flexo compiler can be configured by setting environment variables.
Line 15 of the [compilation script](./compile.sh#L15) provides an example of configuring the Flexo compiler using environment variables.
The following is the list of environment variables that are available to configure the compiler.

### General configuration

- `WM_KEYWORD`: The compiler only converts a function to WM when it contains a "keyword" in its name. The default value of this keyword is `__weird__`.
- `WM_VERBOSE`: Show verbose output, default to `false`.
- `TMP_PATH`: A folder to store temporary files, default to `/tmp`.
- `WM_CIRCUIT_FILE`: The path to a Verilog circuit file when the WM is implemented using Verilog. No default value. See [the ALU example](./circuits/ALU/README.md) for this configuration.

### Weird machine configuration

- `WM_DELAY`: The iterations of the delay loop between gate executions. Default to `256`.
- `WM_USE_FENCE`: Use memory fences instead of using a delay loop. Default to `true`.
- `RET_WM_DIV_ROUNDS`: The number of `div` instructions used when calculating the modified return address. Default to `4`.
- `RET_WM_DIV_SIZE`: The register size of the `div` instructions when calculating the modified return address. Possible values: `16` (default), `32`, or `64`.
- `RET_WM_JMP_SIZE`: The jump size of the modified return address (should be larger than the gate size). Default to `512`.
- `DUAL_WM_MAX_INPUT`: The maximum input size of a weird gate. Default to `4`.
- `WM_MAX_FANOUT`: The max number of fan-outs of an assign gate. Default to `3`.

### Weird register configuration

- `WR_TYPE`: The weird register type, which can be `Baseline`, `NoBranch`, or `Dual` (default).
- `WR_MAPPING`: The mapping type of weird registers, which can be `Baseline` or `Shuffle` (default).
- `WR_OFFSET`: The memory offset (in bytes) between each weird registers. Default to `960`.
- `WR_FAKE_OFFSET`: The memory offset (in bytes) between a real weird register and its fake location. Default to `512`.
- `WR_HIT_THRESHOLD`: The maximum access latency (in cycles) of a cache hit. Default to `180`.
- `WR_SYSCALL_RAND`: Use Linux syscall to generate random numbers instead of using standard library calls. Default to `false`.
- `WR_USE_MMAP`: Call the `mmap` syscall to allocate memory for WR instead of using the stack memory. May be slower if enabled, but this supports circuits with more wires. Default to `false`.

## Create a new weird machine with C/C++

The Flexo compiler converts C or C++ functions into weird machines.
These functions must comply with the following requirements:

### Function name

The functions that should be converted to a weird machine must contain the string `__weird__` in its name.
This string can be customized by specifying `WM_KEYWORD` in compiler configuration.

### Function type

The functions that should be converted to a weird machine must follow a special format.
Here is an example:

```cpp
bool __weird__fn(unsigned char* in1, unsigned char* out1, bool in2, bool* out2, bool& out3);
```

There are no rules for the names of the arguments or the order of the arguments, so they can be named or placed arbitrarily.

The inputs and outputs of a weird machine are all contained in the function argument.
There is no need to specify an argument as input or output as the compiler will detect this automatically by checking if the value of an argument is read or over-written.
The input and output variables must have the following types:

#### Input variable types

Inputs can be integer type with arbitrary length, e.g., `int`, `unsigned char`, `long`, are all valid.
They can be passed by value, by pointer, or by reference.

#### Output variable types

Outputs also can integer type with arbitrary length, but they must be passed by pointer or by reference.

#### Return value

The return value of the function is **NOT** the output of the weird machine, and it instead contains the error detection result.
The return value is `true` when an error is detected and `false` if undetected.
When the output of the weird machine has more than one bit or when there are multiple outputs, then the return value is `true` when **any of the output bit** detects an error.

If the error detection value is not needed, the return type of the function can be set to `void`.

#### Bit-wise error detection

Flexo weird machines can perform error detection for each output bit.
The compiler provides these error detection results via some special output variables, which have the name of the output variable with the `error_` prefix.

For example:

```cpp
void __weird_fn2(unsigned char* in, unsigned char* out, unsigned char* error_out);
```

This function has an output `out`, and the bit-wise error detection results of this output are provided in `error_out`.
`error_out` must have the same length as `out`, and the bits in `error_out` are set when the corresponding bits in `out` detect an error.
For example, if the n-th bit of `out` detects an error, then the n-th bit of `error_out` is set to `1`; otherwise, the n-th bit of `error_out` is set to `0`.

### Function body

The Flexo compiler parses the LLVM IR instructions inside the function body and converts it to a Verilog circuit.
The conversion is simple: it translates a LLVM IR instruction to a corresponding Verilog operator.
For example, the `Add` instruction is converted to `+`.

As some functionality of LLVM IR is not supported by a Verilog circuit, some LLVM IR instructions are not allowed in the function body, and any unsupported LLVM IR instruction will lead to compile errors.
For example, the function body should not contain any branch or function call, and memory operations are not allowed except for the inputs and outputs.
To see what LLVM IR instructions are supported, please refer to [`lib/Circuits/IRParser.cpp`](./lib/Circuits/IRParser.cpp).

## UPFlexo: UPX packer with Flexo weird machines

As a proof-of-concept application, we obfuscated [the UPX packer](https://upx.github.io/) with Flexo.
We encrypt the packed binary using AES or Simon encryption, and at runtime, a Flexo weird machine decrypts the packed binary.
Please refer to the [readme](./UPFlexo/README.md) of UPFlexo for more information about how to install and use this packer.

## Run Flexo on an unsupported processor

Microarchitectural weird machines are very sensitive to the nuances of a microarchitecture.
When running Flexo on an unsupported processor or when creating a new weird machine, some compiler configuration may need to be adjusted so that the weird machine can execute correctly.
Here are some compiler configurations that should be adjusted when tuning a weird machine:

### Adjust the transient window by setting `RET_WM_DIV_ROUNDS` or `RET_WM_DIV_SIZE`

The length of the transient window is controlled by the `RET_WM_DIV_ROUNDS` environment variable.
(For the definition of a "transient window", please refer to section 2.1 of our paper.)
We suggest trying every integers between 1 and 50 to see which number gives the best result.

For some rare cases, `RET_WM_DIV_SIZE` may also need to be adjusted.

### Adjust the spacing between weird registers by setting `WR_OFFSET`

The spacing between weird registers can impact the accuracy of a weird machine significantly.
We discuss this in section 3.3 of our paper.
We suggest setting `WR_OFFSET` to $2^n \pm L$, where $L$ is the L1 cache line size (usually `64`) and $n \in [8, 12]$.
I.e., set `WR_OFFSET` to 192, 320, 448, 576, 960, 1088, ...

### Reduce the size of the gate by adjusting `DUAL_WM_MAX_INPUT`

Some processors may have smaller transient windows, and thus they can only support small weird gates.
In this case, reduce `DUAL_WM_MAX_INPUT` to `3` or `2` to reduce the size of weird gates.

## 💬 Contacts

For any questions or collaboration inquiries:

- **Author**: Ping-Lun Wang
- **Email**: pinglunw [at] andrew [dot] cmu [dot] edu
- **Issues**: Open an issue on GitHub
- **Contributions**: Pull requests welcome!

---

**⭐ Star this repo if you find it useful!**

**🎓 Cite our paper:**
```bibtex
@inproceedings{flexo2024,
  title={Bending microarchitectural weird machines towards practicality},
  author={Wang, Ping-Lun and Paccagnella, Riccardo and Wahby, Riad S. and Brown, Fraser},
  booktitle={USENIX Security Symposium},
  year={2024}
}
```
