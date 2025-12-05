return {
    "xiyaowong/transparent.nvim",
    config = function()
        vim.keymap.set("n", "<leader><leader><leader>", ":TransparentToggle<CR>")
    end,
}
