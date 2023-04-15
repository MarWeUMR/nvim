local fn, env, highlight, ui, reqcall = vim.fn, vim.env, mw.highlight, mw.styles, mw.reqcall
local icons, lsp_hls = ui.icons, ui.lsp.highlights
local P = ui.palette

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function(_, opts)
    highlight.plugin("telescope", {
      { TelescopeBorder = { fg = P.grey } },
      { TelescopePromptPrefix = { link = "Statement" } },
      { TelescopeTitle = { inherit = "Normal", bold = true } },
      { TelescopePromptTitle = { fg = { from = "Normal" }, bold = true } },
      { TelescopeResultsTitle = { fg = { from = "Normal" }, bold = true } },
      { TelescopePreviewTitle = { fg = { from = "Normal" }, bold = true } },
    })

    local telescope = require "telescope"
    opts.defaults = {
      mappings = {
        i = {
          ["<esc>"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-i>"] = function()
            mw.telescope("find_files", { no_ignore = true })()
          end,
          ["<C-h>"] = function()
            mw.telescope("find_files", { hidden = true })()
          end,
          ["<C-Down>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          ["<C-z>"] = function(...)
            return require("telescope.actions").to_fuzzy_refine(...)
          end,
          ["<C-l>"] = function(...)
            return require("telescope.actions.layout").cycle_layout_next(...)
          end,
          ["<A-j>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<A-k>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
        },
      },
      layout_strategy = "flex",
      layout_config = {
        width = 0.99,
        height = 0.99,

        flex = {
          flip_columns = 150,
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
      extensions = {
        fzf = { override_generic_sorter = true, fuzzy = true, override_file_sorter = false, case_mode = "smart_case" },
      },
      pickers = {

        live_grep = {
          file_ignore_patterns = { ".git/", "%.svg", "%.lock", "target/" },
          max_results = 2000,
        },
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--color=never" },
          hidden = true,
        },
      },
    }

    --opts.extension_list = {
    --  "themes",
    --  "terms",
    --}

    telescope.setup(opts)

    --for _, ext in ipairs(opts.extensions_list) do
    --  telescope.load_extension(ext)
    --end
  end,
}
