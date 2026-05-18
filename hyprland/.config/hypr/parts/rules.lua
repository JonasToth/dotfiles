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

