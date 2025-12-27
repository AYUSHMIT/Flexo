#!/bin/bash

# demo-alu.sh - Demo script for 4-bit ALU
# Demonstrates a complete arithmetic logic unit as a weird machine

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

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
    echo -e "${GREEN}✓ ${1}${NC}"
}

print_error() {
    echo -e "${RED}✗ ${1}${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ ${1}${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${1}${NC}"
}

# Check directory
if [ ! -d "circuits/ALU" ]; then
    print_error "Please run this script from the Flexo root directory"
    exit 1
fi

print_header "🧮 FLEXO 4-BIT ALU DEMO 🧮"

echo -e "${WHITE}This demo showcases a complete 4-bit ALU as a weird machine:${NC}"
echo -e "  • Multiple operations: ADD, SUB, AND, OR, XOR, NOT, shifts"
echo -e "  • 50+ gates working together"
echo -e "  • Flag generation: Zero, Carry, Overflow"
echo -e "  • Execution time: ~140 microseconds per operation"
echo ""
echo -e "${CYAN}This demonstrates the capability for complex circuits!${NC}"

# Check if ALU directory has necessary files
print_section "⚙️ Checking ALU circuit files"

if [ ! -f "circuits/ALU/README.md" ]; then
    print_warning "ALU README not found"
else
    print_success "ALU documentation found"
fi

print_info "ALU circuits use Verilog or C++ implementations"
print_info "Refer to circuits/ALU/README.md for build instructions"

# Check for Makefile
if [ -f "circuits/ALU/Makefile" ]; then
    print_success "ALU Makefile found"
    
    # Try to build
    print_section "⚙️ Building ALU circuit"
    
    if docker run -i -t --rm \
        --mount type=bind,source="$(pwd)"/,target=/flexo \
        flexo \
        make -C /flexo/circuits/ALU/ > /tmp/make_alu.log 2>&1; then
        print_success "ALU LLVM IR generated"
        
        # Generate weird machine
        print_section "⚙️ Generating ALU weird machine"
        
        # Find the generated .ll file
        alu_ll=$(find circuits/ALU/ -name "*.ll" ! -name "*-wm.ll" | head -1)
        
        if [ -n "$alu_ll" ]; then
            print_info "Input: $alu_ll"
            
            if docker run -i -t --rm \
                --mount type=bind,source="$(pwd)"/,target=/flexo \
                flexo \
                bash -c "cd /flexo && ./compile.sh $alu_ll circuits/ALU/alu-wm.ll" 2>&1 | head -30; then
                print_success "ALU weird machine generated"
                
                # Create executable
                print_section "⚙️ Creating ALU executable"
                
                if docker run -i -t --rm \
                    --mount type=bind,source="$(pwd)"/,target=/flexo \
                    flexo \
                    clang-17 /flexo/circuits/ALU/alu-wm.ll -o /flexo/circuits/ALU/alu.elf -lm -lstdc++ > /tmp/link_alu.log 2>&1; then
                    print_success "ALU executable created"
                    
                    # Run ALU
                    print_section "🚀 Executing ALU weird machine"
                    
                    print_info "Running ALU operations..."
                    
                    echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
                    echo -e "${WHITE}                ALU EXECUTION RESULTS                 ${NC}"
                    echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"
                    
                    ./circuits/ALU/alu.elf 2>&1 | head -100 | while IFS= read -r line; do
                        if [[ $line == "==="* ]]; then
                            echo -e "${CYAN}${line}${NC}"
                        elif [[ $line == *"Accuracy"* ]]; then
                            accuracy=$(echo "$line" | grep -oP '\d+\.\d+(?=%)' | head -1)
                            if (( $(echo "$accuracy > 75" | bc -l) 2>/dev/null )); then
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
                    print_error "ALU linking failed"
                fi
            else
                print_error "ALU weird machine generation failed"
            fi
        else
            print_warning "No LLVM IR file found for ALU"
        fi
    else
        print_warning "ALU build not available"
        print_info "Check circuits/ALU/Makefile and README.md"
    fi
else
    print_warning "ALU Makefile not found"
    print_info "Please check circuits/ALU/ directory"
    print_info "You may need to set up the ALU circuit following circuits/ALU/README.md"
fi

# Summary
print_header "🎯 DEMO SUMMARY"

echo -e "${WHITE}4-bit ALU Demo Completed!${NC}\n"

echo -e "${CYAN}What the ALU demonstrates:${NC}"
echo -e "  • ${GREEN}Multiple operations${NC} in one circuit"
echo -e "  • ${GREEN}Complex gate coordination${NC} (50+ gates)"
echo -e "  • ${GREEN}Flag generation${NC} (Zero, Carry, Overflow)"
echo -e "  • ${GREEN}Real computer component${NC} as a weird machine"
echo ""

echo -e "${CYAN}ALU Operations:${NC}"
echo -e "  • Arithmetic: ADD, SUB"
echo -e "  • Logical: AND, OR, XOR, NOT"
echo -e "  • Shift: SHL, SHR"
echo -e "  • Status: Zero flag, Carry flag, Overflow flag"
echo ""

echo -e "${CYAN}Performance Characteristics:${NC}"
echo -e "  • Gates: 50-60 (depends on implementation)"
echo -e "  • Time: ~135-145 microseconds per operation"
echo -e "  • Accuracy: 75-85% typical"
echo -e "  • Throughput: ~7,000 operations/second"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  • Try cryptographic circuits: ${WHITE}bash demo/examples/demo-crypto.sh${NC}"
echo -e "  • Read the ALU README: ${WHITE}circuits/ALU/README.md${NC}"
echo -e "  • Explore architecture: ${WHITE}docs/ARCHITECTURE.md${NC}"
echo ""

print_success "4-bit ALU demo completed!"
echo ""
