return {
    {
        'ojroques/vim-oscyank', -- This helps with ssh tunneling and copying to clipboard
    },
    {
        'tpope/vim-surround', -- Provides mappings to easily delete, change and add such surroundings in pairs
    },
    {
        "tpope/vim-commentary", -- Comment and Uncomment code
        config = function()
            -- Remap vim-commentary
            -- Line comment
            vim.keymap.set("n", "cc", "gcc", { remap = true, desc = "Comment line" })
            vim.keymap.set("v", "cc", "gc", { remap = true, desc = "Comment selection" })

            -- Uncomment (just reuses commentary toggle)
            vim.keymap.set("n", "cu", "gcc", { remap = true, desc = "Uncomment line" })
            vim.keymap.set("v", "cu", "gc", { remap = true, desc = "Uncomment selection" })
        end,
    },
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("codeium").setup({})
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({})

            -- Integrate with nvim-cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    {
        "windwp/nvim-ts-autotag", -- For autocomplete/rename html tags
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup {
                options = {
                    mode = "buffers",    -- show buffers instead of tabs
                    numbers = "ordinal", -- show buffer numbers (or "none")
                    diagnostics = "nvim_lsp",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = "slant",     -- "slant" | "thin" | "thick"
                    always_show_bufferline = true, -- keep it visible even with 1 buffer
                }
            }
        end,
    },
    -- lua/plugins/tmux-navigator.lua
    {
        "christoomey/vim-tmux-navigator",
        lazy = false, -- make sure it's always loaded
    }
}
