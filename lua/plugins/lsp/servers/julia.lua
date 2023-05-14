-- correctly setup lspconfig
return {

  -- extend the lsp tool collection
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "julia-lsp" })
    end,
  },

  -- add julia to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "julia" })
    end,
  },
}
