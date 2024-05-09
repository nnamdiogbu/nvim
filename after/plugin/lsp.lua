local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
   ['<C-[>'] = cmp.mapping.select_prev_item(cmp_select),
   ['<C-]>'] = cmp.mapping.select_next_item(cmp_select),
   ['<C-p>'] = cmp.mapping.confirm({select = true}),
   ['<C-Space>'] = cmp.mapping.complete(),
   ['<Esc>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
            vim.api.nvim_input("<C-e><Esc>")
        else
            fallback()
        end
    end, { 'i', 's' }),})

lsp.setup_nvim_cmp({
mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<C-x>", function() vim.lsp.buf.signature_help() end, opts)


end)
lsp.setup()

