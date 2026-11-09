-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃                 CachyOS Hyprland Configuration              ┃
-- ┃          Migrated from hyprlang → Lua (Hyprland 0.57+)      ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CATPPUCCIN MOCHA COLORS
-- (ported from themes/mocha.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local color = {
    rosewater  = "rgb(f5e0dc)",
    flamingo   = "rgb(f2cdcd)",
    pink       = "rgb(f5c2e7)",
    mauve      = "rgb(cba6f7)",
    red        = "rgb(f38ba8)",
    maroon     = "rgb(eba0ac)",
    peach      = "rgb(fab387)",
    yellow     = "rgb(f9e2af)",
    green      = "rgb(a6e3a1)",
    teal       = "rgb(94e2d5)",
    sky        = "rgb(89dceb)",
    sapphire   = "rgb(74c7ec)",
    blue       = "rgb(89b4fa)",
    lavender   = "rgb(b4befe)",
    text       = "rgb(cdd6f4)",
    subtext1   = "rgb(bac2de)",
    subtext0   = "rgb(a6adc8)",
    overlay2   = "rgb(9399b2)",
    overlay1   = "rgb(7f849c)",
    overlay0   = "rgb(6c7086)",
    surface2   = "rgb(585b70)",
    surface1   = "rgb(45475a)",
    surface0   = "rgb(313244)",
    base       = "rgb(1e1e2e)",
    mantle     = "rgb(181825)",
    crust      = "rgb(11111b)",
}

-- Color aliases (ported from config/colors.conf)
local cachylgreen = color.teal
local cachymgreen = color.green
local cachydgreen = color.sapphire
local cachylblue  = color.sky
local cachymblue  = color.surface0
local cachydblue  = color.base
local cachywhite  = color.text
local cachygrey   = color.overlay2
local cachygray   = color.overlay1


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PROGRAMS  (ported from config/defaults.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local terminal    = "alacritty"
local filemanager = "yazi"
local applauncher = "rofi -show combi -modi window,run,combi -combi-modi window,run"
local idlehandler = "swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'"
local capturing   = "grim -g \"$(slurp)\" - | swappy -f -"


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- MONITOR  (ported from config/monitor.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Monitor wiki: https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@99.90",
    position = "auto",
    scale    = 1,
    vrr      = 0,
})

-- If you need to scale things like Steam etc, uncomment:
-- hl.config({ xwayland = { force_zero_scaling = true } })
-- hl.env("GDK_SCALE", "1.25")


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ENVIRONMENT VARIABLES  (ported from config/environment.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/environment-variables/
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE",    "24")
hl.env("QT_CURSOR_SIZE",  "24")


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- AUTOSTART  (ported from config/autostart.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/autostart/
-- Note: hl.exec_cmd() is async — no & or disown needed
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("mako")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("bash -c 'mkfifo /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob && tail -f /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob | wob'")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    -- Slow app launch fix / DBus env propagation
    hl.exec_cmd("systemctl --user import-environment")
    hl.exec_cmd("bash -c 'hash dbus-update-activation-environment 2>/dev/null'")
    hl.exec_cmd("dbus-update-activation-environment --systemd")
    -- Idle configuration
    hl.exec_cmd(idlehandler)
end)


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LOOK AND FEEL
-- (ported from config/variables.conf + config/decorations.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/config-options/
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 5,

        border_size = 3,

        col = {
            active_border   = cachylgreen,
            inactive_border = cachymblue,
        },

        resize_on_border = true,
        layout           = "dwindle",

        snap = {
            enabled = true,
        },
    },

    decoration = {
        rounding       = 4,
        active_opacity = 1,

        blur = {
            enabled = true,
            size    = 15,
            passes  = 2,
            xray    = true,
        },

        shadow = {
            enabled = false,
        },
    },

    -- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/
    dwindle = {
        special_scale_factor = 0.8,
        preserve_split       = true,
    },

    -- See https://wiki.hypr.land/configuring/layouts/master-layout/
    master = {
        new_status           = "master",
        special_scale_factor = 0.8,
    },

    -- https://wiki.hypr.land/configuring/core/config-options/#misc
    misc = {
        font_family            = "Fira Sans",
        splash_font_family     = "Fira Sans",
        disable_hyprland_logo  = true,
        col                    = { splash = cachylgreen },
        background_color       = cachydblue,
        enable_swallow         = true,
        swallow_regex          = "^(cachy-browser|firefox|nautilus|nemo|thunar|btrfs-assistant.)$",
        focus_on_activate      = true,
        vrr                    = 2,
    },

    render = {
        direct_scanout = true,
    },

    animations = {
        enabled = true,
    },
})

-- Group borders  (ported from config/variables.conf group {})
hl.config({
    group = {
        col = {
            border_active          = cachydgreen,
            border_inactive        = cachylgreen,
            border_locked_active   = cachymgreen,
            border_locked_inactive = cachydblue,
        },

        groupbar = {
            font_family = "Fira Sans",
            text_color  = cachydblue,
            col = {
                active          = cachydgreen,
                inactive        = cachylgreen,
                locked_active   = cachymgreen,
                locked_inactive = cachydblue,
            },
        },
    },
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- ANIMATIONS  (ported from config/animations.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/animations/
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.1} } })

hl.animation({ leaf = "windowsIn",    enabled = true, speed = 4,  bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 5,  bezier = "default",  style = "popin 80%" })
hl.animation({ leaf = "border",       enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 6,  bezier = "overshot", style = "slide" })
hl.animation({ leaf = "workspacesOut",enabled = true, speed = 6,  bezier = "overshot", style = "slidefade 80%" })


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- INPUT  (ported from config/input.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/config-options/#input
hl.config({
    input = {
        follow_mouse              = 2,  -- 0|1|2|3
        float_switch_override_focus = 2,
        kb_layout                 = "pl",
        kb_options                = "lv3:ralt_switch",
    },
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- KEYBINDINGS  (ported from config/keybinds.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/binds/
local mainMod = "SUPER"

-- ── Core window/app binds ──────────────────────
hl.bind(mainMod .. " + RETURN",     hl.dsp.exec_cmd(terminal),   {}, "Opens your preferred terminal emulator")
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(filemanager),{}, "Opens your preferred file manager")
hl.bind(mainMod .. " + A",          hl.dsp.exec_cmd(capturing),  {}, "Screen capture selection")
hl.bind(mainMod .. " + Q",          hl.dsp.window.close(),       {}, "Closes (not kill) current window")
hl.bind(mainMod .. " + SHIFT + M",  hl.dsp.exec_cmd('loginctl terminate-user ""'), {}, "Exits Hyprland by terminating the user session")
hl.bind(mainMod .. " + V",          hl.dsp.window.float({ action = "toggle" }), {}, "Switch between floating and tiling")
hl.bind(mainMod .. " + SPACE",      hl.dsp.exec_cmd(applauncher), {}, "Runs your application launcher")
hl.bind(mainMod .. " + F",          hl.dsp.window.fullscreen(),   {}, "Toggles current window fullscreen mode")
hl.bind(mainMod .. " + Y",          hl.dsp.window.pin(),          {}, "Pin current window (shows on all workspaces)")
hl.bind(mainMod .. " + J",          hl.dsp.layout("togglesplit"), {}, "Toggles current window split mode (dwindle)")

-- ── Grouping ──────────────────────────────────
hl.bind(mainMod .. " + K",          hl.dsp.group.toggle(), {}, "Toggle window group mode")
hl.bind(mainMod .. " + Tab",        hl.dsp.group.next(),   {}, "Switch to next window in group")

-- ── Toggle Gaps ───────────────────────────────
hl.bind(mainMod .. " + SHIFT + G",  hl.dsp.exec_cmd('hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"'), {}, "Set CachyOS default gaps")
hl.bind(mainMod .. " + G",          hl.dsp.exec_cmd('hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"'),  {}, "Remove gaps")

-- ── Volume Control ────────────────────────────
-- Note: migrated to wpctl (pactl+wob pipeline kept as exec_cmd for compatibility)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(
    "pactl set-sink-volume @DEFAULT_SINK@ +5% && " ..
    "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{if($1>100) system(\"pactl set-sink-volume @DEFAULT_SINK@ 100%\")}' && " ..
    "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{print $1}' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob"
), { locked = true, repeating = true }, "Raise Volume")
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    "pactl set-sink-volume @DEFAULT_SINK@ -5% && " ..
    "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | awk '{print $1}' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob"
), { locked = true, repeating = true }, "Lower Volume")
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(
    "amixer sset Master toggle | sed -En '/\\[on\\]/ s/.*\\[([0-9]+)%\\].*/\\1/ p; /\\[off\\]/ s/.*/0/p' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob"
), { locked = true }, "Mute player audio")

-- ── Playback Control ──────────────────────────
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true }, "Toggle play/pause")
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),        { locked = true }, "Next track")
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),    { locked = true }, "Previous track")

-- ── Screen Brightness ─────────────────────────
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s +5%"), { locked = true, repeating = true }, "Increase brightness 5%")
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true }, "Decrease brightness 5%")

-- ── Additional binds ─────────────────────────
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("gnome-calculator"),             {}, "Runs the calculator")
hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd("swaylock-fancy -e -K -p 10 -f Hack-Regular"), {}, "Lock the screen")
hl.bind(mainMod .. " + O",         hl.dsp.exec_cmd("killall -SIGUSR2 waybar"),       {}, "Reload/restart Waybar")

-- ── Window movement ───────────────────────────
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }), {}, "Move active window left")
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), {}, "Move active window right")
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }), {}, "Move active window up")
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }), {}, "Move active window down")

-- ── Focus movement ────────────────────────────
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left"  }), {}, "Move focus left")
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), {}, "Move focus right")
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up"    }), {}, "Move focus up")
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down"  }), {}, "Move focus down")

-- ── Resize submap ─────────────────────────────
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"), {}, "Activate window resizing mode")
hl.define_submap("resize", function()
    hl.bind("right",   hl.dsp.window.resize({ x =  15, y =   0, relative = true }), {}, "Resize right")
    hl.bind("left",    hl.dsp.window.resize({ x = -15, y =   0, relative = true }), {}, "Resize left")
    hl.bind("up",      hl.dsp.window.resize({ x =   0, y = -15, relative = true }), {}, "Resize up")
    hl.bind("down",    hl.dsp.window.resize({ x =   0, y =  15, relative = true }), {}, "Resize down")
    hl.bind("l",       hl.dsp.window.resize({ x =  15, y =   0, relative = true }), {}, "Resize right (vim)")
    hl.bind("h",       hl.dsp.window.resize({ x = -15, y =   0, relative = true }), {}, "Resize left (vim)")
    hl.bind("k",       hl.dsp.window.resize({ x =   0, y = -15, relative = true }), {}, "Resize up (vim)")
    hl.bind("j",       hl.dsp.window.resize({ x =   0, y =  15, relative = true }), {}, "Resize down (vim)")
    hl.bind("escape",  hl.dsp.submap("reset"), {}, "End resize mode")
end)

-- ── Quick resize (mainMod + CTRL + SHIFT + arrows) ───────────
hl.bind(mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.resize({ x =  15, y =   0, relative = true }), {}, "Resize right")
hl.bind(mainMod .. " + CTRL + SHIFT + left",  hl.dsp.window.resize({ x = -15, y =   0, relative = true }), {}, "Resize left")
hl.bind(mainMod .. " + CTRL + SHIFT + up",    hl.dsp.window.resize({ x =   0, y = -15, relative = true }), {}, "Resize up")
hl.bind(mainMod .. " + CTRL + SHIFT + down",  hl.dsp.window.resize({ x =   0, y =  15, relative = true }), {}, "Resize down")
hl.bind(mainMod .. " + CTRL + SHIFT + l",     hl.dsp.window.resize({ x =  15, y =   0, relative = true }), {}, "Resize right (vim)")
hl.bind(mainMod .. " + CTRL + SHIFT + h",     hl.dsp.window.resize({ x = -15, y =   0, relative = true }), {}, "Resize left (vim)")
hl.bind(mainMod .. " + CTRL + SHIFT + k",     hl.dsp.window.resize({ x =   0, y = -15, relative = true }), {}, "Resize up (vim)")
hl.bind(mainMod .. " + CTRL + SHIFT + j",     hl.dsp.window.resize({ x =   0, y =  15, relative = true }), {}, "Resize down (vim)")

-- ── Mouse binds ───────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }, "Drag window")
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }, "Resize window")

-- ── Workspace switching (1-10) ────────────────
for i = 1, 10 do
    local key = i % 10  -- key 0 → workspace 10
    hl.bind(mainMod .. " + " .. key,            hl.dsp.focus({ workspace = i }), {}, "Switch to workspace " .. i)
    hl.bind(mainMod .. " + CTRL + " .. key,     hl.dsp.window.move({ workspace = i }), {}, "Move window and switch to workspace " .. i)
    hl.bind(mainMod .. " + SHIFT + " .. key,    hl.dsp.window.move({ workspace = i, silent = true }), {}, "Move window silently to workspace " .. i)
end

-- ── Workspace navigation ──────────────────────
hl.bind(mainMod .. " + PERIOD",      hl.dsp.focus({ workspace = "e+1" }), {}, "Next workspace")
hl.bind(mainMod .. " + COMMA",       hl.dsp.focus({ workspace = "e-1" }), {}, "Previous workspace")
hl.bind(mainMod .. " + CTRL + right",hl.dsp.window.move({ workspace = "+1" }), {}, "Move window to next workspace")
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ workspace = "-1" }), {}, "Move window to previous workspace")
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }), {}, "Scroll next workspace")
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }), {}, "Scroll previous workspace")
hl.bind(mainMod .. " + slash",       hl.dsp.focus({ workspace = "previous" }), {}, "Switch to previous workspace")

-- ── Special / scratchpad workspaces ──────────
hl.bind(mainMod .. " + minus",           hl.dsp.window.move({ workspace = "special" }), {}, "Move to special workspace")
hl.bind(mainMod .. " + equal",           hl.dsp.workspace.toggle_special("special"), {}, "Toggle special workspace")
hl.bind(mainMod .. " + F1",              hl.dsp.workspace.toggle_special("scratchpad"), {}, "Toggle scratchpad")
hl.bind(mainMod .. " + ALT + SHIFT + F1",hl.dsp.window.move({ workspace = "special:scratchpad", silent = true }), {}, "Move to scratchpad")

-- ── Binds settings ───────────────────────────
hl.config({
    binds = {
        allow_workspace_cycles       = true,
        workspace_back_and_forth     = true,
        workspace_center_on          = 1,
        movefocus_cycles_fullscreen  = true,
        window_direction_monitor_fallback = true,
    },
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WINDOW RULES  (ported from config/windowrules.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/rules/

-- ── Float rules ───────────────────────────────
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" },             float = true })
hl.window_rule({ match = { class = "^$", title = "^(Picture in picture)$" },       float = true })
hl.window_rule({ match = { class = "^$", title = "^(Save File)$" },                float = true })
hl.window_rule({ match = { class = "^$", title = "^(Open File)$" },                float = true })
hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" },                        float = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$" }, float = true })
hl.window_rule({ match = { class = "^(CachyOSHello)$" },                           float = true })
hl.window_rule({ match = { class = "^(zenity)$" },                                 float = true })
hl.window_rule({ match = { class = "^$", title = "^(Steam - Self Updater)$" },     float = true })

-- ── Opacity rules ─────────────────────────────
hl.window_rule({ match = { class = "^(thunar|nemo)$" },                             opacity = "0.92" })
hl.window_rule({ match = { class = "^(discord|armcord|webcord)$" },                 opacity = "0.96" })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" },                             opacity = "0.95" })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" },                opacity = "0.95" })

-- ── Picture-in-Picture ────────────────────────
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" },
    float = true, size = "960 540", move = "((monitor_w*0.25)) -" })
hl.window_rule({ match = { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
    float = true, move = "((monitor_w*0.25)) -", size = "960 540" })
hl.window_rule({ match = { title = "^(danmufloat)$" },  pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })

-- ── Animation / blur overrides ────────────────
hl.window_rule({ match = { class = "^(kitty|Alacritty)$" },      animation = "slide right" })
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" },   no_blur = true })

-- ── Float decoration (workspaces 1-10) ───────
hl.window_rule({ match = { float = true,  workspace = "w[fv1-10]" },
    border_size = 2, border_color = cachylblue, rounding = 8 })
hl.window_rule({ match = { float = false, workspace = "f[1-10]" },
    border_size = 3, rounding = 4 })

-- ── XWayland drag fix (from autogenerated template) ──
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- ── Suppress maximize events ──────────────────
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- WORKSPACE RULES  (ported from config/windowrules.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- See https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- Smart gaps
hl.workspace_rule({ workspace = "w[tv1-10]", gaps_out = 5, gaps_in = 3 })
hl.workspace_rule({ workspace = "f[1]",      gaps_out = 5, gaps_in = 3 })

-- Uncomment to pin specific workspaces to monitors:
-- hl.workspace_rule({ workspace = "1", default = true, monitor = "DP-1" })


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- LAYER RULES  (ported from config/windowrules.conf)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "slide top" })
hl.layer_rule({ match = { namespace = "waybar" },        animation = "slide down" })
hl.layer_rule({ match = { namespace = "wallpaper" },     animation = "fade 50%" })
