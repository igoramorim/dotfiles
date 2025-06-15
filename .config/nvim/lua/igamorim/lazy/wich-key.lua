-- Useful plugin to show you pending keybinds.
return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>d", group = "[d]ebug" },
				{ "<leader>d_", hidden = true },
				{ "<leader>g", group = "[g]it" },
				{ "<leader>h_", hidden = true },
				{ "<leader>r", group = "[r]ename or [r]eplace" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[s]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>t", group = "[t]est" },
				{ "<leader>t_", hidden = true },
				{ "<leader>b", group = "[b]uffer" },
				{ "<leader>b_", hidden = true },
			})
			-- visual mode
			require("which-key").add({
				{ "<leader>g", desc = "[G]it", mode = "v" },
			})
		end,
	},
}
