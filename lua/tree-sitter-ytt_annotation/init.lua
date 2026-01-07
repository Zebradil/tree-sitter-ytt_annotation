local M = {}

M.setup = function(opts)
	opts = opts or {}
	local install = opts.install ~= false -- Default: true

	local ok, parsers = pcall(require, "nvim-treesitter.parsers")
	if not ok then
		vim.notify("tree-sitter-ytt_annotation: nvim-treesitter not found", vim.log.levels.WARN)
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
	}

	if install then
		local is_ytt_annotation_installed = #vim.api.nvim_get_runtime_file("parser/ytt_annotation.so", false) > 0
		if not is_ytt_annotation_installed then
			vim.cmd("TSInstall ytt_annotation")
		end

		local is_starlark_installed = #vim.api.nvim_get_runtime_file("parser/starlark.so", false) > 0
		if not is_starlark_installed then
			vim.cmd("TSInstall starlark")
		end
	end
end

return M
