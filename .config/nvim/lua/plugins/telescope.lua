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

        -- default live grep
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })

        -- No need to type escape character("\") while searching with special characters
        vim.keymap.set('n', '<leader>fF', function()
            builtin.live_grep({
                additional_args = function() return { "--fixed-strings" } end
            })
        end, { desc = 'Literal live grep (no regex)' })
        vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope grep string' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope help man pages' })
        vim.keymap.set('n', '<leader>fgf', builtin.git_status, { desc = 'Telescope git files' })
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files {
                cmd = vim.fn.stdpath("config")
            }
        end)

        -- Find references
        vim.keymap.set('n', '<leader>fr', function()
            builtin.lsp_references()
        end)
        require "config.telescope.multigrep".setup()
    end
}
