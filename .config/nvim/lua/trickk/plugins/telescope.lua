return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        path_display = {"smart"},
        mappings = {
          i = {
           ["<C-k>"] = actions.move_selection_previous,
           ["<C-j>"] = actions.move_selection_next,
           ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })
    telescope.load_extension("fzf")
    local km = vim.keymap
       km.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files in cwd" })
       km.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files" })
       km.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find string in cwd" })
       km.set("n", "<leader>fc", ":Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
  end,
}
