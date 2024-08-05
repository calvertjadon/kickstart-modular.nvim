return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {},
  keys = {
    {
      '<leader>fa',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():add()
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles [A]dd',
    },
    {
      '<leader>fe',
      function()
        local harpoon = require 'harpoon'

        -- basic telescope configuration
        local conf = require('telescope.config').values

        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles [E]xplore',
    },
    {
      '<leader>f1',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(1)
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles Open [1]',
    },
    {
      '<leader>f2',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(2)
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles Open [2]',
    },
    {
      '<leader>f3',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(3)
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles Open [3]',
    },
    {
      '<leader>f4',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(4)
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles Open [4]',
    },
    {
      '<leader>fp',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():prev()
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles [P]rev',
    },
    {
      '<leader>fn',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():next()
      end,
      mode = 'n',
      desc = 'Harpoon [F]iles [N]ext',
    },
  },
}
