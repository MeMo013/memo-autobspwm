# 🖥️ memo-autobspwm

Entorno BSPWM personalizado para Kali Linux. Script de instalación automática que configura un entorno de escritorio completo orientado a pentesting y uso diario.

Basado en [GalileoQ/Kali_Linux-Auto-Bspwm](https://github.com/GalileoQ/Kali_Linux-Auto-Bspwm) con modificaciones y personalización propia.

---

## 📸 Componentes

| Componente | Herramienta |
|:--|:--|
| Window Manager | bspwm |
| Hotkey Daemon | sxhkd |
| Bar | Polybar (shapes) |
| Terminal | Kitty |
| Compositor | Picom |
| Launcher | Rofi |
| Shell | Zsh + Oh My Zsh + Powerlevel10k |
| Wallpaper | feh |
| Color Scheme | pywal |

---

## 🚀 Instalación

### Requisitos
- **Kali Linux** (instalación limpia recomendada)
- **Conexión a internet**
- **No ejecutar como root**

### Pasos

```bash
git clone https://github.com/TU_USUARIO/memo-autobspwm.git
cd memo-autobspwm
chmod +x setup.sh
./setup.sh
```

Una vez terminada la instalación:
1. Cierra tu sesión actual
2. En la pantalla de login, selecciona **bspwm** como gestor de ventanas
3. Inicia sesión y disfruta tu entorno

---

## ⌨️ Atajos de Teclado

### Generales
| Atajo | Acción |
|:--|:--|
| `Super + Enter` | Abrir terminal (Kitty) |
| `Super + D` | Abrir lanzador (Rofi) |
| `Super + Escape` | Recargar sxhkd |
| `Super + Alt + Q` | Cerrar bspwm |
| `Super + Alt + R` | Reiniciar bspwm |
| `Ctrl + Alt + L` | Bloquear pantalla |

### Ventanas
| Atajo | Acción |
|:--|:--|
| `Super + W` | Cerrar ventana |
| `Super + Shift + W` | Matar ventana |
| `Super + T` | Modo tiled |
| `Super + S` | Modo floating |
| `Super + F` | Modo fullscreen |
| `Super + M` | Alternar monocle |
| `Super + Flechas` | Mover foco |
| `Super + Shift + Flechas` | Intercambiar ventanas |
| `Super + Alt + Flechas` | Redimensionar ventanas |
| `Super + 1-9` | Cambiar workspace |
| `Super + Shift + 1-9` | Mover ventana a workspace |

### Aplicaciones
| Atajo | Acción |
|:--|:--|
| `Super + Shift + F` | Abrir Firefox |
| `Super + Shift + B` | Abrir BurpSuite |
| `Print` | Captura de pantalla completa |
| `Ctrl + Print` | Captura de pantalla (selección) |

### Volumen
| Atajo | Acción |
|:--|:--|
| `Ctrl + Shift + Up` | Subir volumen |
| `Ctrl + Shift + Down` | Bajar volumen |
| `Ctrl + Shift + M` | Mute/Unmute |

### Kitty (Terminal)
| Atajo | Acción |
|:--|:--|
| `Ctrl + Shift + Enter` | Nueva sub-ventana |
| `Ctrl + Shift + T` | Nueva pestaña |
| `Ctrl + Shift + Z` | Zoom ventana actual |
| `Ctrl + Shift + F5` | Recargar configuración |
| `Ctrl + Flechas` | Moverse entre paneles |

---

## 🛠️ Funciones ZSH incluidas

| Comando | Descripción |
|:--|:--|
| `mkt` | Crea directorios: nmap, content, exploits, scripts |
| `extractPorts <file>` | Extrae puertos abiertos de un escaneo nmap |
| `settarget <IP> [NAME]` | Establece un target en la polybar |
| `fzf-lovely` | Búsqueda fuzzy mejorada con preview |
| `rmk <file>` | Eliminación segura de archivos |

### Aliases
| Alias | Comando real |
|:--|:--|
| `ll` | `lsd -lh --group-dirs=first` |
| `la` | `lsd -a --group-dirs=first` |
| `ls` | `lsd --group-dirs=first` |
| `cat` | `batcat` (con syntax highlighting) |
| `catn` | `/usr/bin/cat` (cat normal) |

---

## 📁 Estructura del Repositorio

```
memo-autobspwm/
├── setup.sh           # Script de instalación
├── config/            # Archivos de ~/.config/
│   ├── bspwm/         # Window manager
│   ├── sxhkd/         # Atajos de teclado
│   ├── kitty/         # Terminal
│   ├── picom/         # Compositor (transparencia, blur, esquinas)
│   ├── polybar/       # Barra superior
│   └── wal/           # Esquemas de color
├── home/              # .zshrc, .p10k.zsh, .bashrc
├── fonts/             # Hack Nerd Font, Iosevka, etc.
├── kitty/             # Cache de colores para wal
└── wallpapers/        # 20 wallpapers
```

---

## 🎨 Personalización post-instalación

- **Cambiar wallpaper:** `feh --bg-fill ~/Wallpapers/nombre.jpg`
- **Cambiar fuente de Kitty:** Editar `~/.config/kitty/kitty.conf` → `font_family`
- **Cambiar transparencia:** Editar `~/.config/picom/picom.conf` → `opacity-rule`
- **Reconfigurar prompt:** Ejecutar `p10k configure`
- **Recargar Kitty:** `Ctrl + Shift + F5`
- **Recargar Picom:** `killall picom; picom --config ~/.config/picom/picom.conf &`

---

## 📝 Créditos

- Entorno base: [GalileoQ/Kali_Linux-Auto-Bspwm](https://github.com/GalileoQ/Kali_Linux-Auto-Bspwm)
- Polybar theme: [adi1090x/polybar-themes](https://github.com/adi1090x/polybar-themes)
- Powerlevel10k: [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
