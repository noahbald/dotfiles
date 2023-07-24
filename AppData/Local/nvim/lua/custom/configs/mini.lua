local animate = require("mini.animate")
local M = {}

M.animate = {
    cursor = {
        timing = animate.gen_timing.cubic({ duration = 100, unit = "total" }),
    },

    scroll = {
        timing = animate.gen_timing.quadratic({ duration = 200, unit = "total" }),
    },

    resize = {
        enable = false,
    },

    open = {
        enable = false,
    },

    close = {
        enable = false,
    },
}

return M
