return {

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_formatter_opts = {
        relative_time = true,
      }
      opts.current_line_blame_opts = {
        delay = 50,
      }
      opts.count_chars = {
        "⒈",
        "⒉",
        "⒊",
        "⒋",
        "⒌",
        "⒍",
        "⒎",
        "⒏",
        "⒐",
        "⒑",
        "⒒",
        "⒓",
        "⒔",
        "⒕",
        "⒖",
        "⒗",
        "⒘",
        "⒙",
        "⒚",
        "⒛",
      }
      opts.update_debounce = 50
      opts._extmark_signs = true
      opts._threaded_diff = true
      opts.word_diff = false

      opts.on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "<Leader>1", gs.prev_hunk, "Next Hunk")
        map("n", "<Leader>2", gs.next_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end
    end,
  },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({
        default_args = {
          DiffviewFileHistory = { "%" },
        },
        hooks = {
          diff_buf_read = function()
            vim.wo.wrap = false
            vim.wo.list = false
            vim.wo.colorcolumn = ""
          end,
        },
        diff_binaries = false, -- Show diffs for binaries
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        watch_index = true, -- Update views and index buffers when the git index changes.
        icons = { -- Only applies when use_icons is true.
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        enhanced_diff_hl = true,
        keymaps = {
          view = { q = "<Cmd>DiffviewClose<CR>" },
          file_panel = { q = "<Cmd>DiffviewClose<CR>" },
          file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
        },
      })
    end,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
}
