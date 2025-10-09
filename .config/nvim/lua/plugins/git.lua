return {
    {
        "tpope/vim-fugitive",
        dependencies = {
            { "junegunn/fzf" },
            { "junegunn/fzf.vim" },
            dependencies = { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            local builtin = require("telescope.builtin")

            -- Fugitive commands
            vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
            vim.keymap.set("n", "<leader>gb", ":Git branch<CR>", { desc = "Git blame" })
            vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { desc = "Git pull" })
            vim.keymap.set("n", "<leader>gP", ":Git push<CR>", { desc = "Git Push" })
            vim.keymap.set("n", "<leader>gv", ":Gvdiffsplit<CR>", { desc = "Git vertical diff, 2 way split" })
            vim.keymap.set("n", "<leader>gm", ":Gvdiffsplit!<CR>", { desc = "Git vertical diff, 3 way split" })
            -- vim.keymap.set("n", "<leader>gf", ":GFiles?<CR>", { desc = "Git files" })

            -- -- Telescope replacements for fzf.vim
            -- vim.keymap.set("n", "<leader>gf", function()
            --     builtin.git_files({ show_untracked = true }) -- same as :GFiles?
            -- end, { desc = "Git files (tracked + untracked)" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true, -- inline git blame

            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
        }
    }
}
