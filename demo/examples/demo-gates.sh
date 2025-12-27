#!/bin/bash

# demo-gates.sh - Demo script for basic logic gates
# Colorful, informative demo of Flexo weird machines

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Emojis
CHECK="✓"
CROSS="✗"
ROCKET="🚀"
GEAR="⚙️"
CLOCK="⏱️"
TARGET="🎯"
BOX="🔲"

# Helper functions
print_header() {
    echo -e "\n${CYAN}═══════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}${1}${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}\n"
}

print_section() {
    echo -e "\n${BLUE}▶ ${1}${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK} ${1}${NC}"
}

print_error() {
    echo -e "${RED}${CROSS} ${1}${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ ${1}${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${1}${NC}"
}

# Check if we're in the right directory
if [ ! -f "circuits/gates/test.cpp" ]; then
    print_error "Please run this script from the Flexo root directory"
    exit 1
fi

print_header "${BOX} FLEXO LOGIC GATES DEMO ${BOX}"

echo -e "${WHITE}This demo showcases basic logic gates implemented as weird machines:${NC}"
echo -e "  • AND, OR, NOT, NAND"
echo -e "  • XOR (2, 3, and 4 inputs)"
echo -e "  • MUX (multiplexer)"
echo ""
echo -e "${CYAN}Weird machines compute using microarchitectural side effects!${NC}"

# Step 1: Compile source to LLVM IR
print_section "${GEAR} Step 1: Compiling C++ source to LLVM IR"

print_info "Source: circuits/gates/test.cpp"
print_info "Running: make -C circuits/gates/"

if docker run -i -t --rm \
    --mount type=bind,source="$(pwd)"/,target=/flexo \
    flexo \
    make -C /flexo/circuits/gates/ > /tmp/make_output.log 2>&1; then
    print_success "LLVM IR generated: circuits/gates/test.ll"
else
    print_error "Compilation failed"
    cat /tmp/make_output.log
    exit 1
fi

# Step 2: Generate weird machine
print_section "${GEAR} Step 2: Generating weird machine with Flexo compiler"

print_info "Input: circuits/gates/test.ll"
print_info "Output: circuits/gates/test-wm.ll"
print_info "Running Flexo LLVM pass..."

echo -e "\n${MAGENTA}Detected Weird Functions:${NC}"

if docker run -i -t --rm \
    --mount type=bind,source="$(pwd)"/,target=/flexo \
    flexo \
    bash -c "cd /flexo && ./compile.sh circuits/gates/test.ll circuits/gates/test-wm.ll" 2>&1 | tee /tmp/compile_output.log; then
    print_success "Weird machine generated successfully"
else
    print_error "Compilation failed"
    exit 1
fi

# Step 3: Create executable
print_section "${GEAR} Step 3: Creating executable"

print_info "Linking with clang-17..."

if docker run -i -t --rm \
    --mount type=bind,source="$(pwd)"/,target=/flexo \
    flexo \
    clang-17 /flexo/circuits/gates/test-wm.ll -o /flexo/circuits/gates/test.elf -lm -lstdc++ > /tmp/link_output.log 2>&1; then
    print_success "Executable created: circuits/gates/test.elf"
else
    print_error "Linking failed"
    cat /tmp/link_output.log
    exit 1
fi

# Step 4: Run the weird machine
print_section "${ROCKET} Step 4: Executing weird machine"

print_info "Running 100,000 iterations per gate..."
print_info "Measuring accuracy, error detection, and timing..."

echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                  EXECUTION RESULTS                    ${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"

./circuits/gates/test.elf | while IFS= read -r line; do
    if [[ $line == "==="* ]]; then
        echo -e "${CYAN}${line}${NC}"
    elif [[ $line == *"Accuracy"* ]]; then
        # Extract accuracy percentage
        accuracy=$(echo "$line" | grep -oP '\d+\.\d+(?=%)' | head -1)
        if (( $(echo "$accuracy > 80" | bc -l) )); then
            echo -e "${GREEN}${line}${NC}"
        elif (( $(echo "$accuracy > 60" | bc -l) )); then
            echo -e "${YELLOW}${line}${NC}"
        else
            echo -e "${RED}${line}${NC}"
        fi
    elif [[ $line == *"Time usage"* ]]; then
        echo -e "${BLUE}${line}${NC}"
    else
        echo "$line"
    fi
done

# Summary
print_header "${TARGET} DEMO SUMMARY"

echo -e "${WHITE}Logic Gates Demo Completed!${NC}\n"

echo -e "${CYAN}What just happened?${NC}"
echo -e "  1. ${GREEN}Compiled${NC} C++ code to LLVM IR"
echo -e "  2. ${GREEN}Transformed${NC} functions into weird machines"
echo -e "  3. ${GREEN}Generated${NC} executable binary"
echo -e "  4. ${GREEN}Executed${NC} gates using cache side channels"
echo ""

echo -e "${CYAN}Key Metrics:${NC}"
echo -e "  • ${WHITE}Accuracy:${NC} Percentage of correct outputs"
echo -e "  • ${WHITE}Error Detected:${NC} Errors caught by built-in detection"
echo -e "  • ${WHITE}Undetected Error:${NC} Incorrect outputs not caught"
echo -e "  • ${WHITE}Time Usage:${NC} Average execution time per gate"
echo ""

echo -e "${CYAN}Understanding Results:${NC}"
echo -e "  • ${GREEN}Good:${NC} Accuracy > 80%"
echo -e "  • ${YELLOW}Acceptable:${NC} Accuracy 60-80%"
echo -e "  • ${RED}Needs Tuning:${NC} Accuracy < 60%"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  • Try arithmetic circuits: ${WHITE}bash demo/examples/demo-arithmetic.sh${NC}"
echo -e "  • Explore the 4-bit ALU: ${WHITE}bash demo/examples/demo-alu.sh${NC}"
echo -e "  • Read the examples guide: ${WHITE}docs/EXAMPLES.md${NC}"
echo ""

print_success "Logic gates demo completed successfully!"
echo ""
