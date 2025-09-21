local lsp_zero = require('lsp-zero')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- Auto format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      if vim.bo.filetype ~= "go" then
        vim.lsp.buf.format({ async = false })
      end
    end
  })

  -- Golang auto-import
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      local client = vim.lsp.get_clients({ bufnr = bufnr })

      for _, c in pairs(client) do
        if c.name == "gopls" and c.supports_method("textDocument/codeAction") then
          local enc = client.offset_encoding or "utf-16"
          local params = vim.lsp.util.make_range_params(vim.api.nvim_get_current_win(), enc)

          params.context = { only = { "source.organizeImports" } }

          local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params)

          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format({ async = false })
        end
      end
    end
  })
end)

require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'gopls',
    'lua_ls',
    'bashls',
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})
