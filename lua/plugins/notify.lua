return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      notify.setup({
        -- { default, minimal, simple, compact, wrapped-compact, wrapped-default },
        render = "default",
        -- { fade_in_slide_out, fade, slide, static }
        stages = "slide",
        fps = 60,
        timeout = 2000,
        max_width = 80,
      })
      vim.notify = notify

      -- notify with treesitter highlighting for a given language
      -- usage: notify_code("def foo(): pass", "python")
      function _G.notify_code(msg, ft, level, extra)
        extra = extra or {}
        extra.on_open = function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          local lang = vim.treesitter.language.get_lang(ft) or ft
          if pcall(vim.treesitter.language.inspect, lang) then
            vim.bo[buf].filetype = ft
          end
        end
        vim.notify(msg, level or vim.log.levels.INFO, extra)
      end
    end,
  },
}
