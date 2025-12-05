return {
  "rmagatti/auto-session",
  config = function ()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop"},
    })
    local km = vim.keymap
    km.set("n", "<leader>sr", ":SessionRestore<CR>", { desc = "Restore session for cwd" })
    km.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "Save session" })
  end,
}
