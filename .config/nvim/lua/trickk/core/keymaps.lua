vim.g.mapleader = " "
vim.g.maplocalleader = " "

local km = vim.keymap

km.set("n", "<esc>", "i", {})
km.set("n", "<leader>nh", ":nohl<CR>", {}) -- clear highlight

km.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
km.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
km.set("n", "<leader>wx", ":close<CR>", { desc = "Close current window" })
