return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                },
                indent = { enable = true, disable = { "yaml" } },
                ensure_installed = {
                    "lua",
                    "tsx",
                    "typescript",
                    "javascript",
                    "python",
                    "go",
                    "css",
                    "html",
                    "json"
                }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = "main",
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.outer'] = 'V',
                    },
                },
                move = {
                    set_jumps = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")

            local function map_select(lhs, query)
                vim.keymap.set({ "x", "o" }, lhs, function()
                    select.select_textobject(query, "textobjects")
                end)
            end

            map_select("af", "@function.outer")
            map_select("if", "@function.inner")
            map_select("ac", "@class.outer")
            map_select("ic", "@class.inner")
            map_select("aa", "@parameter.outer")
            map_select("ia", "@parameter.inner")

            local function map_move(lhs, fn, query)
                vim.keymap.set({ "n", "x", "o" }, lhs, function()
                    fn(query, "textobjects")
                end)
            end

            map_move("]f", move.goto_next_start, "@function.outer")
            map_move("]c", move.goto_next_start, "@class.outer")
            map_move("]F", move.goto_next_end, "@function.outer")
            map_move("]C", move.goto_next_end, "@class.outer")
            map_move("[f", move.goto_previous_start, "@function.outer")
            map_move("[c", move.goto_previous_start, "@class.outer")
            map_move("[F", move.goto_previous_end, "@function.outer")
            map_move("[C", move.goto_previous_end, "@class.outer")
        end
    }
}
