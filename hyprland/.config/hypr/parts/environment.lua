-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

local V = require("parts.global_vars")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_PICTURES_DIR", V.home .. "/Pictures")
hl.env("HYPRSHOT_DIR", V.home .. "/Screenshots")
hl.env("SSH_AUTH_SOCK", os.getenv("XDG_RUNTIME_DIR") .. "/ssh-agent.socket")

hl.env("XCURSOR_SIZE", "14")
hl.env("HYPRCURSOR_SIZE", "14")
