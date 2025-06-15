-- :help
-- This will open up a help window with some basic information
-- about reading, navigating and searching the builtin help documentation.

-- :checkhealth
-- If you experience any errors while trying to install kickstart

---------------------------------------------------------------------------------------

require("igamorim.globals")
require("igamorim.options")
require("igamorim.keymaps")
require("igamorim.lazy_init")

-- Basic Autocommands
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.filetype.add({ extension = { frag = "glsl" } })
vim.filetype.add({ extension = { vert = "glsl" } })
