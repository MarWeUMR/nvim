if not mw then
  return
end
local settings, highlight = mw.filetype_settings, mw.highlight
local cmd, fn, api, env, opt_l = vim.cmd, vim.fn, vim.api, vim.env, vim.opt_local

settings {
  checkhealth = {
    opt = { spell = false },
  },

  fzf = {
    function(args)
      -- remove the default terminal mappings
      vim.keymap.del("t", "<esc>", { buffer = args.buf })
      vim.keymap.del("t", "jk", { buffer = args.buf })
    end,
  },
  [{ "gitcommit", "gitrebase" }] = {
    bo = { bufhidden = "delete" },
    opt = {
      list = false,
      spell = true,
      spelllang = "en_gb",
    },
  },

  help = {
    opt = {
      list = false,
      wrap = false,
      spell = true,
      textwidth = 78,
    },
    plugins = {
      ["virt-column"] = function(col)
        if vim.bo.modifiable then
          col.setup_buffer { virtcolumn = "+1" }
        end
      end,
    },
    function(args)
      local opts = { buffer = args.buf }
      -- if this a vim help file create mappings to make navigation easier otherwise enable preferred editing settings
      if vim.startswith(fn.expand "%", env.VIMRUNTIME) or vim.bo.readonly then
        opt_l.spell = false
        api.nvim_create_autocmd("BufWinEnter", { buffer = 0, command = "wincmd L | vertical resize 80" })
        -- https://vim.fandom.com/wiki/Learn_to_use_help
        map("n", "<CR>", "<C-]>", opts)
        map("n", "<BS>", "<C-T>", opts)
      else
        map("n", "<leader>ml", "maGovim:tw=78:ts=8:noet:ft=help:norl:<esc>`a", opts)
      end
    end,
  },
  markdown = {
    opt = {
      spell = true,
    },
    plugins = {
      cmp = function(cmp)
        cmp.setup.filetype("markdown", {
          sources = {
            { name = "dictionary", group_index = 1 },
            { name = "spell", group_index = 1 },
            { name = "emoji", group_index = 1 },
            { name = "buffer", group_index = 2 },
          },
        })
      end,
      ["nvim-surround"] = function(surround)
        surround.buffer_setup {
          surrounds = {
            l = {
              add = function()
                return { { "[" }, { ("](%s)"):format(fn.getreg "*") } }
              end,
            },
          },
        }
      end,
    },
    mappings = {
      { "n", "<localleader>p", "<Plug>MarkdownPreviewToggle", desc = "markdown preview" },
    },
    function()
      vim.b.formatting_disabled = not vim.startswith(fn.expand "%", vim.env.PROJECTS_DIR .. "/personal")
    end,
  },

  netrw = {
    g = {
      netrw_liststyle = 3,
      netrw_banner = 0,
      netrw_browse_split = 0,
      netrw_winsize = 25,
      netrw_altv = 1,
      netrw_fastbrowse = 0,
    },
    bo = { bufhidden = "wipe" },
    mappings = {
      { "n", "q", "<Cmd>q<CR>" },
      { "n", "l", "<CR>" },
      { "n", "h", "<CR>" },
      { "n", "o", "<CR>" },
    },
  },

  qf = {
    opt = {
      wrap = false,
      number = false,
      signcolumn = "yes",
      buflisted = false,
      winfixheight = true,
    },
    mappings = {
      { "n", "dd", mw.list.qf.delete, desc = "delete current quickfix entry" },
      { "v", "d", mw.list.qf.delete, desc = "delete selected quickfix entry" },
      { "n", "H", ":colder<CR>" },
      { "n", "L", ":cnewer<CR>" },
    },
    function()
      -- force quickfix to open beneath all other splits
      cmd.wincmd "J"
      mw.adjust_split_height(3, 10)
    end,
  },
  startuptime = {
    function()
      cmd.wincmd "H"
    end, -- open startup time to the left
  },

  vim = {
    opt = { spell = true },
    bo = { syntax = "off" },
    mappings = {
      {
        "n",
        "<leader>so",
        function()
          cmd.source "%"
          vim.notify("Sourced " .. fn.expand "%")
        end,
      },
    },
    function() -- TODO: if the syntax isn't delayed it still gets enabled
      vim.schedule(function()
        vim.bo.syntax = "off"
      end)
    end,
  },
  [{ "lua", "python", "rust" }] = { opt = { spell = false } },
}
