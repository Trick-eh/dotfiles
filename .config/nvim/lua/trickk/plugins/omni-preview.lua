return {
	"sylvanfranklin/omni-preview.nvim",
	dependencies = {
		{ "chomosuke/typst-preview.nvim", lazy = true }, -- typst previewer
		{ "hat0uma/csvview.nvim", lazy = true }, -- csv previewer
		{ "toppair/peek.nvim", lazy = true, build = "deno task --quiet build:fast" }, -- markdown previewer
		{ "hat0uma/csvview.nvim", lazy = true },
	},
	config = function()
		require("omni-preview").setup()
		require("peek").setup({ app = "browser" })
	end,
	keys = {
		{ "<leader>ps", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
		{ "<leader>pf", "<cmd>OmniPreview stop<CR>", desc = "OmniPreview Stop" },
	},
}
