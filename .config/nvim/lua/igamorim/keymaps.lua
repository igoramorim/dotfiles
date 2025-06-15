-- See `:help vim.keymap.set()`

-- Clear highlight search on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "go to previous [e]rror message" })
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "go to next [e]rror message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "use j to move!!"<CR>')

-- Move between window splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move focus to the upper window" })

-- Move block of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines up" })

-- Move between tabs
-- HACK: Mapped iTerm2 to send '--' when Cmd+{ and '==' when Cmd+} because could not bind Cmd key directly here.
-- vim.keymap.set("n", "__", "<cmd>tabprevious<CR>", { desc = "Move to the previous tab" })
-- vim.keymap.set("n", "==", "<cmd>tabnext<CR>", { desc = "Move to the next tab" })

-- Move between buffers
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "move to the next buffer" })
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "move to the previous buffer" })

vim.keymap.set("n", "<leader>bd", ":bd <CR>", { desc = "[b]uffer [d]elete" })

vim.keymap.set(
	"n",
	"<leader>bD",
	":w <bar> %bd <bar> e# <bar> bd# <CR><CR>",
	{ desc = "[b]uffer [D]elete all expect the current" }
)

-- Use _ to go to the first non-blank character of the line
vim.keymap.set("n", "_", "^")

vim.keymap.set(
	"n",
	"<leader>rp",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
	{ desc = "[r]e[p]lace" }
)

vim.keymap.set("n", "<leader>E", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "add Go if err != nil" })

vim.keymap.set("n", "<leader>tr", ":!go test %:p -v -run ^<C-r><C-w>$<CR>", { desc = "[t]est [r]un" })
vim.keymap.set("n", "<leader>tf", ":!go test %:p -v<CR>", { desc = "[t]est run [f]ile" })
vim.keymap.set(
	"n",
	"<leader>tR",
	":!go test ./... -v -race -shuffle=on -count=1 -timeout=30m<CR>",
	{ desc = "[t]est [R]un all" }
)
