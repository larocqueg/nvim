-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: gde-la-r <gde-la-r@student.42porto.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/02/09 13:55:49 by gde-la-r          #+#    #+#             --
--   Updated: 2025/02/09 13:58:36 by gde-la-r         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

vim.cmd("syntax on")
vim.cmd("set nu")
vim.cmd("set mouse=a")
vim.cmd("set si")
vim.cmd("set wrap")
vim.cmd("set noexpandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set autoindent")
vim.cmd("set smarttab")
vim.g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h" },
    callback = function()
        vim.opt.expandtab = false
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "catppuccin/nvim", name = "catppuccin" },
    { 
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },  -- Command to trigger the plugin
        keys = { "<F1>" },      -- Map the plugin to <F1>
        opts = {
            default_map = true,  -- Default mapping for <F1>
            auto_update = true,  -- Auto update header on save
            user = "gde-la-r",   -- Your username
            mail = "gde-la-r@student.42porto.com", -- Your email
        },
        config = function(_, opts)
            require("42header").setup(opts)  -- Setup the plugin with options
        end,
    },
    {
            "kylechui/nvim-surround",
            version = "*",
            event = "VeryLazy",
            opts = {},
    },
}

local opts = {}

require("lazy").setup(plugins, opts)

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set number")
vim.cmd("syntax on")
vim.cmd("set mouse=a")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "catppuccin/nvim", name = "catppuccin" },
    { 
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "Diogo-ss/42-header.nvim",
        cmd = { "Stdheader" },
        keys = { "<F1>" },
        opts = {
            default_map = true,
            auto_update = true,
            user = "username",
            mail = "your@email.com",
        },
        config = function(_, opts)
            require("42header").setup(opts)
        end,
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Add any custom configurations here
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = {},  -- Default options
        cmd = "Trouble",  -- Command to trigger Trouble
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
        config = function()
            require("trouble").setup({
                -- Custom options can be added here if needed
                -- e.g., use_lsp_diagnostics = true
            })
        end
    }
}

require("lazy").setup(plugins)

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Catppuccin colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
