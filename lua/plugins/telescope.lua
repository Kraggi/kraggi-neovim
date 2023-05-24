local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
-- vim.keymap.set('n', '<Tab>', builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>*", builtin.grep_string, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { noremap = true, silent = true })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { noremap = true, silent = true })

-- Search by selected text
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	text = text:gsub("[%(%)%{%}$]", "\\%0")
	if #text > 0 then
		return text
	else
		return ""
	end
end

function vim.findInFuncConsOrThis()
	vim.cmd('noau normal! "vy"')
	local text = "(function|const|this)." .. vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local tb = require("telescope.builtin")

-- Find selected word
keymap("v", "<leader>fw", function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)

-- Find selected word and check if it declaration with const, function, this
keymap("v", "<leader>ft", function()
	local text = vim.findInFuncConsOrThis()
	tb.live_grep({ default_text = text })
end, opts)
