return {

  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        enhanced_diff_hl = true,

        file_panel = {
          listing_style = "list",
          win_config = {
            width = 40,
          },
        },
        keymaps = {
          view = {
            { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
            { "n", "<down>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "<up>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          },
          file_history_panel = {
            { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "<cr>", actions.goto_file, { desc = "Open the file in a new split in the previous tabpage" } },
            { "n", "-", actions.toggle_files, { desc = "Toggle the file panel" } },
            { "n", "<space>", actions.cycle_layout, { desc = "Cycle available layouts" } },
          },
          file_panel = {
            { "n", "q", ":DiffviewClose<cr>", { desc = "Close Panel" } },
            { "n", "<space>", actions.cycle_layout, { desc = "Cycle available layouts" } },
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry." } },
            { "n", "S", actions.stage_all, { desc = "Stage all entries." } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all entries." } },
            { "n", "X", actions.restore_entry, { desc = "Restore entry to the state on the left side." } },
            { "n", "<cr>", actions.goto_file, { desc = "Open the file in a new split in the previous tabpage" } },
            { "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
            { "n", "R", actions.refresh_files, { desc = "Update stats and entries in the file list." } },
            { "n", "-", actions.toggle_files, { desc = "Toggle the file panel" } },
            { "n", "[x", actions.prev_conflict, { desc = "Go to the previous conflict" } },
            { "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
          },
        },
      })
    end,
  },
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
      -- opts._extmark_signs = true
    end,
  },
}
