#!/bin/bash
# memo-autobspwm - Setup Script
# Entorno BSPWM personalizado por memo
# Basado en GalileoQ/Kali_Linux-Auto-Bspwm

# ── Colores ──────────────────────────────────────────────
GREEN='\e[0;32m\033[1m'
RED='\e[0;31m\033[1m'
BLUE='\e[0;34m\033[1m'
YELLOW='\e[0;33m\033[1m'
PURPLE='\e[0;35m\033[1m'
CYAN='\e[0;36m\033[1m'
GRAY='\e[0;37m\033[1m'
NC='\033[0m\e[0m'

# ── Variables globales ───────────────────────────────────
dir=$(cd "$(dirname "$0")" && pwd)
fdir="$HOME/.local/share/fonts"
user=$(whoami)

# ── Ctrl+C handler ──────────────────────────────────────
trap 'echo -e "\n\n${RED}[!] Instalación cancelada por el usuario.\n${NC}"; exit 1' INT

# ── Banner ───────────────────────────────────────────────
function banner(){
    echo -e "\n${CYAN}"
    echo -e "  ┌─────────────────────────────────────────────────────┐"
    echo -e "  │                                                     │"
    echo -e "  │   ███╗   ███╗███████╗███╗   ███╗ ██████╗            │"
    echo -e "  │   ████╗ ████║██╔════╝████╗ ████║██╔═══██╗           │"
    echo -e "  │   ██╔████╔██║█████╗  ██╔████╔██║██║   ██║           │"
    echo -e "  │   ██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██║   ██║           │"
    echo -e "  │   ██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║╚██████╔╝           │"
    echo -e "  │   ╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝            │"
    echo -e "  │                                                     │"
    echo -e "  │          ${GRAY}auto-bspwm installer${CYAN}                     │"
    echo -e "  │          ${GRAY}By memo${CYAN}                                   │"
    echo -e "  │                                                     │"
    echo -e "  └─────────────────────────────────────────────────────┘"
    echo -e "${NC}"
}

# ══════════════════════════════════════════════════════════
# FASE 0: Validaciones
# ══════════════════════════════════════════════════════════

if [ "$user" == "root" ]; then
    banner
    echo -e "\n${RED}[!] No ejecutes este script como root.${NC}"
    echo -e "${YELLOW}[*] Ejecútalo como tu usuario normal. El script pedirá sudo cuando lo necesite.${NC}\n"
    exit 1
fi

banner

if ! grep -qi "kali" /etc/os-release 2>/dev/null; then
    echo -e "${YELLOW}[!] Este script está diseñado para Kali Linux.${NC}"
    read -p "¿Deseas continuar de todas formas? [y/N]: " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 1
fi

echo -e "${BLUE}[*] Iniciando instalación del entorno BSPWM...${NC}\n"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 1: Instalación de paquetes
# ══════════════════════════════════════════════════════════

echo -e "${BLUE}[*] Actualizando repositorios...${NC}"
sudo apt update

echo -e "\n${PURPLE}[*] Instalando paquetes necesarios...${NC}"
sleep 1
sudo apt install -y \
    bspwm sxhkd polybar kitty picom rofi feh \
    lsd bat zsh zsh-syntax-highlighting zsh-autosuggestions \
    fzf pamixer flameshot scrub xclip wmname i3lock-fancy \
    imagemagick ranger fastfetch python3-pip

if [ $? != 0 ] && [ $? != 130 ]; then
    echo -e "\n${RED}[-] Error al instalar algunos paquetes.${NC}"
    exit 1
else
    echo -e "\n${GREEN}[+] Paquetes instalados correctamente.${NC}"
    sleep 1
fi

# ══════════════════════════════════════════════════════════
# FASE 2: Oh My Zsh + Powerlevel10k (usuario + root)
# ══════════════════════════════════════════════════════════

# ── Usuario normal ───────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "\n${PURPLE}[*] Instalando Oh My Zsh para ${user}...${NC}"
    sleep 1
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${RED}[-] Error al instalar Oh My Zsh.${NC}"
        exit 1
    fi
else
    echo -e "\n${YELLOW}[*] Oh My Zsh ya está instalado para ${user}. Saltando...${NC}"
fi

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo -e "\n${PURPLE}[*] Instalando Powerlevel10k para ${user}...${NC}"
    sleep 1
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${RED}[-] Error al instalar Powerlevel10k.${NC}"
        exit 1
    fi
else
    echo -e "\n${YELLOW}[*] Powerlevel10k ya está instalado para ${user}. Saltando...${NC}"
fi

echo -e "\n${GREEN}[+] Oh My Zsh y Powerlevel10k configurados para ${user}.${NC}"
sleep 1

# ── Root ─────────────────────────────────────────────────
echo -e "\n${PURPLE}[*] Instalando Oh My Zsh y Powerlevel10k para root...${NC}"
sleep 1

if ! sudo test -d /root/.oh-my-zsh; then
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if ! sudo test -d /root/.oh-my-zsh/custom/themes/powerlevel10k; then
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        /root/.oh-my-zsh/custom/themes/powerlevel10k
fi

echo -e "\n${GREEN}[+] Oh My Zsh y Powerlevel10k configurados para root.${NC}"
sleep 1

# ── pywal ────────────────────────────────────────────────
if ! command -v wal &> /dev/null; then
    echo -e "\n${PURPLE}[*] Instalando pywal...${NC}"
    sleep 1
    sudo pip3 install pywal --break-system-packages
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${RED}[-] Error al instalar pywal.${NC}"
        exit 1
    fi
    echo -e "\n${GREEN}[+] pywal instalado.${NC}"
else
    echo -e "\n${YELLOW}[*] pywal ya está instalado. Saltando...${NC}"
fi
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 3: Fuentes
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Instalando fuentes...${NC}"
sleep 1

mkdir -p "$fdir"/{panels,terminus}
cp -v "$dir"/fonts/*.ttf "$fdir/" 2>/dev/null
cp -v "$dir"/fonts/*.bdf "$fdir/" 2>/dev/null
cp -v "$dir"/fonts/panels/* "$fdir/panels/" 2>/dev/null
cp -v "$dir"/fonts/terminus/* "$fdir/terminus/" 2>/dev/null
fc-cache -fv > /dev/null 2>&1

echo -e "${GREEN}[+] Fuentes instaladas.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 4: Wallpapers
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Instalando wallpapers...${NC}"
sleep 1

mkdir -p ~/Wallpapers
cp -v "$dir"/wallpapers/* ~/Wallpapers/

echo -e "${GREEN}[+] Wallpapers instalados.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 5: Archivos de configuración
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Creando backups de configuraciones existentes...${NC}"
sleep 1

timestamp=$(date +%Y%m%d_%H%M%S)
for dir_name in bspwm sxhkd kitty picom polybar; do
    if [ -d "$HOME/.config/$dir_name" ]; then
        cp -r "$HOME/.config/$dir_name" "$HOME/.config/${dir_name}.bak.${timestamp}" 2>/dev/null
        echo -e "  ${GRAY}Backup: ~/.config/${dir_name}.bak.${timestamp}${NC}"
    fi
done
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak.${timestamp} 2>/dev/null
[ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh ~/.p10k.zsh.bak.${timestamp} 2>/dev/null

echo -e "\n${PURPLE}[*] Instalando configuraciones...${NC}"
sleep 1

# Crear directorios necesarios
mkdir -p ~/.config/{bspwm/scripts,sxhkd,kitty,picom,polybar/shapes/scripts/rofi,wal/colorschemes/{dark,light}}

# Copiar todas las configs
cp -rv "$dir"/config/bspwm/* ~/.config/bspwm/
cp -rv "$dir"/config/sxhkd/* ~/.config/sxhkd/
cp -rv "$dir"/config/kitty/* ~/.config/kitty/
cp -rv "$dir"/config/picom/* ~/.config/picom/
cp -rv "$dir"/config/polybar/* ~/.config/polybar/
cp -rv "$dir"/config/wal/* ~/.config/wal/ 2>/dev/null

echo -e "${GREEN}[+] Configuraciones instaladas.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 6: Archivos del home (.zshrc, .p10k.zsh, .bashrc)
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Configurando .zshrc, .p10k.zsh y .bashrc...${NC}"
sleep 1

cp -v "$dir"/home/.zshrc ~/
cp -v "$dir"/home/.p10k.zsh ~/
cp -v "$dir"/home/.bashrc ~/

echo -e "${GREEN}[+] Archivos del home configurados.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 7: Cache de wal para Kitty
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Configurando colores de Kitty (wal cache)...${NC}"
sleep 1

mkdir -p ~/.cache/wal
cp -v "$dir"/kitty/colors-kitty.conf ~/.cache/wal/colors-kitty.conf

echo -e "${GREEN}[+] Colores de Kitty configurados.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 8: Configuración para root (symlinks)
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Configurando entorno para root (symlinks)...${NC}"
sleep 1

# Symlinks de .zshrc y .p10k.zsh
sudo ln -sfv "$HOME/.zshrc" /root/.zshrc
sudo ln -sfv "$HOME/.p10k.zsh" /root/.p10k.zsh

# Polybar target para root
sudo mkdir -p /root/.config/polybar/shapes/scripts/
sudo touch /root/.config/polybar/shapes/scripts/target
sudo ln -sfv "$HOME/.config/polybar/shapes/scripts/target" \
    /root/.config/polybar/shapes/scripts/target

echo -e "${GREEN}[+] Entorno de root configurado.${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 9: Wallpaper por defecto y rutas dinámicas
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Configurando wallpaper por defecto (gojo-geto.jpeg)...${NC}"
sleep 1

# Reemplazar rutas hardcodeadas en bspwmrc
sed -i "s|/home/memo|$HOME|g" ~/.config/bspwm/bspwmrc

# Establecer wallpaper por defecto
cat > ~/.fehbg << EOF
#!/bin/sh
feh --no-fehbg --bg-fill '$HOME/Wallpapers/gojo-geto.jpeg'
EOF
chmod +x ~/.fehbg

echo -e "${GREEN}[+] Wallpaper configurado: gojo-geto.jpeg${NC}"
sleep 1

# ══════════════════════════════════════════════════════════
# FASE 10: Permisos y shell
# ══════════════════════════════════════════════════════════

echo -e "\n${PURPLE}[*] Configurando permisos...${NC}"
sleep 1

# Permisos ejecutables
chmod -R +x ~/.config/bspwm/
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/shapes/launch.sh
chmod +x ~/.config/polybar/shapes/scripts/* 2>/dev/null
chmod +x ~/.config/polybar/shapes/preview.sh 2>/dev/null

# Polybar target
touch ~/.config/polybar/shapes/scripts/target

echo -e "${GREEN}[+] Permisos configurados.${NC}"
sleep 1

# Cambiar shell por defecto a zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "\n${PURPLE}[*] Cambiando shell por defecto a zsh...${NC}"
    chsh -s $(which zsh)
    echo -e "${GREEN}[+] Shell cambiada a zsh.${NC}"
fi

# ══════════════════════════════════════════════════════════
# COMPLETADO
# ══════════════════════════════════════════════════════════

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}║   ✅  ¡Instalación completada exitosamente!               ║${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}║   Pasos siguientes:                                       ║${NC}"
echo -e "${GREEN}║   1. Cierra tu sesión actual                              ║${NC}"
echo -e "${GREEN}║   2. En la pantalla de login, selecciona 'bspwm'          ║${NC}"
echo -e "${GREEN}║      como gestor de ventanas                              ║${NC}"
echo -e "${GREEN}║   3. Inicia sesión y disfruta tu entorno                  ║${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}║   Wallpaper: gojo-geto.jpeg                               ║${NC}"
echo -e "${GREEN}║   Terminal:  kitty (Super + Enter)                        ║${NC}"
echo -e "${GREEN}║   Launcher:  rofi  (Super + D)                           ║${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
