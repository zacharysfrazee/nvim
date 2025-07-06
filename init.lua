-- nvim-tree said to add these
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true

-- Lazy
require("config.lazy")

-- Plugins
require("lazy").setup({
    spec = { 
        -- import your plugins
        { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
        { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }}, 
        { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
        { "nvim-tree/nvim-tree.lua", version = "*", lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            config = function()
                require("nvim-tree").setup {}
            end,
        },
        { "tiagovla/scope.nvim", config = true },
        { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}
    },  
  
    checker = { enabled = true },
})


-- Tabs are 4 spaces
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

-- Line Numbers and wrap
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.wrap           = false

-- Backspace behavior
vim.opt.backspace = 'indent,eol,start'

-- Keybindings
vim.api.nvim_set_keymap('t', '<ESC>','<C-\\><C-n>', {noremap = true})

-- Gruvbox
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.git_files, { desc = 'Telescope find files' })

-- Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp", "python" },

    sync_install = false,
    auto_install = true,

    ignore_install = { },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Nvim-tree
require("nvim-tree").setup()

-- Tabs and File Explorer
require("scope").setup({})
require("bufferline").setup{}

-- LSP



