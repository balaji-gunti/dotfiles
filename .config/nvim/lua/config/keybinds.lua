vim.g.mapleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>")

-- Buffer navigation
vim.keymap.set("n", "<leader>b", "<cmd>Buffers<CR>", { desc = "List buffers (fzf)" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current buffers" })
vim.keymap.set("n", "<leader>ba", ":bufdo bd<CR>", { desc = "Close all buffers" })
vim.keymap.set("n", "<leader>k", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>j", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "za", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "zA", "zA", { desc = "Toggle all folds under cursor" })
vim.keymap.set("n", "zR", "zR", { desc = "Open all folds" })
vim.keymap.set("n", "zM", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "zr", "zr", { desc = "Open one level of folds" })
vim.keymap.set("n", "zm", "zm", { desc = "Close one level of folds" })


-- Substitution helpers
vim.keymap.set("n", "<leader>s", ":%s//<left>", { desc = "Substitute (manual pattern)" })
vim.keymap.set("n", "<leader>S", ":%s/\\<<C-r><C-w>\\>/", { desc = "Substitute word under cursor (insert replacement)" })

-- Replace word under cursor (global in buffer)
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>//g<left><left>", { desc = "Replace word under cursor globally" })

vim.keymap.set("n", "<C-\\>", ":vsplit<CR>", { desc = "Split window vertically" })
-- resize buffers automatically
vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.cmd("wincmd =")
    end
})
