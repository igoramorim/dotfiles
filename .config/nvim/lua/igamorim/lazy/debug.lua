return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
	},

        --stylua: ignore start
	keys = {
		{"<leader>dc", function() require("dap").continue() end, mode = "n", desc = "[d]ebug start/[c]ontinue",},
		{"<leader>ds", function() require("dap").terminate() end, mode = "n", desc = "[d]ebug [s]top",},
		{"<leader>di", function() require("dap").step_into() end, mode = "n", desc = "[d]ebug step [i]nto",},
		{"<leader>do", function() require("dap").step_over() end, mode = "n", desc = "[d]ebug step [o]ver",},
		{"<leader>dx", function() require("dap").step_out() end, mode = "n", desc = "[d]ebug step out", },
		{"<leader>db", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "[d]ebug toggle [b]reakpoint", },
		{"<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, mode = "n", desc = "[d]ebug [B]reakpoint condition",},
		{"<Leader>dl", function() require('dap').run_last() end, mode = "n", desc = '[d]ebug run [l]ast', },

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{"<leader>du", function() require("dapui").toggle() end, mode = "n", desc = "[d]ebug see last session result",},
		{"<leader>de", function() require("dapui").eval() end, mode = "n", desc = '[d]ebug [e]valuate expression', },

		{"<leader>td", function() require("dap-go").debug_test() end, mode = "n", desc = "[t]est [d]ebug",},
	},
	--stylua: ignore end

	opts = {},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup(opts)

		-- stylua: ignore start
		-- Change breakpoint icons
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ffcc00" })

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", numhl = "DapBreakpoint"})
		vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpoint", numhl = "DapBreakpointCondition"})
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapBreakpoint", numhl = "DapLogPoint"})
		vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "DapStopped"})
		-- stylua: ignore end

		--stylua: ignore start
		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
		--stylua: ignore end

		-- Install golang specific config
		require("dap-go").setup({
			-- ap_configurations = {
			-- 	{
			-- 		-- Must be "go" or it will be ignored by the plugin
			-- 		type = "go",
			-- 		name = "Attach remote",
			-- 		mode = "remote",
			-- 		request = "attach",
			-- 	},
			-- },
			delve = {
				path = "dlv",
				port = "${port}",
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
			},
		})
	end,
}
