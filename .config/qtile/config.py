# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# -*- coding: utf-8 -*-

import os
import subprocess

from libqtile import hook

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.command import lazy
from libqtile.utils import guess_terminal

dispositivo_red = "wlp0s20f3"
mod = "mod4"
terminal = guess_terminal()

blanco = "#ffffff"
negro = "#000000"

color_0 = "#050909"  #Color de la barra
color_0_5 = "#143a3a"  #Color de la barra
color_1 = "#024343"
color_2 = "#006262"
color_3 = "#007575"
color_4 = "#189090"
color_5 = "#20A3A3"
color_6 = "#30D0D0"
color_7 = "#45E5E5" 
color_8 = "#60FFFF"
color_9 = "#bFFFFF"


fuente_barra = "/home/cesar/.local/share/fonts/HackNerdFont-Bold.ttf"
tamano_fuente = 16

# Bloqueo de pantalla
comando_bloqueo_pantalla = "i3lock"

# Configuracion barra
color_barra = color_0
tamano_barra = 26

tamano_iconos = 23
color_activo = color_5 # Color de icono cuando esta activa la ventana
color_inactivo = color_1
color_fg = "#ffffff" # Color de icono cuando no esta activa la ventana
color_bg = color_barra # Color de fondo de icono cuando no esta activa la ventana
color_oscuro = "#44475a"
color_borde_actual = color_8
color_urgent = "#ff2222" # Color de icono cuando hay una alerta

color_texto1 = color_8

color_g2 = color_6
color_g1 = color_6
color_g3 = color_4
color_g4 = color_2
color_g5 = color_1

def separador(tamanno, fondo):
    return widget.Sep(
        linewidth=0,
        padding=tamanno,
        foreground=color_fg,
        background=fondo,
    )

def arrow_left(color_bg, color_fg):
    return widget.TextBox(
        text='◀',
        background=color_bg,
        foreground=color_fg,
        padding=-1,
        fontsize=53.5,
    )

def triangulo(color_bg, color_fg):
    return widget.TextBox(
        text='',
        background=color_bg,
        foreground=color_fg,
        fontsize=35,
        padding=-0.9,
    )

def icono(icono, color_bg, color_fg):
    return widget.TextBox(
        text=icono,
        background=color_bg,
        foreground=color_fg,
        fontsize=tamano_iconos,
    )


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),

   # Firefox
   Key([mod], "b", lazy.spawn("google-chrome-stable"), desc="Abrir chrome"),

    # Teclas para lanzar menu rofi
    Key([mod], "m", lazy.spawn("rofi -show drun"), desc="Abrir menu"),

    # Ir a ventana menu rofi
    Key([mod, "shift"], "m", lazy.spawn("rofi -show")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Teclas de control de sistema
    # Volumen
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 10")),
    
    # Musica
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),

    Key([], "XF86Display", lazy.spawn("arandr")),
    #Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture toggle")),

    Key([mod], "s", lazy.spawn("scrot")),
    Key([mod, "shift"], "s", lazy.spawn("scrot -s")),

    #Key([], "XF86ScreenSaver", lazy.shutdown(), desc="Shutdown Qtile"),

    #Key([mod], "l", lazy.spawn(comando_bloqueo_pantalla)),

]

groups = [Group(i) for i in [
#   1 -- nf-linux-archcraft
#   2 -- nf-fa-chrome
#   3 -- nf-md-microsoft_visual_studio_code
#   4 -- nf-dev-terminal
#   5 -- nf-cod-project
#   6 -- nf-md-file
#   7 -- nf-fa-spotify
#   8 -- nf-dev-terminal_badge


    " ", " ", "󰨞 ",  " ", " ", "󰈔", " ","󰓩 "
]]

for i, group in enumerate(groups):
    numero_escritorio = str(i + 1)
    keys.extend([
            # mod1 + letter of group = switch to group
            Key([mod], numero_escritorio, lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),),
        
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], numero_escritorio, lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(group.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ])

layouts = [
    #layout.MonadTall(border_focus=[color_7], border_width=0.5),
    layout.Columns(border_focus_stack=[], border_width=1),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    #layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    #layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font=fuente_barra,
    fontsize=tamano_fuente,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=color_activo,
                    borderwidth=0,
                    disable_drag=True,
                    font_size=tamano_iconos,
                    foreground=color_fg,
                    highlight_method="block",
                    inactive=color_inactivo,
                    margin_x=6,
                    margin_y=3.5,
                    #other_current_screen_border=color_oscuro,
                    #other_screen_border=color_oscuro,
                    padding_x=10,
                    padding_y=5,
                    this_current_screen_border=color_borde_actual,
                    rounded=True,
                    urgent_alert_method="block",
                    urgent_border=color_urgent,
                    center_aligned=True,
                ),

                # Prompt y nombre de ventana
                separador(8, color_barra),
                widget.Prompt(
                    foreground=color_7,
                ),
                separador(4, color_barra),
                widget.WindowName(
                    font="Hack Nerd Font Bold",
                    foreground=color_borde_actual,
                    background=color_barra,
                    padding=23,
                    font_size=tamano_iconos,

                ),

                #Iconos opciones
                triangulo(color_barra, color_g1),
                widget.Systray(
                    padding=10, 
                    background=color_g1, 
                    foreground=blanco,
                    icon_size=20,
                ),

                
                # ----Barra de estado red----
                # separador(7, color_g1),
                # triangulo(color_g1, color_g2),
                # separador(4, color_g2),
                # icono("󰓅 ", color_g2, blanco), #nf-md-speedometer
                # widget.Net(
                #     #interface = dispositivo_red,
                #     font="Hack Nerd Font Bold",
                #     format = '{down:4.1f}{up_suffix:<0}   {up:4.1f}{up_suffix:<0}',
                #     foreground = color_fg,
                #     background = color_g2,
                #     use_bits = True,
                #     update_interval = 5
                # ),

                # Barra de estado de sistema
                triangulo(color_g2, color_g3),
                separador(5, color_g3),
                icono("󰕾 ", color_g3, blanco), #nf-fa-power-off
                widget.Volume(
                    font="Hack Nerd Font Bold",
                    background=color_g3,
                    foreground=color_fg,
                ),
                separador(8, color_g3),
                icono("󰃟 ", color_g3, blanco), #nf-md-brightness_6
                widget.Backlight(
                    font="Hack Nerd Font Bold",
                    background=color_g3,
                    backlight_name="intel_backlight",
                    brightness_file="brightness",
                    max_brightness_file="max_brightness",
                    step=10,
                ),
                separador(3, color_g3),
                widget.TextBox(text = "󰂁",background=color_g3, foreground=blanco,fontsize=tamano_iconos, padding=6), #nf-md-battery-80
                widget.Battery(
                    font="Hack Nerd Font Bold",
                    foreground = color_fg,
                    background = color_g3,
                    format = '{percent:2.0%}',
                    charge_char = '󰁧',
                    discharge_char = '󰁦',
                    empty_char = '󰁨',
                    full_char = '󰁥',
                    show_short_text = False,
                    notify_below = 20,
                    update_interval = 15,
                ),
                separador(5, color_g3),
                widget.TextBox( text="󰍛", background=color_g3, foreground=blanco,fontsize=tamano_iconos, padding=6),
                widget.Memory(
                    font="Ubuntu Mono Bold Nerd Font Bold",
                    format = '{MemUsed: 1.1f}{mm} -{MemTotal: 1.1f}{mm}',
                    measure_mem = 'G',
                    foreground = color_fg,
                    background = color_g3,
                ),
    
                

                # Reloj
                triangulo(color_g3, color_g4),
                separador(4, color_g4),
                icono("󰥔 ", color_g4, blanco),
                widget.Clock(
                    font="Hack Nerd Font Bold",
                    background = color_g4,
                    foreground = blanco,
                    format="%H:%M %a %d-%m"
                ),

                triangulo(color_g4, color_g5),
                separador(4, color_g5),
                widget.CurrentLayout(
                    font="Hack Nerd Font Bold",
                    background = color_g5,
                    foreground = blanco,
                ),
                separador(4, color_g5),
            ],
            tamano_barra,
            background=color_barra,
            opacity=0.92,
            border_width=[1, 0, 1, 0],  # Draw top and bottom borders
            border_color=[color_0_5, color_0_5, color_0_5, color_0_5]  # Borders are magenta
        ),

        # Screen(top=bar.Bar([
        #     widget.GroupBox(),    # display the current Group
        # ], 30))


        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts<
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("/home/cesar/.config/qtile/autostart.sh")
    #subprocess.Popen(["xautolock", "-time", "10", "-locker", "i3lock"])
    subprocess.run([script])
