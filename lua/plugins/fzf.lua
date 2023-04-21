local akinsho = require("util.akinsho")

local reqcall = akinsho.reqcall
-- local icons = ui.icons

local fzf_lua = reqcall("fzf-lua")

------------------------------------------------------------------------------------------------------------------------
-- FZF-LUA HELPERS
------------------------------------------------------------------------------------------------------------------------
local file_picker = function(cwd)
  fzf_lua.files({ cwd = cwd })
end

local function git_files_cwd_aware(opts)
  opts = opts or {}
  local fzf = require("fzf-lua")
  -- git_root() will warn us if we're not inside a git repo
  -- so we don't have to add another warning here, if
  -- you want to avoid the error message change it to:
  -- local git_root = fzf_lua.path.git_root(opts, true)
  local git_root = fzf.path.git_root(opts)
  if not git_root then
    return fzf.files(opts)
  end
  local relative = fzf.path.relative(vim.loop.cwd(), git_root)
  opts.fzf_opts = { ["--query"] = git_root ~= relative and relative or nil }
  return fzf.git_files(opts)
end

local function dropdown(opts, ...)
  opts = opts or {}
  opts.winopts = opts.winopts or {}

  return vim.tbl_deep_extend("force", {
    -- prompt = icons.misc.arrow_right .. " ",
    fzf_opts = { ["--layout"] = "reverse" },
    winopts = {
      title_pos = opts.winopts.title and "center" or nil,
      height = 0.70,
      width = 0.45,
      row = 0.1,
      preview = { hidden = "hidden", layout = "vertical", vertical = "up:50%" },
    },
  }, opts, ...)
end

local function cursor_dropdown(opts)
  return dropdown({
    winopts = {
      row = 1,
      relative = "cursor",
      height = 0.33,
      width = 0.25,
    },
  }, opts)
end

local function live_grep(opts)
  opts = opts or {}
  opts.prompt = "rg> "
  opts.fzf_opts = { ["--delimiter"] = ":" }
  -- setup default actions for edit, quickfix, etc
  opts.actions = fzf_lua.defaults.actions.files
  -- see preview overview for more info on previewers
  opts.preview = "python3 -m rich.markdown -c ~/obsidian-vault/{1}"
  opts.fn_transform = function(x)
    return fzf_lua.make_entry.file(x, opts)
  end
  return fzf_lua.fzf_live(function(search_input_pattern)
    return "rg -- " .. vim.fn.shellescape(search_input_pattern or "")
  end, opts)
end

_G.fzf = { dropdown = dropdown, cursor_dropdown = cursor_dropdown }

return {

  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {

    {
      "<leader>fss",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "document symbols",
    },
    {
      "<leader>fws",
      function()
        require("fzf-lua").lsp_live_workspace_symbols()
      end,
      desc = "workspace symbols",
    },

    {
      "<leader>gc",
      fzf_lua.git_commits,
      desc = "commits",
    },

    {
      "<leader>gs",
      fzf_lua.git_status,
      desc = "status",
    },
    {
      "<leader>gh",
      function()
        require("fzf-lua").lsp_finder()
      end,
      desc = "lsp finder",
    },

    {
      "<leader>bgc",
      function()
        require("fzf-lua").git_bcommits()
      end,
      desc = "buffer commits",
    },
    {
      "<leader>on",
      function()
        live_grep({ cwd = "~/obsidian-vault" })
      end,
      desc = "search within obsidian notes",
    },
    {
      "<leader>oN",
      function()
        require("fzf-lua").fzf_exec("rg --files", {
          cwd = "~/obsidian-vault",
          preview = "python3 -m rich.markdown -c {}",
          actions = require("fzf-lua").defaults.actions.files,
        })
      end,
      desc = "search obsidian notes",
    },
  },
  config = function()
    local lsp_kind = require("lspkind")

    local function title(str, icon, icon_hl)
      return { { " " }, { (icon or ""), icon_hl }, { " " }, { str, "Bold" }, { " " } }
    end

    require("fzf-lua").setup({
      "telescope",
      winopts = {
        preview = {
          hidden = "nohidden",
          vertical = "up:75%",
          horizontal = "right:75%",
          layout = "vertical",
          flip_columns = 150,
          default = "bat",
        },

        height = 0.9,
        width = 0.9,
      },
      git = {
        files = dropdown({
          prompt = " Project Files: ",
          path_shorten = false, -- this doesn't use any clever strategy unlike telescope so is somewhat useless
        }),
        branches = dropdown({
          prompt = " Branches: ",
        }),
        status = {
          prompt = " Git status: ",
          preview_pager = "delta --diff-so-fancy --line-numbers --side-by-side --width=$FZF_PREVIEW_COLUMNS",
        },
        bcommits = {
          prompt = " Buffer commits: ",
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
        },
        commits = {
          prompt = " Git commits: ",
          preview_pager = "delta --diff-so-fancy --line-numbers --side-by-side --width=$FZF_PREVIEW_COLUMNS",
        },
      },
      keymap = {
        fzf = {
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["alt-w"] = "toggle-preview-wrap",
          ["alt-p"] = "toggle-preview",
          ["alt-j"] = "preview-page-down",
          ["alt-k"] = "preview-page-up",
        },
      },
    })

    require("fzf-lua").register_ui_select(dropdown({ winopts = { height = 0.33, width = 0.25 } }))
  end,
}
