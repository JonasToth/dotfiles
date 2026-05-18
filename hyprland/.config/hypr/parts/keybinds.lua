---------------------
---- KEYBINDINGS ----
---------------------

local V = require("parts.global_vars")

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(V.terminal))
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd(V.menu))
hl.bind(mainMod .. " + SHIFT + e", hl.dsp.exec_cmd(V.sessionManager))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.close())

-- Layout Changes
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + c", hl.dsp.window.float({ action = "toggle" }))
-- Switch Layout to dwindle.
hl.bind(mainMod .. " + SHIFT + p", function()
  hl.config({
    general = {
      layout = "dwindle",
    }
  })
end)
hl.bind(mainMod .. " + SHIFT + o", function()
  hl.config({
    general = {
      layout = "master",
    }
  })
end)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
-- Switch the master and set focus on the new master.
hl.bind(mainMod .. " + e", hl.dsp.layout("rollprev"))
-- Switch the master and set focus on the new master.
hl.bind(mainMod .. " + w", hl.dsp.layout("rollnext"))

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

-- Switch to a submap called `resize`.
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()
    local increment = 20

    -- Set repeating binds for resizing the active window.
    hl.bind("right" , hl.dsp.window.resize({ x = increment  , y = 0          , relative = true}) , { repeating = true })
    hl.bind("left"  , hl.dsp.window.resize({ x = -increment , y = 0          , relative = true}) , { repeating = true })
    hl.bind("up"    , hl.dsp.window.resize({ x = 0          , y = increment  , relative = true}) , { repeating = true })
    hl.bind("down"  , hl.dsp.window.resize({ x = 0          , y = -increment , relative = true}) , { repeating = true })
    hl.bind("l"     , hl.dsp.window.resize({ x = increment  , y = 0          , relative = true}) , { repeating = true })
    hl.bind("h"     , hl.dsp.window.resize({ x = -increment , y = 0          , relative = true}) , { repeating = true })
    hl.bind("k"     , hl.dsp.window.resize({ x = 0          , y = increment  , relative = true}) , { repeating = true })
    hl.bind("j"     , hl.dsp.window.resize({ x = 0          , y = -increment , relative = true}) , { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
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
