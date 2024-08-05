return {
  'folke/zen-mode.nvim',
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = function()
    local zenmode = require 'zen-mode'

    return {
      { '<leader>z', zenmode.toggle, desc = 'Toggle [Z]en Mode' },
    }
  end,
}
