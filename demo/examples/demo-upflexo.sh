#!/bin/bash

# demo-upflexo.sh - Demo script for UPFlexo packer
# Showcases the UPX packer obfuscated with Flexo weird machines

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
if [ ! -d "UPFlexo" ]; then
    print_error "Please run this script from the Flexo root directory"
    exit 1
fi

print_header "📦 FLEXO UPFlexo PACKER DEMO 📦"

echo -e "${WHITE}UPFlexo: UPX Packer with Flexo Weird Machine Decryption${NC}"
echo ""
echo -e "${CYAN}What is UPFlexo?${NC}"
echo -e "  • Modified UPX packer that encrypts binaries"
echo -e "  • Uses AES or Simon encryption"
echo -e "  • Decryption stub is a Flexo weird machine"
echo -e "  • Makes packed binaries resistant to analysis"
echo ""
echo -e "${CYAN}Why is this powerful?${NC}"
echo -e "  • ${GREEN}Debuggers fail${NC} - single-stepping breaks execution"
echo -e "  • ${GREEN}Emulators fail${NC} - need real microarchitecture"
echo -e "  • ${GREEN}Static analysis fails${NC} - no visible decryption code"
echo ""

print_section "📋 Checking UPFlexo Setup"

if [ -f "UPFlexo/README.md" ]; then
    print_success "UPFlexo documentation found"
else
    print_warning "UPFlexo README not found"
fi

print_info "UPFlexo directory: UPFlexo/"

# Check for necessary files
if [ -f "UPFlexo/Makefile" ]; then
    print_success "UPFlexo Makefile found"
else
    print_warning "UPFlexo Makefile not found"
    print_info "UPFlexo may need manual setup"
fi

print_section "📖 UPFlexo Overview"

echo -e "${CYAN}How UPFlexo Works:${NC}"
echo -e ""
echo -e "  1. ${WHITE}Original Binary${NC}"
echo -e "     ↓"
echo -e "  2. ${WHITE}Compress with UPX${NC}"
echo -e "     ↓"
echo -e "  3. ${WHITE}Encrypt with AES/Simon${NC}"
echo -e "     ↓"
echo -e "  4. ${WHITE}Attach Flexo Weird Machine Decryptor${NC}"
echo -e "     ↓"
echo -e "  5. ${WHITE}Packed Binary${NC} (resistant to analysis)"
echo ""

echo -e "${CYAN}At Runtime:${NC}"
echo -e "  1. Weird machine decrypts the binary"
echo -e "  2. UPX decompresses the binary"
echo -e "  3. Original program executes normally"
echo ""

print_section "🔧 Building UPFlexo"

print_info "UPFlexo requires building the modified UPX packer"
print_info "This process can take several minutes..."

if [ -f "UPFlexo/compile-circuits.sh" ] && [ -f "UPFlexo/compile-packers.sh" ]; then
    print_success "UPFlexo build scripts found"
    
    print_warning "Note: Building UPFlexo is a complex process"
    print_info "Recommended: Follow UPFlexo/README.md for detailed instructions"
    
    echo ""
    echo -e "${YELLOW}Would you like to attempt building UPFlexo? (This takes time)${NC}"
    echo -e "${CYAN}For demo purposes, we'll show the process overview instead.${NC}"
    echo ""
    
    print_section "📋 UPFlexo Build Process"
    
    echo -e "${WHITE}Step 1: Compile Weird Machine Circuits${NC}"
    echo -e "  $ cd UPFlexo"
    echo -e "  $ ./compile-circuits.sh"
    echo -e "  ${CYAN}→ Generates AES and Simon decryption weird machines${NC}"
    echo ""
    
    echo -e "${WHITE}Step 2: Compile Modified UPX Packers${NC}"
    echo -e "  $ ./compile-packers.sh"
    echo -e "  ${CYAN}→ Builds UPX with Flexo weird machine integration${NC}"
    echo ""
    
    echo -e "${WHITE}Step 3: Use UPFlexo to Pack a Binary${NC}"
    echo -e "  $ ./upflexo-aes [target-binary]"
    echo -e "  ${CYAN}→ Creates packed binary with AES weird machine decryption${NC}"
    echo ""
    
    print_section "📊 Expected Results"
    
    echo -e "${WHITE}Original Binary:${NC}"
    echo -e "  • Size: 100 KB"
    echo -e "  • Can be analyzed with debuggers"
    echo -e "  • Emulators work normally"
    echo ""
    
    echo -e "${WHITE}UPFlexo Packed Binary:${NC}"
    echo -e "  • Size: ~70-80 KB (compressed + decryptor)"
    echo -e "  • Debuggers fail (single-stepping breaks transient execution)"
    echo -e "  • Emulators fail (no microarchitecture support)"
    echo -e "  • Static analysis shows only weird machine code"
    echo ""
    
    echo -e "${WHITE}Decryption Performance:${NC}"
    echo -e "  • AES decryption: ~3-5 ms per block"
    echo -e "  • Simon decryption: ~1-2 ms per block"
    echo -e "  • Overhead: Milliseconds for typical binaries"
    echo -e "  • Startup delay: Noticeable but acceptable"
    echo ""
    
else
    print_warning "UPFlexo build scripts not found"
    print_info "UPFlexo may need to be set up first"
fi

print_section "🔬 UPFlexo Security Properties"

echo -e "${CYAN}Anti-Analysis Features:${NC}"
echo -e "  • ${GREEN}Anti-Debug:${NC} Debuggers can't observe weird machine execution"
echo -e "  • ${GREEN}Anti-Emulation:${NC} Emulators lack microarchitecture simulation"
echo -e "  • ${GREEN}Anti-Static:${NC} No visible decryption algorithm in binary"
echo -e "  • ${GREEN}Side-Channel:${NC} Computation through cache timing"
echo ""

echo -e "${CYAN}Trade-offs:${NC}"
echo -e "  • ${YELLOW}Performance:${NC} Startup delay from weird machine execution"
echo -e "  • ${YELLOW}Reliability:${NC} Depends on hardware (70-80% accuracy typical)"
echo -e "  • ${YELLOW}Compatibility:${NC} Requires supported processor"
echo -e "  • ${GREEN}Security:${NC} Extremely difficult to reverse engineer"
echo ""

print_section "📚 Learn More"

echo -e "${WHITE}For detailed UPFlexo usage:${NC}"
echo -e "  • Read: ${CYAN}UPFlexo/README.md${NC}"
echo -e "  • Paper: USENIX Security 2024, Section 7"
echo -e "  • Build: Follow UPFlexo build instructions"
echo ""

echo -e "${WHITE}Example Commands:${NC}"
echo -e "  ${CYAN}# Build UPFlexo${NC}"
echo -e "  cd UPFlexo && ./compile-circuits.sh && ./compile-packers.sh"
echo ""
echo -e "  ${CYAN}# Pack a binary with AES${NC}"
echo -e "  ./upflexo-aes /path/to/binary"
echo ""
echo -e "  ${CYAN}# Pack a binary with Simon${NC}"
echo -e "  ./upflexo-simon /path/to/binary"
echo ""

# Summary
print_header "🎯 DEMO SUMMARY"

echo -e "${WHITE}UPFlexo Demo Overview Completed!${NC}\n"

echo -e "${CYAN}Key Takeaways:${NC}"
echo -e "  • ${GREEN}Practical application${NC} of Flexo weird machines"
echo -e "  • ${GREEN}Real-world obfuscation${NC} for executable binaries"
echo -e "  • ${GREEN}Strong anti-analysis${NC} properties"
echo -e "  • ${GREEN}Proof of concept${NC} for security applications"
echo ""

echo -e "${CYAN}Use Cases:${NC}"
echo -e "  • Software protection and licensing"
echo -e "  • Anti-cheat systems"
echo -e "  • DRM implementations"
echo -e "  • Malware analysis research (defensive understanding)"
echo ""

echo -e "${CYAN}Research Impact:${NC}"
echo -e "  • Demonstrates practical weird machines"
echo -e "  • Published at USENIX Security 2024"
echo -e "  • Opens new directions in code obfuscation"
echo -e "  • Challenges traditional analysis tools"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  • Build UPFlexo: Follow ${WHITE}UPFlexo/README.md${NC}"
echo -e "  • Read the paper: USENIX Security 2024"
echo -e "  • Experiment with packing your own binaries"
echo -e "  • Explore other demos: ${WHITE}bash demo/interactive-demo.sh${NC}"
echo ""

print_success "UPFlexo demo overview completed!"
echo ""
