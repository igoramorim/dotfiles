-- globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.filetype.add({ extension = { frag = "glsl" } })
vim.filetype.add({ extension = { vert = "glsl" } })

-- options - see `:help vim.opt`

-- make line numbers default
vim.opt.number = true

-- you can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 100

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 200

vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- show a vertical line indicator at column number.
vim.opt.colorcolumn = "120"

vim.opt.hlsearch = true

-- keymaps - see `:help vim.keymap.set()`

-- clear highlight search on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostic
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "go to previous error message" })
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "go to next error message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show diagnostic error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic quickfix list" })

-- disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "use j to move!!"<CR>')

-- move between window splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move focus to the upper window" })

-- move block of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- move between buffers
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "move to the next buffer" })
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "move to the previous buffer" })

-- delete buffers
vim.keymap.set("n", "<leader>bd", ":bd <CR>", { desc = "buffer delete" })
vim.keymap.set(
	"n",
	"<leader>bD",
	":w <bar> %bd <bar> e# <bar> bd# <CR><CR>",
	{ desc = "buffer delete all expect the current" }
)

-- Use _ to go to the first non-blank character of the line
vim.keymap.set("n", "_", "^")

vim.keymap.set("n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "replace" })

vim.keymap.set("n", "<leader>E", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "add Go if err != nil" })

-- golang specific
vim.keymap.set("n", "<leader>tr", ":!go test %:p -v -run ^<C-r><C-w>$<CR>", { desc = "test run" })
vim.keymap.set("n", "<leader>tf", ":!go test %:p -v<CR>", { desc = "test run file" })
vim.keymap.set(
	"n",
	"<leader>tR",
	":!go test ./... -v -race -shuffle=on -count=1 -timeout=30m<CR>",
	{ desc = "test run all" }
)

-- autocommands - see `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- plugins - to check the current status of your plugins, run :Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically

	"tpope/vim-fugitive", -- git

	{ -- fuzzy finder - see `:help telescope` and `:help telescope.setup()`
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- eee `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "search help" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "search keymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "search files" })
			vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "search select telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "search current word" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "search by grep" })
			vim.keymap.set("n", "<leader>se", builtin.diagnostics, { desc = "search errors" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'search recent files ("." for repeat)' })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "search existing buffers" })
			vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "search colorschemes" })

			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] fuzzily search in current buffer" })

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "search [/] in open files" })

			-- shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "search neovim files" })

			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "git branches" })
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "git status" })
			vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "git log" })
			vim.keymap.set("n", "<leader>gL", builtin.git_bcommits, { desc = "git log for file" })
			vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "git stash" })

			vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "search marks" })
		end,
	},
	{ -- lsp
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "goto definition")
					map("gr", require("telescope.builtin").lsp_references, "goto deferences")
					map("gi", require("telescope.builtin").lsp_implementations, "goto implementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "type definition")
					map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "search symbols")
					map(
						"<leader>sS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"search workspace symbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "rename")
					map("<leader>ef", vim.lsp.buf.code_action, "error fix")
					map("K", vim.lsp.buf.hover, "hover documentation")
					map("gD", vim.lsp.buf.declaration, "goto declaration")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				gopls = {},
				zls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[f]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{ -- autocomplete - see `:help cmp`
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
	{ -- highlight TODO NOTE HACK FIX notes
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- statusline
		"echasnovski/mini.nvim",
		config = function()
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	{ -- See `:help nvim-treesitter`
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "diff", "go", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{ -- file explorer
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		lazy = false,
	},
	{ -- easier jumping
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.create_default_mappings()
		end,
	},
	{ -- colorscheme
		"RostislavArts/naysayer.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			-- vim.cmd.colorscheme("naysayer")
		end,
	},
	{ -- custom colorscheme
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			-- vim.cmd.colorscheme("igorbones")
		end,
	},
}, {
	ui = {
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

vim.cmd.colorscheme("habamax")
