require("config.options")
require("config.keybinds")
require("config.lazy")
local vim = vim

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

vim.opt.updatetime = 200

-- Highlight symbol under cursor
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if client and client.server_capabilities.documentHighlightProvider then
            -- Only create these autocmds for non-YAML files
            if vim.bo[bufnr].filetype ~= "yaml" then
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.document_highlight()
                    end
                })

                vim.api.nvim_create_autocmd("CursorMoved", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.clear_references()
                    end
                })
            end
        end
    end
})
