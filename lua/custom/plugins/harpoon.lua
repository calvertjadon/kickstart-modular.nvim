return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {},
  keys = function()
    local harpoon = require 'harpoon'
    local function toggle_telescope(harpoon_files)
      local finder = function()
        local entries = {}
        for index, item in ipairs(harpoon_files.items) do
          table.insert(entries, { index = index, path = item.value })
        end

        return require('telescope.finders').new_table {
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry.path,
              display = string.format('%d: %s', entry.index, entry.path),
              ordinal = entry.path,
              index = entry.index,
            }
          end,
        }
      end
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = finder(),
          previewer = require('telescope.config').values.file_previewer {},
          sorter = require('telescope.config').values.generic_sorter {},
          attach_mappings = function(prompt_bufnr, map)
            local actions = require 'telescope.actions'
            local state = require 'telescope.actions.state'

            map('i', '<M-x>', function()
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(finder())
            end)

            map('i', '<M-u>', function()
              local selected_entry = state.get_selected_entry()
              local index = selected_entry.index
              print(index)
              local current_picker = state.get_current_picker(prompt_bufnr)
              if index > 1 then
                local temp = harpoon_files.items[index]
                harpoon_files.items[index] = harpoon_files.items[index - 1]
                harpoon_files.items[index - 1] = temp
                current_picker:refresh(finder())
                vim.defer_fn(function()
                  actions.move_selection_previous(prompt_bufnr)
                end, 0)
              end
            end)

            map('i', '<M-d>', function()
              local selected_entry = state.get_selected_entry()
              local index = selected_entry.index
              print(index)
              local current_picker = state.get_current_picker(prompt_bufnr)
              if index < #harpoon_files.items then
                local temp = harpoon_files.items[index]
                harpoon_files.items[index] = harpoon_files.items[index + 1]
                harpoon_files.items[index + 1] = temp
                current_picker:refresh(finder())
                vim.defer_fn(function()
                  actions.move_selection_next(prompt_bufnr)
                end, 10)
              end
            end)

            actions.select_default:replace(function()
              local selected_entry = state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd('edit ' .. selected_entry.value)
            end)

            return true
          end,
        })
        :find()
    end
    return {

      {
        '<leader>fa',
        function()
          harpoon:list():add()
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles [A]dd',
      },
      {
        '<leader>fe',
        function()
          toggle_telescope(harpoon:list())
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles [E]xplore',
      },
      {
        '<M-1>',
        function()
          harpoon:list():select(1)
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles Open [1]',
      },
      {
        '<M-2>',
        function()
          harpoon:list():select(2)
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles Open [2]',
      },
      {
        '<M-3>',
        function()
          harpoon:list():select(3)
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles Open [3]',
      },
      {
        '<leader>fp',
        function()
          harpoon:list():prev()
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles [P]rev',
      },
      {
        '<leader>fn',
        function()
          harpoon:list():next()
        end,
        mode = 'n',
        desc = 'Harpoon [F]iles [N]ext',
      },
    }
  end,
}
