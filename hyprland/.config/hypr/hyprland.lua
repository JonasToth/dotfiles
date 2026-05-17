-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal       = "alacritty"
local fileManager    = "dolphin"
local menu           = "fuzzel"
local sessionManager = "~/.config/waybar/scripts/power.sh"
local home           = os.getenv("HOME")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_PICTURES_DIR", home .. "/Pictures")
hl.env("HYPRSHOT_DIR", home .. "/Screenshots")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")

hl.env("XCURSOR_SIZE", "14")
hl.env("HYPRCURSOR_SIZE", "14")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function () 
  -- Setting up system services and privileged processes
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start ssh-agent")

  -- Graphical Programs
  hl.exec_cmd("hyprpaper&") -- background image
  hl.exec_cmd("hypridle")  -- automatic screen lock
  hl.exec_cmd("waybar&")    -- toolbar
  hl.exec_cmd("fnott&")     -- notification daemon

  -- Audio Setup
  hl.exec_cmd("pipewire")
  hl.exec_cmd("wireplumber")
  hl.exec_cmd("pipewire-pulse")

  -- Automatically start my desired programs on proper workspaces.
  -- exec-once=[workspace 1 silent] $terminal
  -- exec-once=[workspace 2 silent] $terminal
  -- exec-once=[workspace 3 silent] vivaldi
  -- exec-once=hyprctl dispatch workspace 3
end)

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
  ecosystem = {
    enforce_permissions = false,
    no_update_news = true,
  },
})

-- TODO: Proper permission handling. Change 'enforce_permissions' above for that to start.
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.95,
        dim_inactive     = true,
        dim_strength     = 0.1,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status                    = "master",
        always_keep_position          = true,
        allow_small_split             = true,
        orientation                   = "center",
        mfact                         = 0.6,
        slave_count_for_center_master = 0,
        new_on_top                    = true,
        drop_at_cursor                = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true,  -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.exec_cmd(sessionManager))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + c", hl.dsp.window.float({ action = "toggle" }))
-- Switch the master and set focus on the new master.
hl.bind(mainMod .. " + e", function()
  hl.dsp.layout("cycleprev loop")
  hl.dsp.layout("swapwithmaster master")
end)
-- Switch the master and set focus on the new master.
hl.bind(mainMod .. " + w", function()
  hl.dsp.layout("cyclenext loop")
  hl.dsp.layout("swapwithmaster master")
end)
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd(menu))

-- Move focus and windows with mainMod + arrow keys
hl.bind(mainMod .. " + h"             , hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l"             , hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k"             , hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j"             , hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left"          , hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right"         , hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up"            , hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down"          , hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + h"     , hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l"     , hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k"     , hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j"     , hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + left"  , hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right" , hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up"    , hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down"  , hl.dsp.window.move({ direction = "down" }))

-- TODO: Window Resizing
-- # Window Resizing
-- bind = $mainMod, R, submap, resize
--
-- # will start a submap called "resize"
-- submap = resize
--
-- $sizeIncrement = 20
--
-- # sets repeatable binds for resizing the active window
-- binde = , l, resizeactive, $sizeIncrement 0
-- binde = , h, resizeactive, -$sizeIncrement 0
-- binde = , k, resizeactive, 0 -$sizeIncrement
-- binde = , j, resizeactive, 0 $sizeIncrement
-- binde = , right, resizeactive, $sizeIncrement 0
-- binde = , left, resizeactive, -$sizeIncrement 0
-- binde = , up, resizeactive, 0 -$sizeIncrement
-- binde = , down, resizeactive, 0 $sizeIncrement
--
-- # use reset to go back to the global submap
-- bind = , escape, submap, reset
-- bind = , return, submap, reset
--
-- # will reset the submap, which will return to the global submap
-- submap = reset

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshot a monitor
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
-- Screenshot a window
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
-- Screenshot a region
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
-- Pick a color. The order of the button presses does not matter.
hl.bind(mainMod .. " + CTRL + SHIFT + p", hl.dsp.exec_cmd("hyprpicker -a"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

-- Layer rules for system dialog styling.
hl.layer_rule({
    name = "logout-blur",
    match = { namespace = "logout_dialog" },
    blur = true,
    dim_around = true,
})
hl.layer_rule({
    name = "launcher-blur",
    match = { namespace = "launcher" },
    dim_around = true,
})
