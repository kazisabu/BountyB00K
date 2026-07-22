#!/bin/bash
#
# ctf_full_setup.sh
# Combined: CTF/VAPT tool install + Kali-parity wordlist layout.
# Target: WSL2 / Ubuntu (also works fine on Kali, branches accordingly).
# Safe to re-run (idempotent).
#
set -uo pipefail

LOG_FILE="$HOME/ctf_full_setup_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

info() { echo "[*] $*"; }
ok()   { echo "[+] $*"; }
warn() { echo "[!] $*"; }

is_wsl() { grep -qi microsoft /proc/version 2>/dev/null; }
is_kali() { grep -q -i "kali" /etc/os-release 2>/dev/null; }

SECLISTS_DIR="/usr/share/seclists"
ROCKYOU="/usr/share/wordlists/rockyou.txt"

echo "=========================================================="
echo " CTF / VAPT full environment + wordlist setup"
echo " Environment: $(is_wsl && echo 'WSL' || echo 'Native Linux') | $(is_kali && echo 'Kali' || echo 'Non-Kali')"
echo "=========================================================="

# ---------------------------------------------------------------------
info "Updating package lists..."
sudo apt update || warn "apt update failed (proxy/DNS?). Continuing with cached lists."

# ---------------------------------------------------------------------
info "Installing core tools + packages that ship their own default wordlists..."
# john/dirb/dirbuster/nmap/sqlmap ship default wordlists at their standard paths automatically.
CORE_PKGS=(
    curl wget git nano zip unzip p7zip-full
    python3 python3-pip python3-venv python3-dev
    build-essential libssl-dev libffi-dev
    golang-go nmap masscan hydra sqlmap gobuster
    tcpdump netcat-openbsd whois dnsutils openssh-client
    binutils file ltrace strace gdb socat libimage-exiftool-perl dos2unix
    john dirb dirbuster crunch cewl nikto whatweb
)
sudo apt install -y "${CORE_PKGS[@]}" || warn "Some core packages failed — check log above."

info "Installing ffuf/wfuzz (best-effort, unreliable on non-Kali apt repos)..."
if ! sudo apt install -y ffuf wfuzz 2>/dev/null; then
    warn "ffuf/wfuzz not available via apt here."
    command -v go  >/dev/null 2>&1 && { go install github.com/ffuf/ffuf/v2@latest || warn "go install ffuf failed."; }
    command -v pip3 >/dev/null 2>&1 && { pip3 install --user wfuzz || warn "pip install wfuzz failed."; }
fi

# ---------------------------------------------------------------------
info "Recreating Kali-style symlinks under /usr/share/wordlists/..."
sudo mkdir -p /usr/share/wordlists
if [ -d /usr/share/dirbuster/wordlists ] && [ ! -e /usr/share/wordlists/dirbuster ]; then
    sudo ln -s /usr/share/dirbuster/wordlists /usr/share/wordlists/dirbuster
    ok "Linked /usr/share/wordlists/dirbuster -> /usr/share/dirbuster/wordlists"
fi

# ---------------------------------------------------------------------
info "Setting up SecLists..."
if is_kali; then
    sudo apt install -y seclists kali-linux-wordlists || warn "Kali wordlist packages failed."
    [ -d /usr/share/seclists ] && SECLISTS_DIR="/usr/share/seclists"
elif [ ! -d "$SECLISTS_DIR" ]; then
    sudo git clone --depth 1 https://github.com/danielmiessler/SecLists.git "$SECLISTS_DIR" \
        || warn "SecLists clone failed (network?)."
else
    ok "SecLists already present at $SECLISTS_DIR"
fi

# ---------------------------------------------------------------------
info "Setting up rockyou.txt..."
if [ -f "$ROCKYOU" ]; then
    ok "rockyou.txt already present."
elif [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    sudo gunzip -k /usr/share/wordlists/rockyou.txt.gz
else
    SECLIST_ROCKYOU="$SECLISTS_DIR/Passwords/Leaked-Databases/rockyou.txt.tar.gz"
    if [ -f "$SECLIST_ROCKYOU" ]; then
        sudo tar -xzf "$SECLIST_ROCKYOU" -C /usr/share/wordlists/
        ok "rockyou.txt extracted from SecLists to $ROCKYOU"
    else
        warn "rockyou.txt not found via apt or SecLists — skipping."
    fi
fi
[ -f "$ROCKYOU" ] && [ ! -f "${ROCKYOU}.gz" ] && { gzip -k "$ROCKYOU" 2>/dev/null || sudo gzip -k "$ROCKYOU"; }

# ---------------------------------------------------------------------
info "Installing Metasploit Framework (official installer — large, be patient)..."
if command -v msfconsole >/dev/null 2>&1; then
    ok "Metasploit already installed — skipping."
else
    curl -fsSL https://raw.githubusercontent.com/rapid/metast-omnibus/master/config/templates/metasploit-framework-wrappers/date.erb \
        -o /tmp/msfinstall 2>/dev/null
    if [ -s /tmp/msfinstall ]; then
        chmod +x /tmp/msfinstall
        sudo /tmp/msfinstall || warn "Metasploit installer failed — install manually if needed."
    else
        warn "Could not fetch Metasploit installer (network/domain allowlist?). Skipping."
    fi
fi

# ---------------------------------------------------------------------
info "Fetching Legion's default-credential wordlists (tool itself skipped — GUI-only)..."
LEGION_DIR="/usr/share/legion"
if [ -d "$LEGION_DIR/wordlists" ]; then
    ok "Legion wordlists already present."
else
    TMP_LEGION=$(mktemp -d)
    if git clone --depth 1 https://github.com/GoVanguard/legion.git "$TMP_LEGION" 2>/dev/null && [ -d "$TMP_LEGION/wordlists" ]; then
        sudo mkdir -p "$LEGION_DIR"
        sudo cp -r "$TMP_LEGION/wordlists" "$LEGION_DIR/wordlists"
        ok "Legion wordlists installed to $LEGION_DIR/wordlists"
    else
        warn "Legion wordlists fetch failed (network/repo changed?). Skipping."
    fi
    rm -rf "$TMP_LEGION"
fi

# ---------------------------------------------------------------------
info "Creating workspace & Python virtual environment..."
mkdir -p ~/ctf/{notes,loot,scripts,recon,wordlists,binaries}
[ -d ~/ctf/venv ] || python3 -m venv ~/ctf/venv
# shellcheck disable=SC1091
source ~/ctf/venv/bin/activate
pip install --upgrade pip
pip install requests beautifulsoup4 scapy pwntools impacket || warn "One or more pip packages failed."
deactivate

# ---------------------------------------------------------------------
info "Installing Go-based tools..."
export PATH="$PATH:$HOME/go/bin"
if command -v go >/dev/null 2>&1; then
    GO_TOOLS=(
        "github.com/projectdiscovery/httpx/cmd/httpx@latest"
        "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
        "github.com/tomnomnom/httprobe@latest"
    )
    for tool in "${GO_TOOLS[@]}"; do
        go install "$tool" || warn "Failed to install $tool (Go version too old?)."
    done
else
    warn "Go not found on PATH — skipping Go tool installs."
fi

# ---------------------------------------------------------------------
info "Updating shell environment (~/.bashrc)..."
grep -qxF 'export PATH=$PATH:$HOME/go/bin' ~/.bashrc || echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
grep -qxF 'alias ctfenv="source ~/ctf/venv/bin/activate"' ~/.bashrc || echo 'alias ctfenv="source ~/ctf/venv/bin/activate"' >> ~/.bashrc

# ---------------------------------------------------------------------
if is_wsl; then
    echo
    warn "WSL-specific notes:"
    warn " - masscan needs raw sockets; WSL2's virtual NIC can make this unreliable."
    warn " - tcpdump requires sudo/CAP_NET_RAW under WSL2."
    warn " - For best raw-packet reliability: Windows 11 23H2+, add 'networkingMode=mirrored'"
    warn "   under [wsl2] in %USERPROFILE%\\.wslconfig, then 'wsl --shutdown' and restart."
fi

# ---------------------------------------------------------------------
info "Verifying key wordlist paths..."
CHECK_PATHS=(
    "$ROCKYOU"
    "/usr/share/john/password.lst"
    "/usr/share/nmap/nselib/data/passwords.lst"
    "/usr/share/sqlmap/data/txt/wordlist.txt"
    "/usr/share/dirb/wordlists/common.txt"
    "/usr/share/dirb/wordlists/big.txt"
    "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
    "/usr/share/legion/wordlists"
    "/usr/share/metasploit-framework/data/wordlists"
    "$SECLISTS_DIR/Discovery/Web-Content/common.txt"
    "$SECLISTS_DIR/Discovery/Web-Content/raft-large-directories.txt"
    "$SECLISTS_DIR/Discovery/DNS/subdomains-top1million-5000.txt"
    "$SECLISTS_DIR/Usernames/Names/names.txt"
    "$SECLISTS_DIR/Discovery/Web-Content/burp-parameter-names.txt"
)
echo
printf "%-70s %s\n" "PATH" "STATUS"
printf "%-70s %s\n" "----" "------"
for p in "${CHECK_PATHS[@]}"; do
    [ -e "$p" ] && printf "%-70s %s\n" "$p" "OK" || printf "%-70s %s\n" "$p" "MISSING"
done

echo
echo "=========================================================="
echo " Setup complete"
echo "=========================================================="
echo "Workspace   : ~/ctf"
echo "Go tools    : \$HOME/go/bin"
echo "Python venv : run 'ctfenv' to activate (pwntools/scapy/impacket)"
echo "Wordlists   : $SECLISTS_DIR  |  rockyou: $ROCKYOU"
echo "Log file    : $LOG_FILE"
echo
echo "Run: source ~/.bashrc"
