local M = {}

M.setup = function()
	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if not ok then
		return
	end

	local parser_config = parsers.get_parser_configs()

	---@diagnostic disable-next-line: inject-field
	parser_config.ytt_annotation = {
		install_info = {
			url = "https://github.com/zebradil/tree-sitter-ytt_annotation",
			branch = "main",
			files = { "src/parser.c" },
		},
		filetype = "ytt_annotation",
	}
end

return M
