local THEME = os.getenv("THEME")

if THEME == "rose-pine" then
    return {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose-pine",
        config = function()
            require("rose-pine").setup()
            vim.cmd("colorscheme rose-pine")
        end
    }
elseif THEME == "miasma" then
    return {
        "xero/miasma.nvim",
        priority = 1000,
        name = "miasma",
        config = function()
            vim.cmd("colorscheme miasma")
        end
    }
end
