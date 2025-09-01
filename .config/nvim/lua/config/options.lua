local o = vim.opt

o.number = true
o.relativenumber = true
o.cursorline = true
o.clipboard = "unnamedplus"

o.smartindent = true

o.wrap = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.hlsearch = false
o.incsearch = true
o.hidden = true -- ensure hidden buffers are allowed

-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldmethod = "indent"
o.foldlevel = 99
