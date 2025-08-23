 local function enable_transparency()
     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
 end
 return {
     {
         --        "EdenEast/carbonfox.nvim",
         "folke/tokyonight.nvim",
         config = function()
             vim.cmd.colorscheme = "tokyonight"
             --vim.cmd.colorscheme = "carbonfox"
             enable_transparency()
         end
     },
     {
         "nvim-lualine/lualine.nvim",
         dependencies = {
             "nvim-tree/nvim-web-devicons",
         },
         opts = {
             theme = 'tokyonight',
         }
     }
 }
