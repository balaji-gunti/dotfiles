return {
    {
        'tpope/vim-surround', -- Provides mappings to easily delete, change and add such surroundings in pairs
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require("ts-comments").setup()

            vim.keymap.set("n", "cc", "gcc", { remap = true, desc = "Comment line" })
            vim.keymap.set("v", "cc", "gc", { remap = true, desc = "Comment selection" })
            vim.keymap.set("n", "cu", "gcc", { remap = true, desc = "Uncomment line" })
            vim.keymap.set("v", "cu", "gc", { remap = true, desc = "Uncomment selection" })
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
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        'norcalli/nvim-colorizer.lua'
    },
    {
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<leader><Tab>",
                    clear_suggestion = "<C-]>"
                },
            })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require("nvim-highlight-colors").setup({
                -----Render style
                -----@usage 'background'|'foreground'|'virtual'
                --render = 'background',

                ---Highlight hex colors, e.g. '#FFFFFF'
                enable_hex = true,

                ---Highlight short hex colors e.g. '#fff'
                enable_short_hex = true,

                ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
                enable_rgb = true,

                ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
                enable_hsl = true,

                ---Highlight ansi colors, e.g '\033[0;34m'
                enable_ansi = true,

                ---Highlight xterm 256 (8bit) colors, e.g '\033[38;5;118m'
                enable_xterm256 = true,

                ---Highlight xterm True Color (24bit) colors, e.g '\033[38;2;118;64;90m'
                enable_xtermTrueColor = true,

                -- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
                enable_hsl_without_function = true,

                ---Highlight CSS variables, e.g. 'var(--testing-color)'
                enable_var_usage = true,
                ---Highlight named colors, e.g. 'green'
                enable_named_colors = true,

                ---Highlight tailwind colors, e.g. 'bg-blue-500'
                enable_tailwind = true,
            })
        end,
    },
    {
        "sphamba/smear-cursor.nvim",

        opts = {
            stiffness = 0.9,                      -- 0.6      [0, 1]
            trailing_stiffness = 0.6,             -- 0.45     [0, 1]
            stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
            trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
            damping = 0.95,                       -- 0.85     [0, 1]
            damping_insert_mode = 0.95,           -- 0.9      [0, 1]
            distance_stop_animating = 0.5,        -- 0.1      > 0

            -- Smear cursor when switching buffers or windows.
            smear_between_buffers = true,

            -- Smear cursor when moving within line or to neighbor lines.
            -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
            smear_between_neighbor_lines = true,

            -- Draw the smear in buffer space instead of screen space when scrolling
            scroll_buffer_space = true,

            -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
            -- Smears and particles will look a lot less blocky.
            legacy_computing_symbols_support = false,

            -- Smear cursor in insert mode.
            -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
            smear_insert_mode = true,
        },
    },
    {
        dir = "~/my-nvim-plugins/hl7.nvim",
        name = "hl7.nvim",
        ft = "hl7",
        lazy = false,
        config = function()
            local hl7 = require("hl7")
            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = "*.hl7",
                callback = function()
                    hl7.format()
                    -- hl7.show_tree()
                    hl7.highlight()
                end,
            })

            -- Auto-run when HL7 file opens
            -- vim.api.nvim_create_autocmd("FileType", {
            --     pattern = "hl7",
            --     callback = function()
            --         hl7.highlight()
            --         hl7.format()
            --     end,
            -- })

            -- hl7.highlight();

            vim.keymap.set("n", "<leader>hf", function() hl7.format() end)
            vim.keymap.set("n", "<leader>hp", hl7.parse)
            vim.keymap.set("n", "<leader>hP", function() hl7.find_segment("PID") end)
            vim.keymap.set("n", "<leader>hO", function() hl7.find_segment("OBX") end)
            vim.keymap.set("n", "<leader>ht", function() hl7.show_tree() end) -- toggle
            vim.keymap.set("n", "<leader>hn", hl7.show_field_numbers)
        end,
    }
}
