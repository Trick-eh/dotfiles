return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local triforce = require("triforce.lualine")
        lualine.setup({
            options = {
                theme = "auto",
            },
            sections = {
                lualine_x = {
                    triforce.level,
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        })
    end,
}
