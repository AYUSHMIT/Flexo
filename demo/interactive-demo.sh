#!/bin/bash

# interactive-demo.sh - Main interactive demo for Flexo
# Provides a menu-driven interface to explore all examples

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print the banner
print_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   ███████╗██╗     ███████╗██╗  ██╗ ██████╗                  ║
║   ██╔════╝██║     ██╔════╝╚██╗██╔╝██╔═══██╗                 ║
║   █████╗  ██║     █████╗   ╚███╔╝ ██║   ██║                 ║
║   ██╔══╝  ██║     ██╔══╝   ██╔██╗ ██║   ██║                 ║
║   ██║     ███████╗███████╗██╔╝ ██╗╚██████╔╝                 ║
║   ╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝                  ║
║                                                               ║
║        Microarchitectural Weird Machines Demo                ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${WHITE}Welcome to the Flexo Interactive Demo!${NC}"
    echo -e "${CYAN}Explore microarchitectural weird machines through guided examples${NC}"
    echo ""
}

# Function to print section header
print_section() {
    echo -e "\n${CYAN}═══════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}${1}${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}\n"
}

# Function to print menu option
print_option() {
    local num=$1
    local emoji=$2
    local title=$3
    local desc=$4
    echo -e "${YELLOW}[$num]${NC} ${emoji}  ${WHITE}${title}${NC}"
    echo -e "    ${CYAN}${desc}${NC}"
}

# Function to show main menu
show_menu() {
    print_banner
    
    echo -e "${BOLD}${MAGENTA}Available Demos:${NC}\n"
    
    print_option "1" "🔲" "Logic Gates" \
        "Basic gates (AND, OR, NOT, XOR, MUX) - 1 gate each"
    echo ""
    
    print_option "2" "➕" "Arithmetic Circuits" \
        "Adders and multipliers - 5 to 150 gates"
    echo ""
    
    print_option "3" "🧮" "4-bit ALU" \
        "Complete arithmetic logic unit - 50+ gates"
    echo ""
    
    print_option "4" "🔐" "Cryptographic Circuits" \
        "AES, SHA-1, Simon ciphers - 500 to 1000+ gates"
    echo ""
    
    print_option "5" "📦" "UPFlexo Packer" \
        "UPX packer with weird machine decryption"
    echo ""
    
    echo -e "${YELLOW}[6]${NC} 📊  ${WHITE}Performance Comparison${NC}"
    echo -e "    ${CYAN}View benchmarks across all circuits${NC}"
    echo ""
    
    echo -e "${YELLOW}[7]${NC} 📚  ${WHITE}Documentation${NC}"
    echo -e "    ${CYAN}Open guides and architecture docs${NC}"
    echo ""
    
    echo -e "${YELLOW}[8]${NC} 🎯  ${WHITE}Run All Demos${NC}"
    echo -e "    ${CYAN}Execute all demos sequentially${NC}"
    echo ""
    
    echo -e "${YELLOW}[0]${NC} 🚪  ${WHITE}Exit${NC}"
    echo ""
    
    echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
}

# Function to run a demo
run_demo() {
    local demo_name=$1
    local demo_script=$2
    
    print_section "Running: ${demo_name}"
    
    if [ -f "$demo_script" ]; then
        echo -e "${CYAN}Starting demo...${NC}\n"
        bash "$demo_script"
        echo -e "\n${GREEN}Demo completed!${NC}"
    else
        echo -e "${RED}Error: Demo script not found: $demo_script${NC}"
        echo -e "${YELLOW}Please ensure all demo scripts are in place.${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show benchmarks
show_benchmarks() {
    print_section "Performance Benchmarks"
    
    echo -e "${WHITE}Circuit Performance Overview:${NC}\n"
    
    echo -e "${CYAN}┌──────────────────┬──────────┬──────────────┬────────────┐${NC}"
    echo -e "${CYAN}│ Circuit          │ Gates    │ Time         │ Accuracy   │${NC}"
    echo -e "${CYAN}├──────────────────┼──────────┼──────────────┼────────────┤${NC}"
    echo -e "${CYAN}│${NC} Logic Gates     ${CYAN}│${NC} 1        ${CYAN}│${NC} ~0.8 μs      ${CYAN}│${NC} 90-95%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} Half Adder      ${CYAN}│${NC} 5        ${CYAN}│${NC} ~5 μs        ${CYAN}│${NC} 88-92%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} Full Adder      ${CYAN}│${NC} 9        ${CYAN}│${NC} ~8 μs        ${CYAN}│${NC} 85-90%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} 8-bit Adder     ${CYAN}│${NC} ~72      ${CYAN}│${NC} ~60 μs       ${CYAN}│${NC} 80-85%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} 8-bit Multiplier${CYAN}│${NC} ~150     ${CYAN}│${NC} ~120 μs      ${CYAN}│${NC} 75-82%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} 4-bit ALU       ${CYAN}│${NC} 50+      ${CYAN}│${NC} ~140 μs      ${CYAN}│${NC} 75-85%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} AES-128         ${CYAN}│${NC} 1000+    ${CYAN}│${NC} ~3-5 ms      ${CYAN}│${NC} 70-78%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} SHA-1           ${CYAN}│${NC} 500+     ${CYAN}│${NC} ~1-3 ms      ${CYAN}│${NC} 68-75%    ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC} Simon           ${CYAN}│${NC} 800+     ${CYAN}│${NC} ~1-2 ms      ${CYAN}│${NC} 70-78%    ${CYAN}│${NC}"
    echo -e "${CYAN}└──────────────────┴──────────┴──────────────┴────────────┘${NC}"
    
    echo ""
    echo -e "${WHITE}Key Insights:${NC}"
    echo -e "  • ${GREEN}Accuracy decreases${NC} with circuit complexity"
    echo -e "  • ${GREEN}Time scales${NC} roughly with gate count"
    echo -e "  • ${GREEN}Error detection${NC} provides reliability safety net"
    echo -e "  • ${GREEN}Still practical${NC} for security-critical applications"
    
    echo ""
    echo -e "${CYAN}For detailed benchmarks, see: ${WHITE}docs/BENCHMARKS.md${NC}"
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to show documentation menu
show_docs() {
    print_section "Documentation"
    
    echo -e "${WHITE}Available Documentation:${NC}\n"
    
    echo -e "${YELLOW}[1]${NC} ${WHITE}DEMO.md${NC} - Visual overview and architecture diagrams"
    echo -e "${YELLOW}[2]${NC} ${WHITE}docs/QUICKSTART.md${NC} - 5-minute getting started guide"
    echo -e "${YELLOW}[3]${NC} ${WHITE}docs/EXAMPLES.md${NC} - Detailed circuit examples"
    echo -e "${YELLOW}[4]${NC} ${WHITE}docs/BENCHMARKS.md${NC} - Performance analysis"
    echo -e "${YELLOW}[5]${NC} ${WHITE}docs/ARCHITECTURE.md${NC} - Technical internals"
    echo -e "${YELLOW}[6]${NC} ${WHITE}README.md${NC} - Main documentation"
    echo -e "${YELLOW}[0]${NC} Back to main menu"
    
    echo ""
    read -p "Select documentation to view (or press Enter to go back): " doc_choice
    
    case $doc_choice in
        1)
            less DEMO.md 2>/dev/null || cat DEMO.md | more
            ;;
        2)
            less docs/QUICKSTART.md 2>/dev/null || cat docs/QUICKSTART.md | more
            ;;
        3)
            less docs/EXAMPLES.md 2>/dev/null || cat docs/EXAMPLES.md | more
            ;;
        4)
            less docs/BENCHMARKS.md 2>/dev/null || cat docs/BENCHMARKS.md | more
            ;;
        5)
            less docs/ARCHITECTURE.md 2>/dev/null || cat docs/ARCHITECTURE.md | more
            ;;
        6)
            less README.md 2>/dev/null || cat README.md | more
            ;;
        *)
            return
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function to run all demos
run_all_demos() {
    print_section "Running All Demos"
    
    echo -e "${WHITE}This will run all demos sequentially.${NC}"
    echo -e "${YELLOW}This may take 10-30 minutes depending on your hardware.${NC}"
    echo ""
    read -p "Continue? (y/N): " confirm
    
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        return
    fi
    
    echo ""
    echo -e "${GREEN}Starting comprehensive demo run...${NC}"
    
    # Run each demo
    demos=(
        "Logic Gates:demo/examples/demo-gates.sh"
        "Arithmetic Circuits:demo/examples/demo-arithmetic.sh"
        "4-bit ALU:demo/examples/demo-alu.sh"
        "Cryptographic Circuits:demo/examples/demo-crypto.sh"
        "UPFlexo Packer:demo/examples/demo-upflexo.sh"
    )
    
    for demo in "${demos[@]}"; do
        IFS=':' read -r name script <<< "$demo"
        echo ""
        echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}"
        echo -e "${WHITE}Running: $name${NC}"
        echo -e "${MAGENTA}═══════════════════════════════════════════════════════${NC}"
        echo ""
        
        if [ -f "$script" ]; then
            bash "$script"
        else
            echo -e "${YELLOW}Skipping $name (script not found)${NC}"
        fi
        
        echo ""
        echo -e "${GREEN}Completed: $name${NC}"
        sleep 2
    done
    
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                       ║${NC}"
    echo -e "${GREEN}║      All Demos Completed Successfully! 🎉            ║${NC}"
    echo -e "${GREEN}║                                                       ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
    
    echo ""
    read -p "Press Enter to return to menu..."
}

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "circuits" ]; then
    echo -e "${RED}Error: Please run this script from the Flexo root directory${NC}"
    exit 1
fi

# Main loop
while true; do
    show_menu
    read -p "$(echo -e ${GREEN}Select an option: ${NC})" choice
    
    case $choice in
        1)
            run_demo "Logic Gates Demo" "demo/examples/demo-gates.sh"
            ;;
        2)
            run_demo "Arithmetic Circuits Demo" "demo/examples/demo-arithmetic.sh"
            ;;
        3)
            run_demo "4-bit ALU Demo" "demo/examples/demo-alu.sh"
            ;;
        4)
            run_demo "Cryptographic Circuits Demo" "demo/examples/demo-crypto.sh"
            ;;
        5)
            run_demo "UPFlexo Packer Demo" "demo/examples/demo-upflexo.sh"
            ;;
        6)
            show_benchmarks
            ;;
        7)
            show_docs
            ;;
        8)
            run_all_demos
            ;;
        0)
            echo ""
            echo -e "${CYAN}Thank you for exploring Flexo!${NC}"
            echo -e "${WHITE}For more information:${NC}"
            echo -e "  • Docs: ${CYAN}docs/${NC}"
            echo -e "  • Paper: ${CYAN}USENIX Security 2024${NC}"
            echo -e "  • Contact: ${CYAN}pinglunw@andrew.cmu.edu${NC}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            sleep 2
            ;;
    esac
done
