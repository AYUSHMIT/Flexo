#!/bin/bash

# demo-arithmetic.sh - Demo script for arithmetic circuits
# Showcases adders and multipliers as weird machines

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
PLUS="➕"
CALC="🧮"

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
if [ ! -d "circuits/arithmetic" ]; then
    print_error "Please run this script from the Flexo root directory"
    exit 1
fi

print_header "${PLUS} FLEXO ARITHMETIC CIRCUITS DEMO ${CALC}"

echo -e "${WHITE}This demo showcases arithmetic operations as weird machines:${NC}"
echo -e "  • Half Adder (1-bit addition, ~5 gates)"
echo -e "  • Full Adder (1-bit addition with carry, ~9 gates)"
echo -e "  • Ripple Carry Adder (8-bit addition, ~72 gates)"
echo -e "  • Multiplier (8-bit multiplication, ~150 gates)"
echo ""
echo -e "${CYAN}More complex circuits = more gates = longer execution time!${NC}"

# Check if source files exist
if [ ! -f "circuits/arithmetic/adder.cpp" ]; then
    print_warning "Arithmetic source files not found in expected location"
    print_info "This demo requires adder and multiplier implementations"
    print_info "Please ensure circuits/arithmetic/ contains the necessary files"
    echo ""
    print_info "Showing directory contents:"
    ls -la circuits/arithmetic/
    echo ""
    print_warning "Demo cannot continue without source files"
    exit 0
fi

# Step 1: Compile adder
print_section "${GEAR} Step 1: Compiling Adder circuits"

print_info "Source: circuits/arithmetic/adder.cpp"
print_info "Running: make -C circuits/arithmetic/"

if docker run -i -t --rm \
    --mount type=bind,source="$(pwd)"/,target=/flexo \
    flexo \
    make -C /flexo/circuits/arithmetic/ adder > /tmp/make_adder.log 2>&1; then
    print_success "Adder LLVM IR generated"
else
    print_warning "Adder compilation not available"
    print_info "Please check circuits/arithmetic/Makefile"
fi

# Step 2: Generate weird machine for adder
print_section "${GEAR} Step 2: Generating weird machine for Adder"

print_info "Running Flexo compiler on adder..."

if [ -f "circuits/arithmetic/adder.ll" ]; then
    if docker run -i -t --rm \
        --mount type=bind,source="$(pwd)"/,target=/flexo \
        flexo \
        bash -c "cd /flexo && ./compile.sh circuits/arithmetic/adder.ll circuits/arithmetic/adder-wm.ll" 2>&1 | head -20; then
        print_success "Adder weird machine generated"
    else
        print_error "Adder weird machine generation failed"
        exit 1
    fi
else
    print_warning "Skipping adder weird machine generation"
fi

# Step 3: Create executable for adder
print_section "${GEAR} Step 3: Creating Adder executable"

if [ -f "circuits/arithmetic/adder-wm.ll" ]; then
    if docker run -i -t --rm \
        --mount type=bind,source="$(pwd)"/,target=/flexo \
        flexo \
        clang-17 /flexo/circuits/arithmetic/adder-wm.ll -o /flexo/circuits/arithmetic/adder.elf -lm -lstdc++ > /tmp/link_adder.log 2>&1; then
        print_success "Adder executable created"
    else
        print_error "Adder linking failed"
    fi
fi

# Step 4: Run adder
print_section "${ROCKET} Step 4: Executing Adder weird machine"

if [ -f "circuits/arithmetic/adder.elf" ]; then
    print_info "Running adder tests..."
    
    echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}                ADDER EXECUTION RESULTS               ${NC}"
    echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"
    
    ./circuits/arithmetic/adder.elf 2>&1 | head -50 | while IFS= read -r line; do
        if [[ $line == "==="* ]]; then
            echo -e "${CYAN}${line}${NC}"
        elif [[ $line == *"Accuracy"* ]]; then
            accuracy=$(echo "$line" | grep -oP '\d+\.\d+(?=%)' | head -1)
            if (( $(echo "$accuracy > 80" | bc -l) 2>/dev/null )); then
                echo -e "${GREEN}${line}${NC}"
            elif (( $(echo "$accuracy > 60" | bc -l) 2>/dev/null )); then
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
else
    print_warning "Adder executable not found, skipping execution"
fi

# Similar steps for multiplier
print_section "${GEAR} Step 5: Compiling Multiplier circuit"

if [ -f "circuits/arithmetic/mul.cpp" ]; then
    print_info "Source: circuits/arithmetic/mul.cpp"
    
    if docker run -i -t --rm \
        --mount type=bind,source="$(pwd)"/,target=/flexo \
        flexo \
        make -C /flexo/circuits/arithmetic/ mul > /tmp/make_mul.log 2>&1; then
        print_success "Multiplier LLVM IR generated"
        
        # Generate weird machine
        print_section "${GEAR} Step 6: Generating weird machine for Multiplier"
        
        if docker run -i -t --rm \
            --mount type=bind,source="$(pwd)"/,target=/flexo \
            flexo \
            bash -c "cd /flexo && ./compile.sh circuits/arithmetic/mul.ll circuits/arithmetic/mul-wm.ll" 2>&1 | head -20; then
            print_success "Multiplier weird machine generated"
            
            # Create executable
            print_section "${GEAR} Step 7: Creating Multiplier executable"
            
            if docker run -i -t --rm \
                --mount type=bind,source="$(pwd)"/,target=/flexo \
                flexo \
                clang-17 /flexo/circuits/arithmetic/mul-wm.ll -o /flexo/circuits/arithmetic/mul.elf -lm -lstdc++ > /tmp/link_mul.log 2>&1; then
                print_success "Multiplier executable created"
                
                # Run multiplier
                print_section "${ROCKET} Step 8: Executing Multiplier weird machine"
                
                print_info "Running multiplier tests (this may take longer)..."
                
                echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
                echo -e "${WHITE}             MULTIPLIER EXECUTION RESULTS             ${NC}"
                echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"
                
                ./circuits/arithmetic/mul.elf 2>&1 | head -50 | while IFS= read -r line; do
                    if [[ $line == "==="* ]]; then
                        echo -e "${CYAN}${line}${NC}"
                    elif [[ $line == *"Accuracy"* ]]; then
                        accuracy=$(echo "$line" | grep -oP '\d+\.\d+(?=%)' | head -1)
                        if (( $(echo "$accuracy > 80" | bc -l) 2>/dev/null )); then
                            echo -e "${GREEN}${line}${NC}"
                        elif (( $(echo "$accuracy > 60" | bc -l) 2>/dev/null )); then
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
            fi
        fi
    else
        print_warning "Multiplier compilation not available"
    fi
else
    print_warning "Multiplier source not found, skipping"
fi

# Summary
print_header "${CALC} DEMO SUMMARY"

echo -e "${WHITE}Arithmetic Circuits Demo Completed!${NC}\n"

echo -e "${CYAN}What we demonstrated:${NC}"
echo -e "  1. ${GREEN}Multi-gate circuits${NC} working together"
echo -e "  2. ${GREEN}Carry propagation${NC} in ripple carry adders"
echo -e "  3. ${GREEN}Complex operations${NC} like multiplication"
echo -e "  4. ${GREEN}Scaling behavior${NC} as circuit size increases"
echo ""

echo -e "${CYAN}Observations:${NC}"
echo -e "  • ${WHITE}Time increases${NC} with number of gates"
echo -e "  • ${WHITE}Accuracy decreases${NC} slightly with complexity"
echo -e "  • ${WHITE}Error detection${NC} becomes more important"
echo -e "  • ${WHITE}Still practical${NC} for microsecond-scale operations"
echo ""

echo -e "${CYAN}Performance Notes:${NC}"
echo -e "  • Half Adder: ~5 gates, ~5 μs"
echo -e "  • Full Adder: ~9 gates, ~8 μs"
echo -e "  • 8-bit Adder: ~72 gates, ~60 μs"
echo -e "  • 8-bit Multiplier: ~150 gates, ~120 μs"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  • Try the 4-bit ALU: ${WHITE}bash demo/examples/demo-alu.sh${NC}"
echo -e "  • Explore cryptographic circuits: ${WHITE}bash demo/examples/demo-crypto.sh${NC}"
echo -e "  • Read benchmarks: ${WHITE}docs/BENCHMARKS.md${NC}"
echo ""

print_success "Arithmetic circuits demo completed!"
echo ""
