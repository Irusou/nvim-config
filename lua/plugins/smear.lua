return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts =
  {
    cursor_color = "",
    legacy_computing_symbols_support = true,
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    smear_insert_mode = true,
    stiffness = 1.0,          -- higher = snappier
    trailing_stiffness = 0.3, -- higher = shorter trail
    distance_stop_animating = 0.5,
  },
}
