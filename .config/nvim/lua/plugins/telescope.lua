return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        -- local telescope = require('telescope')

        -- -- Pick the best available search tool
        -- local find_command
        -- if vim.fn.executable("rg") == 1 then
        --     find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
        -- elseif vim.fn.executable("fd") == 1 then
        --     find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
        -- else
        --     find_command = { "find", ".", "-type", "f" }
        -- end

        -- telescope.setup({
        --     pickers = {
        --         find_files = {
        --             find_command = find_command,
        --         },
        --     },
        -- })

        vim.keymap.set('n', '<leader>p', function()
            builtin.find_files({ hidden = true, no_ignore = true })
        end, { desc = "Find ALL files (incl. ignored)" })
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
