local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'sumneko_lua',
  'rust_analyzer',
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 's'}),
  ["<CR>"] = cmp.mapping.confirm { select = false },
  ['<Tab'] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
      elseif luasnip.expand() then
          luasnip.expand()
      elseif luasnip.expand_or_jump() then
          luasnip.expand_or_jump()
      elseif has_words_before() then
          cmp.complete()
      else
          fallback()
      end
  end, {'i', 's'}),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
      else
          fallback()
      end
  end, {'i', 's'}),
})


lsp.setup_nvim_cmp({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    mapping = cmp_mappings,
    -- window = {
        --     comletion = cmp.config.window.bordered({border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'}),
        --     documentation = cmp.config.window.bordered({border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'}),
        -- },
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  -- local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {})
  -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, {})
  -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
