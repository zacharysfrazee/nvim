-- nvim-tree said to add these
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true

-- Lazy
require("config.lazy")

-- Plugins
require("lazy").setup({
    spec = {
        -- Theme and highlighting
        { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
        { "navarasu/onedark.nvim",    version = "*" },
        { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},

        -- Autoclose brackets
        { "m4xshen/autoclose.nvim",   version = "*" },

        -- File search
        { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},

        -- Buffers, Explorer, and tabs
        { "nvim-tree/nvim-tree.lua", version = "*", lazy = false,
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            config = function()
                require("nvim-tree").setup {}
            end,
        },
        { "tiagovla/scope.nvim",                   config = true },
        { 'akinsho/bufferline.nvim',               version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

        -- Git lines changed
        { 'lewis6991/gitsigns.nvim',               version = "*", },

        -- LSP and Completion
        { 'neovim/nvim-lspconfig',                 version = "*", },
        { 'hrsh7th/cmp-nvim-lsp',                  version = "*", },
        { 'hrsh7th/cmp-buffer',                    version = "*", },
        { 'hrsh7th/cmp-path',                      version = "*", },
        { 'hrsh7th/cmp-cmdline',                   version = "*", },
        { 'hrsh7th/nvim-cmp',                      version = "*", },
        { 'hrsh7th/cmp-nvim-lsp-signature-help',   version = "*", },

        -- Snippets engine
        { 'hrsh7th/cmp-vsnip',                     version = "*", },
        { 'hrsh7th/vim-vsnip',                     version = "*", },
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

-- I suck at spelling things
vim.opt.spell     = true
vim.opt.spelllang = "en_us"

-- Trailing whitespace begone!
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Theme
vim.opt.background = "dark"
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

vim.cmd('hi SpellBad ctermbg=cyan guisp=cyan')


-- Autoclose brackets
require("autoclose").setup()

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, { desc = 'Telescope find files' })

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
    current_line_blame  = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
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


-- LSP SETUP
-- -------------------------
local cmp = require'cmp'

cmp.setup({
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
  },
  window = {
      completion    = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
      ['<C-b>']     = cmp.mapping.scroll_docs(-4),
      ['<C-f>']     = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>']     = cmp.mapping.abort(),
      ['<tab>']     = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'nvim_lsp_signature_help' }
  }, {
      { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}


require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}

-- Annoying error text
vim.diagnostic.config({
    virtual_text  = false,
    virtual_lines = false,
})

-- Keybindings
vim.api.nvim_set_keymap('t', '<ESC>',   '<C-\\><C-n>',  { noremap = true })                -- Term exit on Esc
vim.api.nvim_set_keymap('i', '<C-H>',   '<C-W>',        { noremap = true })                -- Ctrl + Backspace
vim.api.nvim_set_keymap('i', '<C-DEL>', '<C-o>dw',      { noremap = true })                -- Ctrl + Delete
vim.api.nvim_set_keymap('n', '<C-s>',   ':w<CR>',       { noremap = true, silent = true }) -- Noob Save Normal
vim.api.nvim_set_keymap('i', '<C-s>',   '<Esc>:w<CR>a', { noremap = true, silent = true }) -- Noob Save Insert

