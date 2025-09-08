local colors_name = "igorbones"
vim.g.colors_name = colors_name

local lush = require("lush")
local hsluv = lush.hsluv
local util = require("zenbones.util")

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
local blueGray = "#6E94AD"
local purple = "#937ABA"
local greenGray = "#83a598"
local redGray = "#ad6e6e"
local orangeGray = "#ad846e"

local palette
palette = util.palette_extend({
	bg = hsluv("#262b33"),
	fg = hsluv("#8693AE"),
	rose = hsluv(blueGray), -- Palavras em negrito
	leaf = hsluv(purple), -- Não sei onde é
	wood = hsluv(blueGray), -- Barra vertical final linha. Highlight WARNING, palavras iguais
	water = hsluv(greenGray), -- Panic, len, require
	blossom = hsluv(purple), -- Matching parentesis, brackets etc
	sky = hsluv(greenGray), -- Data types
}, bg)

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement({ base_specs.Statement, fg = palette.rose }),
		Special({ fg = palette.water }),
		Type({ fg = palette.sky, gui = "italic" }),
		String({ fg = hsluv("#BA9D89") }),

		DiagnosticWarn({ fg = hsluv(orangeGray) }),
		DiagnosticVirtualTextWarn({ fg = hsluv(orangeGray) }),
		DiagnosticSignWarn({ fg = hsluv(orangeGray) }),
		DiagnosticUnderlineWarn({ gui = "undercurl", sp = hsluv(orangeGray) }),

		DiagnosticError({ fg = hsluv(redGray) }),
		DiagnosticVirtualTextError({ fg = hsluv(redGray) }),
		DiagnosticSignError({ fg = hsluv(redGray) }),
		DiagnosticUnderlineError({ gui = "undercurl", sp = hsluv(redGray) }),

		GitSignsAdd({ fg = hsluv(greenGray) }),
		GitSignsChange({ fg = hsluv(purple) }),
		GitSignsDelete({ fg = hsluv(redGray) }),
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
