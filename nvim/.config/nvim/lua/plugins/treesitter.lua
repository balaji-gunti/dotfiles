return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true, disable = { "yaml" } },
            ensure_installed = {
                "lua",
                "tsx",
                "typescript",
                "javascript",
                "python"
            }
        })
    end
}
