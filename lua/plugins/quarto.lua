return {

  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      {
        "jmbuhr/otter.nvim",
        dev = false,
        config = function()
          require("otter.config").setup({})
        end,
      },

      -- optional
      -- { 'quarto-dev/quarto-vim',
      --   ft = 'quarto',
      --   dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
      --   -- note: needs additional syntax highlighting enabled for markdown
      --   --       in `nvim-treesitter`
      --   config = function()
      -- conceal can be tricky because both
      -- the treesitter highlighting and the
      -- regex vim syntax files can define conceals
      --
      -- -- see `:h conceallevel`
      -- vim.opt.conceallevel = 1
      --
      -- -- disable conceal in markdown/quarto
      -- vim.g['pandoc#syntax#conceal#use'] = false
      --
      -- -- embeds are already handled by treesitter injectons
      -- vim.g['pandoc#syntax#codeblocks#embeds#use'] = false
      -- vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
      --
      -- -- but allow some types of conceal in math regions:
      -- -- see `:h g:tex_conceal`
      -- vim.g['tex_conceal'] = 'gm'
      -- --   end
      -- },
    },
    config = function()
      require("quarto").setup({
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "all",
          languages = { "python", "julia", "bash", "lua", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
          rename = "<leader>lR",
          references = "gr",
        },
      })
    end,
  },
}
