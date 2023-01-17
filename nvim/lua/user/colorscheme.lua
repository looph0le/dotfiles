--local colorscheme = "gruvbox"

--local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
--if not status_ok then
--  return
--end
--local present, catppuccin = pcall(require, "catppuccin")
--if not present then return end
--

local pywal = require('pywal')

require('poimandres').setup {
  bold_vert_split = false, -- use bold vertical separators
  dim_nc_background = false, -- dim 'non-current' window backgrounds
  disable_background = true, -- disable background
  disable_float_background = true, -- disable background for floats
  disable_italics = false, -- disable italics
}

-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
    statusbar = "transparent",
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 1, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

-- Lua
require('onedark').setup  {
    -- Main options --
    style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true,  -- Show/hide background
    term_colors = false, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'bold',
        keywords = 'none',
        functions = 'bold',
        strings = 'none',
        variables = 'bold'
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require("catppuccin").setup {
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	term_colors = true,
	transparent_background = true,
	no_italic = false,
	no_bold = false,
	styles = {
		comments = {"bold"},
		conditionals = {},
		loops = {},
		functions = {"bold"},
		keywords = {},
		strings = {},
		variables = {"bold"},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		mocha = {
			base = "#000000",
		},
	},
	highlight_overrides = {
		mocha = function(C)
			return {
				TabLineSel = { bg = C.pink },
				NvimTreeNormal = { bg = C.none },
				CmpBorder = { fg = C.surface2 },
				Pmenu = { bg = C.none },
				NormalFloat = { bg = C.none },
				TelescopeBorder = { link = "FloatBorder" },
			}
		end,
	},
}
-- require("catppuccin").setup {
-- 	term_colors = true,
-- 	transparent_background = false,
-- 	integrations = {
-- 		gitsigns = true,
-- 		neotree = true,
-- 		notify = true,
-- 		treesitter = true,
-- 		treesitter_context = true,
-- 		symbols_outline = true,
-- 		telescope = true,
-- 		lsp_trouble = true,
-- 		which_key = true,
-- 		neotest = true,
-- 		mini = true,
-- 		noice = true,
-- 		mason = true,
-- 		dap = {
-- 			enabled = true,
-- 			enable_ui = true, -- enable nvim-dap-ui
-- 		},
-- 		native_lsp = {
-- 			enabled = true,
-- 			virtual_text = {
-- 				errors = { "italic" },
-- 				hints = { "italic" },
-- 				warnings = { "italic" },
-- 				information = { "italic" },
-- 			},
-- 			underlines = {
-- 				errors = { "underline" },
-- 				hints = { "underline" },
-- 				warnings = { "underline" },
-- 				information = { "underline" },
-- 			},
-- 		},
-- 		navic = {
-- 			enabled = false,
-- 			custom_bg = "NONE",
-- 		},
-- 	},
-- }


--pywal.setup()
vim.cmd.colorscheme "catppuccin"
--vim.cmd.colorscheme ""
