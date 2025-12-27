# ⚡ Quick Start Guide - Flexo in 5 Minutes

Get up and running with Flexo weird machines in just 5 minutes!

## 📋 Prerequisites

- Docker or Podman installed
- Linux environment (or WSL on Windows)
- 4GB RAM minimum
- Internet connection for initial setup

## 🚀 Step 1: Clone and Build (2 minutes)

```bash
# Clone the repository
git clone https://github.com/AYUSHMIT/Flexo.git
cd Flexo

# Build the Docker container and compiler
docker build -t flexo .
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./build.sh"
```

**Expected Output:**
```
[1/3] Building CXX object lib/CMakeFiles/Flexo.dir/...
[2/3] Building CXX object lib/CMakeFiles/Flexo.dir/...
[3/3] Linking CXX shared library lib/libFlexo.so
```

✅ **Success**: You should see `libFlexo.so` in the `build/lib/` directory.

## 🔲 Step 2: Run Your First Weird Machine (1 minute)

Let's compile and run the basic logic gates example:

```bash
# Compile the source to LLVM IR
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  make -C /flexo/circuits/gates/

# Generate the weird machine
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll"

# Create executable
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  clang-17 /flexo/circuits/gates/test-wm.ll -o /flexo/circuits/gates/test.elf -lm -lstdc++
```

**Expected Output from compile.sh:**
```
Found weird function: _Z12__weird__andbbRb
[Circuit] Wires: 5
[Circuit] Gates: 1
Found weird function: _Z11__weird__orbbRb
[Circuit] Wires: 5
[Circuit] Gates: 1
...
```

## 🎯 Step 3: Execute the Weird Machine (1 minute)

```bash
# Run the weird machine
./circuits/gates/test.elf
```

**Expected Output:**
```
=== AND gate ===
Accuracy: 94.80200%, Error detected: 5.04200%, Undetected error: 0.15600%
Time usage: 0.764 (us)
over 100000 iterations.

=== OR gate ===
Accuracy: 89.81200%, Error detected: 9.91900%, Undetected error: 0.26900%
Time usage: 0.785 (us)
over 100000 iterations.

=== NOT gate ===
Accuracy: 91.18300%, Error detected: 8.52500%, Undetected error: 0.29200%
Time usage: 0.651 (us)
over 100000 iterations.
```

✅ **Success**: If accuracy is above 70%, your weird machine is working!

## 📊 Understanding the Output

| Metric | Meaning |
|--------|---------|
| **Accuracy** | Percentage of correct outputs |
| **Error detected** | Percentage where error detection caught mistakes |
| **Undetected error** | Percentage of incorrect outputs without detection |
| **Time usage** | Average execution time per gate operation |

**Good Results**: 
- Accuracy > 70% ✅
- Undetected error < 5% ✅

## 🎨 Step 4: Try the Interactive Demo (1 minute)

```bash
# Run the interactive demo menu
bash demo/interactive-demo.sh
```

This provides a menu-driven interface to explore all examples!

## 📚 What's Next?

### 🔰 Beginner Path
1. ✅ Run basic gates (you just did this!)
2. 📖 Read [EXAMPLES.md](EXAMPLES.md) to understand circuits
3. 🧮 Try the arithmetic examples
4. 🎓 Learn about [ARCHITECTURE.md](ARCHITECTURE.md)

### 🚀 Intermediate Path
1. 🔧 Modify gate configurations (see [Configuration](#configuration))
2. ➕ Explore adders and multipliers
3. 🧮 Build the 4-bit ALU
4. 📊 Check [BENCHMARKS.md](BENCHMARKS.md)

### 🔬 Advanced Path
1. 🔐 Build AES encryption weird machine
2. 🔒 Try SHA-1 hashing
3. 📦 Explore UPFlexo packer
4. 🛠️ Create your own weird machine

## 🔧 Configuration

Flexo can be configured via environment variables. Try adjusting:

```bash
# Adjust transient window size
export RET_WM_DIV_ROUNDS=5

# Change weird register spacing
export WR_OFFSET=576

# Compile with custom settings
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && RET_WM_DIV_ROUNDS=10 WR_OFFSET=960 ./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll"
```

**Common Settings:**

| Variable | Default | Purpose |
|----------|---------|---------|
| `RET_WM_DIV_ROUNDS` | 5 | Controls transient window length |
| `WR_OFFSET` | 576 | Memory spacing between registers |
| `WM_DELAY` | 256 | Delay between gate executions |
| `WR_TYPE` | Dual | Weird register type (Baseline/NoBranch/Dual) |

## 🐛 Troubleshooting

### Issue: Low Accuracy (< 70%)

**Possible Causes:**
- Unsupported processor
- Incorrect configuration

**Solutions:**
```bash
# Try different RET_WM_DIV_ROUNDS values (1-50)
export RET_WM_DIV_ROUNDS=10
./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll

# Try different WR_OFFSET values
export WR_OFFSET=960  # Try: 192, 320, 448, 576, 960, 1088
./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll

# Use smaller gates for limited transient windows
export DUAL_WM_MAX_INPUT=2
./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll
```

### Issue: Compilation Errors

**Problem**: `clang-17: command not found`

**Solution**: Use Docker container for all commands:
```bash
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash
# Now you're inside the container with all tools available
```

### Issue: Build Failures

**Problem**: CMake or Ninja errors

**Solution**: Clean and rebuild:
```bash
rm -rf build/
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./build.sh"
```

### Issue: Docker Permission Errors

**Problem**: Permission denied accessing files

**Solution**: Fix permissions:
```bash
sudo chown -R $USER:$USER .
```

### Issue: Weird Machine Crashes

**Problem**: Segmentation fault or unexpected termination

**Solution**: 
1. Enable mmap for larger circuits:
   ```bash
   export WR_USE_MMAP=true
   ```
2. Increase memory limit in Docker:
   ```bash
   docker run -i -t --rm --memory="4g" \
     --mount type=bind,source="$(pwd)"/,target=/flexo \
     flexo
   ```

## 📖 Common Commands Cheatsheet

```bash
# Build compiler
docker build -t flexo .
./build.sh  # (inside container)

# Compile a weird machine (3 steps)
# 1. C++ to LLVM IR
clang-17 -fno-discard-value-names -fno-inline-functions -O1 -S -emit-llvm input.cpp -o input.ll

# 2. LLVM IR to Weird Machine
./compile.sh input.ll output-wm.ll

# 3. Weird Machine to Executable
clang-17 output-wm.ll -o output.elf -lm -lstdc++

# Run demos
bash demo/interactive-demo.sh            # Interactive menu
bash demo/examples/demo-gates.sh         # Logic gates
bash demo/examples/demo-arithmetic.sh    # Arithmetic
bash demo/examples/demo-alu.sh           # ALU
bash demo/examples/demo-crypto.sh        # Cryptography
bash demo/examples/demo-upflexo.sh       # UPFlexo packer

# Check configurations
env | grep WM_
env | grep WR_
env | grep RET_
```

## 🎯 Example Workflow: Creating Your Own Weird Machine

```bash
# 1. Write your weird machine in C++
cat > my_gate.cpp << 'EOF'
bool __weird__xor(bool in1, bool in2, bool& out) {
    out = in1 ^ in2;
    return false;
}

int main() {
    bool result;
    __weird__xor(true, false, result);
    printf("Result: %d\n", result);
    return 0;
}
EOF

# 2. Compile to LLVM IR
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  clang-17 -fno-discard-value-names -fno-inline-functions -O1 -S -emit-llvm /flexo/my_gate.cpp -o /flexo/my_gate.ll

# 3. Generate weird machine
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  bash -c "cd /flexo && ./compile.sh my_gate.ll my_gate-wm.ll"

# 4. Create executable
docker run -i -t --rm \
  --mount type=bind,source="$(pwd)"/,target=/flexo \
  flexo \
  clang-17 /flexo/my_gate-wm.ll -o /flexo/my_gate.elf -lm -lstdc++

# 5. Run it!
./my_gate.elf
```

## ✅ Verification Checklist

After completing this quick start, you should have:

- [x] Built the Flexo compiler
- [x] Compiled a weird machine
- [x] Executed the weird machine successfully
- [x] Understood the output metrics
- [x] Know where to find more examples

## 🎓 Learning Path

**Time Investment**: 30-60 minutes total

1. ✅ **Quick Start** (5 min) - You are here!
2. 📖 **[EXAMPLES.md](EXAMPLES.md)** (15 min) - Explore all circuits
3. 🏗️ **[ARCHITECTURE.md](ARCHITECTURE.md)** (20 min) - Understand internals
4. 📊 **[BENCHMARKS.md](BENCHMARKS.md)** (10 min) - Performance analysis
5. 🎯 **[README.md](../README.md)** (10 min) - Complete documentation

## 💡 Pro Tips

1. **Start Simple**: Always test with gates before complex circuits
2. **Check Hardware**: Verify you're on supported hardware (see DEMO.md)
3. **Monitor Accuracy**: Keep accuracy above 70% for reliable results
4. **Experiment**: Try different configuration values
5. **Use Docker**: Avoid dependency issues by using containers

## 🆘 Getting Help

1. **Documentation**: Read the full [README.md](../README.md)
2. **Examples**: Check existing circuits in `circuits/` directory
3. **Issues**: Open an issue on GitHub
4. **Contact**: Email pinglunw [at] andrew [dot] cmu [dot] edu

---

**🎉 Congratulations!** You've successfully run your first microarchitectural weird machine!

**Next**: Explore [detailed examples](EXAMPLES.md) or try the [interactive demo](../demo/interactive-demo.sh)!
