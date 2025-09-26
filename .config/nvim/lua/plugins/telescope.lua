local vim = vim
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {}
            }
        }
        require("telescope").load_extension('fzf')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>p', function()
            builtin.find_files({ hidden = true, no_ignore = true })
        end, { desc = "Find ALL files (incl. ignored)" })
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope help man pages' })
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files {
                cmd = vim.fn.stdpath("config")
            }
        end)

        vim.keymap.set('n', '<leader>fr', function()
            builtin.lsp_references()
        end)
        require "config.telescope.multigrep".setup()
    end
}
