-- See `:help gitsigns` to understand what the configuration keys do
-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]f", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "jump to next git [c]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "jump to previous git [c]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>ca", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "git [c]hange [a]dd" })
				map("v", "<leader>cr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "git [c]hange [r]eset" })
				-- normal mode
				map("n", "<leader>ca", gitsigns.stage_hunk, { desc = "git [c]hange [a]dd" })
				map("n", "<leader>cr", gitsigns.reset_hunk, { desc = " git [c]hange [r]eset" })
				map("n", "<leader>cu", gitsigns.undo_stage_hunk, { desc = "git [c]hange [u]ndo add" })
				map("n", "<leader>cA", gitsigns.stage_buffer, { desc = "git [c]hange [A]dd file" })
				map("n", "<leader>cR", gitsigns.reset_buffer, { desc = "git [c]hange [R]eset file" })
				map("n", "<leader>cp", gitsigns.preview_hunk, { desc = "git [c]hange [p]review" })
				-- map("n", "<leader>hb", gitsigns.blame_line, { desc = "[h]unk [b]lame line" })
				map("n", "<leader>cd", gitsigns.diffthis, { desc = "[c]hange [d]iff against index" })
				map("n", "<leader>cD", function()
					gitsigns.diffthis("@")
				end, { desc = "[c]hange [D]iff against last commit" })
				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[t]oggle git show [b]lame line" })
				-- map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
			end,
		},
	},
}
