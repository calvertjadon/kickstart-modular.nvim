return {
  -- 'vim-test/vim-test',
  -- keys = {
  --   { '<leader>tt', '<CMD>TestNearest<CR>', desc = '[T]est Nearest', mode = 'n' },
  --   { '<leader>tT', '<CMD>TestFile<CR>', desc = '[T]est File', mode = 'n' },
  --   { '<leader>ta', '<CMD>TestSuite<CR>', desc = '[T]est Suite', mode = 'n' },
  --   { '<leader>tl', '<CMD>TestLast<CR>', desc = '[T]est [L]ast', mode = 'n' },
  --   { '<leader>tg', '<CMD>TestVisit<CR>', desc = '[T]est [V]isit Last', mode = 'n' },
  -- },

  'nvim-neotest/neotest',
  ft = { 'python' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  opts = function()
    return {
      adapters = {

        require 'neotest-python' {
          dap = { justMyCode = false },
          runner = 'pytest',
          pytest_discover_instances = true,
        },
      },
    }
  end,
  config = function(_, opts)
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup(opts)
  end,
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = '[T]est Nearest',
      mode = 'n',
    },
    {
      '<leader>tT',
      function()
        require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' }
      end,
      desc = '[T]est File',
      mode = 'n',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.run { vim.fn.getcwd(), strategy = 'dap' }
      end,
      desc = '[T]est Suite',
      mode = 'n',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last { strategy = 'dap' }
      end,
      desc = '[T]est [L]ast',
      mode = 'n',
    },
    -- { '<leader>tg', '<CMD>TestVisit<CR>', desc = '[T]est [V]isit Last', mode = 'n' },
  },
}
