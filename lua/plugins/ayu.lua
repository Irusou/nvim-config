return {
  "Shatur/neovim-ayu",
  config = function()
    require('ayu').setup({
      mirage = true,    -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
      terminal = false, -- Set to `false` to let terminal manage its own colors.
    })
  end
}
