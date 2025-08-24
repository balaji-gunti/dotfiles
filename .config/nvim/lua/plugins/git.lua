return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
            vim.keymap.set("n", "<leader>gf", ":GFiles?<CR>", { desc = "Git files (fzf)" })
            vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
            vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
            vim.keymap.set("n", "<leader>gv", ":Gvdiffsplit<CR>", { desc = "Git vertical diff" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,

            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
        }
    }
}
