-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: gde-la-r <gde-la-r@student.42porto.com>    +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2025/02/11 16:36:49 by gde-la-r          #+#    #+#             --
--   Updated: 2025/02/11 16:36:51 by gde-la-r         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- General settings
vim.cmd("syntax on")
vim.cmd("set number")
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

-- Auto commands for C & H files (ensuring no expandtab)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h" },
    callback = function()
        vim.opt.expandtab = false
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4
    end,
})

-- Lazy.nvim bootstrap
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

-- Plugins
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
            user = "gde-la-r",   -- Your username
            mail = "gde-la-r@student.42porto.com", -- Your email
        },
        config = function(_, opts)
            require("42header").setup(opts)
        end,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / References" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
        opts = {},
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
