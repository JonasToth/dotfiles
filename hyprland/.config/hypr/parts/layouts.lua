-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

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

