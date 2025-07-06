-- nvim-tree said to add these
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true

-- Lazy
require("config.lazy")

-- Plugins
require("lazy").setup({
    spec = {
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
        { 'akinsho/bufferline.nvim',  version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
        { 'lewis6991/gitsigns.nvim',  version = "*", },
        { 'neovim/nvim-lspconfig',    version = "*", },
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
vim.api.nvim_set_keymap('t', '<ESC>',   '<C-\\><C-n>', {noremap = true}) -- Term exit on Esc
vim.api.nvim_set_keymap('i', '<C-H>',   '<C-W>',       {noremap = true}) -- Ctrl + Backspace
vim.api.nvim_set_keymap('i', '<C-DEL>', '<C-o>dw',     {noremap = true}) -- Ctrl + Delete

-- Trailing whitespace begone!
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

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

-- File Explorer and Tabs
require("nvim-tree").setup()
require("scope").setup({})
require("bufferline").setup{}

-- Git Signs
require('gitsigns').setup {
    signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_linaae_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}

-- LSP
require'lspconfig'.pyright.setup{}

