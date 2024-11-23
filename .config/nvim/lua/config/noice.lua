require("noice").setup({
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
    },
    signature = {
      enabled = false,
      auto_open = {
        enabled = false,
        trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
        luasnip = false, -- Will open signature help when jumping to Luasnip insert nodes
        throttle = 50,   -- Debounce lsp signature help request by 50ms
      },
    }
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})
