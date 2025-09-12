require("config.options")
require("config.keybinds")
require("config.lazy")

local yank_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch", -- highlight group to use
            timeout = 200,         -- duration in ms
        })
    end,
})

vim.opt.termguicolors = true                  -- good to have for plugins
vim.cmd("hi Normal ctermbg=none guibg=none")  -- use terminal background
vim.cmd("hi NonText ctermbg=none guibg=none") -- also fix ~ lines
