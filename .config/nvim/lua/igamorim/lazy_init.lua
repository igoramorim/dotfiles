-- Install `lazy.nvim` plugin manager
-- To check the current status of your plugins, run :Lazy
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	"tpope/vim-fugitive",

	-- { "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

	require("igamorim.lazy.gitsigns"),

	-- require("igamorim.lazy.wich-key"),

	require("igamorim.lazy.telescope"),

	require("igamorim.lazy.lsp"),

	require("igamorim.lazy.conform"), -- Autoformat

	require("igamorim.lazy.cmp"), -- Autocomplete

	require("igamorim.lazy.colorscheme"),

	require("igamorim.lazy.todo-comments"),

	require("igamorim.lazy.mini"), -- Statusline

	require("igamorim.lazy.treesitter"),

	require("igamorim.lazy.neo-tree"),

	require("igamorim.lazy.autoparis"), -- Close () [] {} automatically

	require("igamorim.lazy.leap"), -- Better jump movements

	-- require("igamorim.lazy.debug"),
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
