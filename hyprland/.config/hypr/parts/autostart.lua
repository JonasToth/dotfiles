-------------------
---- AUTOSTART ----
-------------------

local V = require("parts.global_vars")

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
  hl.exec_cmd("hypridle")   -- automatic screen lock
  hl.exec_cmd("waybar&")    -- toolbar
  hl.exec_cmd("fnott&")     -- notification daemon

  -- Audio Setup
  hl.exec_cmd("pipewire")
  hl.exec_cmd("wireplumber")
  hl.exec_cmd("pipewire-pulse")

  -- Automatically start my desired programs on proper workspaces.
  hl.exec_cmd(V.terminal, { workspace = 1 })
  hl.exec_cmd(V.terminal, { workspace = 2 })
  hl.exec_cmd("vivaldi", { workspace = 3 })

  hl.dsp.focus({ workspace = 3 })
end)


