return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ensure_installed = {
                "lua",
                "tsx",
                "typescript",
                "javascript",
                "python",
                "go",
                "css",
                "html",
                "json",
                "glimmer",
                "yaml"
            }

            require("nvim-treesitter").setup()

            -- .hbs is filetype "handlebars"; the parser is named "glimmer".
            vim.treesitter.language.register("glimmer", "handlebars")
            vim.treesitter.language.register("glimmer", "html.handlebars")

            local installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.iter(ensure_installed)
                :filter(function(parser) return not vim.tbl_contains(installed, parser) end)
                :totable()
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            local function attach(bufnr, ft)
                pcall(vim.treesitter.start, bufnr)
                if ft ~= "yaml" then
                    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args) attach(args.buf, args.match) end,
            })

            -- Buffers restored by `:restart` (or otherwise already loaded with a
            -- filetype) never fire FileType, so backfill them here.
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
                    attach(buf, vim.bo[buf].filetype)
                end
            end
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
