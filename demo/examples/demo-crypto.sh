#!/bin/bash

# demo-crypto.sh - Demo script for cryptographic circuits
# Showcases AES, SHA-1, and Simon ciphers as weird machines

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
if [ ! -d "circuits" ]; then
    print_error "Please run this script from the Flexo root directory"
    exit 1
fi

print_header "🔐 FLEXO CRYPTOGRAPHIC CIRCUITS DEMO 🔐"

echo -e "${WHITE}This demo showcases complex cryptographic algorithms as weird machines:${NC}"
echo -e "  • 🔐 AES-128: Block cipher with 1000+ gates"
echo -e "  • 🔒 SHA-1: Hash function with 500+ gates"
echo -e "  • 🔑 Simon: Lightweight cipher with 800+ gates"
echo ""
echo -e "${CYAN}These demonstrate that even complex crypto can be obfuscated!${NC}"
echo -e "${YELLOW}Note: Execution time is milliseconds (much slower than basic gates)${NC}"

# Function to demo a crypto circuit
demo_crypto_circuit() {
    local name=$1
    local dir=$2
    local emoji=$3
    
    print_section "${emoji} ${name} Cipher"
    
    if [ ! -d "circuits/${dir}" ]; then
        print_warning "${name} circuit directory not found"
        return
    fi
    
    print_info "Circuit: circuits/${dir}/"
    
    if [ -f "circuits/${dir}/Makefile" ]; then
        print_info "Building ${name}..."
        
        if docker run -i -t --rm \
            --mount type=bind,source="$(pwd)"/,target=/flexo \
            flexo \
            make -C /flexo/circuits/${dir}/ > /tmp/make_${dir}.log 2>&1; then
            print_success "${name} LLVM IR generated"
            
            # Find the main .ll file
            main_ll=$(find circuits/${dir}/ -name "*.ll" ! -name "*-wm.ll" | head -1)
            
            if [ -n "$main_ll" ]; then
                print_info "Generating weird machine..."
                print_warning "This may take a while (complex circuit)..."
                
                if timeout 300 docker run -i -t --rm \
                    --mount type=bind,source="$(pwd)"/,target=/flexo \
                    flexo \
                    bash -c "cd /flexo && ./compile.sh $main_ll circuits/${dir}/${dir}-wm.ll" > /tmp/compile_${dir}.log 2>&1; then
                    
                    # Show circuit stats
                    echo ""
                    grep -E "(Found weird|Wires:|Gates:)" /tmp/compile_${dir}.log | head -20
                    echo ""
                    
                    print_success "${name} weird machine generated"
                    
                    # Create executable
                    print_info "Creating executable..."
                    
                    if docker run -i -t --rm \
                        --mount type=bind,source="$(pwd)"/,target=/flexo \
                        flexo \
                        clang-17 /flexo/circuits/${dir}/${dir}-wm.ll -o /flexo/circuits/${dir}/${dir}.elf -lm -lstdc++ > /tmp/link_${dir}.log 2>&1; then
                        print_success "${name} executable created"
                        
                        # Run it
                        print_info "Executing ${name} weird machine..."
                        print_warning "This will take several seconds..."
                        
                        echo -e "\n${YELLOW}═══════════════════════════════════════════════════════${NC}"
                        echo -e "${WHITE}           ${name} EXECUTION RESULTS                   ${NC}"
                        echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}\n"
                        
                        timeout 120 ./circuits/${dir}/${dir}.elf 2>&1 | head -50 | while IFS= read -r line; do
                            if [[ $line == "==="* ]]; then
                                echo -e "${CYAN}${line}${NC}"
                            elif [[ $line == *"Accuracy"* ]]; then
                                accuracy=$(echo "$line" | grep -oP '\d+\.\d+(?=%)' | head -1)
                                if (( $(echo "$accuracy > 70" | bc -l) 2>/dev/null )); then
                                    echo -e "${GREEN}${line}${NC}"
                                elif (( $(echo "$accuracy > 50" | bc -l) 2>/dev/null )); then
                                    echo -e "${YELLOW}${line}${NC}"
                                else
                                    echo -e "${RED}${line}${NC}"
                                fi
                            elif [[ $line == *"Time usage"* ]] || [[ $line == *"ms"* ]]; then
                                echo -e "${BLUE}${line}${NC}"
                            else
                                echo "$line"
                            fi
                        done || print_warning "Execution timeout (circuit too complex for demo)"
                        
                    else
                        print_error "${name} linking failed"
                    fi
                else
                    print_warning "${name} weird machine generation timed out or failed"
                    print_info "Complex crypto circuits can take several minutes to compile"
                fi
            else
                print_warning "No LLVM IR file found for ${name}"
            fi
        else
            print_warning "${name} build failed"
            print_info "Check circuits/${dir}/Makefile and README.md"
        fi
    else
        print_warning "${name} Makefile not found"
        print_info "Please check circuits/${dir}/ directory structure"
    fi
}

# Demo AES
demo_crypto_circuit "AES-128" "AES" "🔐"

# Demo Simon
demo_crypto_circuit "Simon" "Simon" "🔑"

# Demo SHA-1
demo_crypto_circuit "SHA-1" "SHA1" "🔒"

# Summary
print_header "🎯 DEMO SUMMARY"

echo -e "${WHITE}Cryptographic Circuits Demo Completed!${NC}\n"

echo -e "${CYAN}What we demonstrated:${NC}"
echo -e "  • ${GREEN}Complex algorithms${NC} (1000+ gates) as weird machines"
echo -e "  • ${GREEN}Practical obfuscation${NC} for real cryptographic code"
echo -e "  • ${GREEN}Error detection${NC} crucial for reliability"
echo -e "  • ${GREEN}Millisecond-scale${NC} execution (still practical)"
echo ""

echo -e "${CYAN}Performance Overview:${NC}"
echo -e "  • AES-128: ~1000+ gates, ~3-5 ms per block"
echo -e "  • SHA-1: ~500+ gates, ~1-3 ms per round"
echo -e "  • Simon: ~800+ gates, ~1-2 ms per block"
echo ""

echo -e "${CYAN}Accuracy Expectations:${NC}"
echo -e "  • ${GREEN}Good:${NC} 70-80% for crypto circuits"
echo -e "  • ${YELLOW}Acceptable:${NC} 60-70%"
echo -e "  • ${WHITE}Note:${NC} Lower than simple gates but still functional"
echo -e "  • ${WHITE}Error detection:${NC} 20-25% typical"
echo ""

echo -e "${CYAN}Use Cases:${NC}"
echo -e "  • Software protection and DRM"
echo -e "  • Anti-reverse engineering"
echo -e "  • Key obfuscation in software"
echo -e "  • Packer/loader implementations (see UPFlexo)"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  • Try UPFlexo packer: ${WHITE}bash demo/examples/demo-upflexo.sh${NC}"
echo -e "  • Read benchmarks: ${WHITE}docs/BENCHMARKS.md${NC}"
echo -e "  • Explore the paper: USENIX Security 2024"
echo ""

print_success "Cryptographic circuits demo completed!"
echo ""
