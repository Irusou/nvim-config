return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- motion: lower stiffness = softer, floatier movement
    stiffness = 0.6,
    trailing_stiffness = 0.35,
    trailing_exponent = 2,
    damping = 0.9,                 -- higher = less overshoot, smoother stop
    transparent_bg_fallback_color = "#1e1e2e",
    distance_stop_animating = 0.1, -- lower = animation runs all the way into place

    -- smoothness: redraw more often (7ms is about 144fps, use 17 for 60fps)
    time_interval = 17,

    -- behaviour
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    smear_insert_mode = true,
    smear_to_cmd = true,

    -- finer-grained rendering, needs a terminal that supports it
    -- (Kitty, WezTerm, Ghostty, Alacritty with a recent font setup)
    legacy_computing_symbols_support = true,
  },
}
