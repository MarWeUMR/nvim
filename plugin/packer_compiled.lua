-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/marcusweber/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/marcusweber/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/marcusweber/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/marcusweber/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/marcusweber/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FTerm.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/FTerm.nvim",
    url = "https://github.com/numToStr/FTerm.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["copilot-cmp"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fcopilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\nø\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\17key_bindings\tview\1\0\1\6q\27<Cmd>DiffviewClose<CR>\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\1\21enhanced_diff_hl\2\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["doom-one.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/doom-one.nvim",
    url = "https://github.com/NTBBloodbath/doom-one.nvim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["flit.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/flit.nvim",
    url = "https://github.com/ggandor/flit.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n¢\3\0\0\t\0\28\0(6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\14\0005\4\a\0004\5\3\0005\6\5\0005\a\4\0=\a\6\6>\6\1\5=\5\b\0044\5\3\0005\6\f\0005\a\t\0005\b\n\0=\b\v\a=\a\6\6>\6\1\5=\5\r\4=\4\15\3B\0\3\0016\0\0\0'\2\3\0B\0\2\0029\0\16\0005\2\26\0005\3\18\0005\4\17\0=\4\19\0035\4\21\0005\5\20\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3=\3\27\2B\0\2\1K\0\1\0\22excluded_argnames\1\0\0\vusages\blua\1\5\0\0\tself\buse\14use_rocks\6_\ago\1\0\0\1\2\0\0\6_\17declarations\1\0\0\1\4\0\0\buse\14use_rocks\6_\nsetup\ntheme\1\0\0\fhorizon\1\0\0\15foreground\1\0\1\tfrom\vNormal\1\0\1\vitalic\2\6*\1\0\0\vHlargs\1\0\0\1\0\2\vitalic\2\15foreground\f#A5D6FF\vhlargs\vplugin\20core.highlights\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["horizon.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/horizon.nvim",
    url = "https://github.com/LunarVim/horizon.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["leap.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp-inlayhints.nvim"] = {
    config = { "\27LJ\2\nﬁ\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\16inlay_hints\1\0\0\15type_hints\1\0\2\23remove_colon_start\2\vprefix\b=> \20parameter_hints\1\0\1\vprefix\bÔûî\1\0\2\14highlight\fComment\21labels_separator\n ‚èê \nsetup\19lsp-inlayhints\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/lsp-inlayhints.nvim",
    url = "https://github.com/lvimuser/lsp-inlayhints.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\n„\1\0\0\5\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\b\0006\4\4\0009\4\5\0049\4\6\0049\4\a\4=\4\a\3=\3\t\2B\0\2\1K\0\1\0\17handler_opts\1\0\0\vborder\fcurrent\nstyle\tcore\1\0\6\21auto_close_after\3\15\ffix_pos\1\15toggle_key\n<C-K>\25select_signature_key\n<M-N>\tbind\2\16hint_enable\1\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["material.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/material.nvim",
    url = "https://github.com/marko-cerovac/material.nvim"
  },
  neogit = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  neon = {
    config = { "\27LJ\2\nõ\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0K\0\1\0\21neon_transparent\25neon_italic_function\24neon_italic_keyword\tdoom\15neon_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/neon",
    url = "https://github.com/rafamadriz/neon"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  nvim = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nn\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\2\bRGB\1\tmode\15background\1\5\0\0\blua\bvim\nkitty\tconf\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-juliana"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-juliana",
    url = "https://github.com/kaiuri/nvim-juliana"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nÍ\2\0\0\a\0\17\0\0286\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0004\4\4\0005\5\5\0005\6\4\0=\6\6\5>\5\1\0045\5\b\0005\6\a\0=\6\t\5>\5\2\0045\5\v\0005\6\n\0=\6\f\5>\5\3\4B\1\3\0016\1\0\0'\3\3\0B\1\2\0029\1\r\0015\3\14\0005\4\15\0=\4\16\3B\1\2\1K\0\1\0\14separator\1\3\0\0\b‚îÄ\18ContextBorder\1\0\2\24multiline_threshold\3\4\tmode\ftopline\nsetup TreesitterContextLineNumber\1\0\0\1\0\1\finherit\vLineNr\22TreesitterContext\1\0\0\1\0\1\finherit\vNormal\18ContextBorder\1\0\0\1\0\1\tlink\bDim\23treesitter-context\vplugin\20core.highlights\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedarkpro.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
    url = "https://github.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["satellite.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14satellite\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/satellite.nvim",
    url = "https://github.com/lewis6991/satellite.nvim"
  },
  shadotheme = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/shadotheme",
    url = "https://github.com/Shadorain/shadotheme"
  },
  ["space-nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/space-nvim",
    url = "https://github.com/Th3Whit3Wolf/space-nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n\27\0\0\3\2\0\0\4-\0\0\0-\2\1\0B\0\2\1K\0\1\0\0\0\0¿N\1\1\4\1\5\0\n6\1\0\0009\1\1\0019\1\2\1B\1\1\0016\1\0\0009\1\3\0013\3\4\0B\1\2\0012\0\0ÄK\0\1\0\0¿\0\rschedule\15stopinsert\bcmd\bvim\20\1\1\2\0\1\0\0033\1\0\0002\0\0ÄL\1\2\0\0.\0\0\2\0\3\0\0056\0\0\0009\0\1\0009\0\2\0B\0\1\1K\0\1\0\15stopinsert\bcmd\bvimb\0\3\b\0\4\1\0169\3\0\0009\3\1\3\21\3\3\0)\4\4\0006\5\2\0009\5\3\5\25\a\0\2B\5\2\2!\6\4\5\3\3\6\0X\6\3Ä \6\4\3\14\0\6\0X\a\1Ä\18\6\5\0L\6\2\0\nfloor\tmath\fresults\vfinder\4<\0\1\a\0\5\0\b5\1\3\0\18\4\0\0009\2\0\0'\5\1\0'\6\2\0B\2\4\2=\2\4\1L\1\2\0\vprompt\1\0\0\a.*\a%s\tgsubº\1\0\0\6\1\t\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\n¿\25file_ignore_patterns\1\4\0\0\f.git/.*\14dotbot/.*\19zsh/plugins/.*\bcwd\vconfig\fstdpath\afn\bvim\1\0\1\17prompt_title\20~ nvim config ~\15find_files≥\1\0\1\a\1\a\0\0165\1\0\0009\2\1\0'\3\2\0&\2\3\2>\2\a\1-\2\0\0\15\0\2\0X\3\aÄ6\2\3\0009\2\4\2\18\4\1\0005\5\5\0009\6\6\0>\6\2\5B\2\3\1L\1\2\0\1¿\17current_file\1\2\0\0\a--\16list_extend\bvim\a^!\nvalue\1\a\0\0\bgit\a-c\21core.pager=delta\a-c\29delta.side-by-side=false\tdiff∆\1\1\2\b\0\t\1\0216\2\0\0'\4\1\0B\2\2\0029\3\2\0025\5\4\0003\6\3\0=\6\5\5B\3\2\2\14\0\0\0X\4\1Ä4\0\0\0004\4\3\0>\3\1\0049\5\a\0029\5\b\5\18\a\0\0B\5\2\0?\5\0\0=\4\6\0002\0\0ÄL\0\2\0\bnew\23git_commit_message\14previewer\16get_command\1\0\0\0\27new_termopen_previewer\25telescope.previewers\frequire\5ÄÄ¿ô\0043\0\1\6\2\1\0\a-\1\0\0009\1\0\1-\3\1\0\18\5\0\0B\3\2\0A\1\0\1K\0\1\0\n¿\f¿\16git_commits8\0\1\a\2\1\0\b-\1\0\0009\1\0\1-\3\1\0\18\5\0\0+\6\2\0B\3\3\0A\1\0\1K\0\1\0\n¿\f¿\17git_bcommitsd\0\0\4\1\6\0\t-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3=\3\5\2B\0\2\1K\0\1\0\n¿\bcwd\rdotfiles\6g\bvim\1\0\1\17prompt_title\rdotfiles\15find_filesT\0\1\5\1\3\0\f6\1\0\0-\3\0\0009\3\1\3\18\4\0\0B\1\3\2\14\0\1\0X\1\4Ä-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\n¿\15find_files\14git_files\npcall<\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\n¿\1\0\1\23include_extensions\2\fbuiltin$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\15find_files!\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\fbuffers#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\14live_grep}\0\0\5\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\3\0006\2\4\0009\2\1\0029\2\5\0025\4\6\0B\2\2\0A\0\0\1K\0\1\0\1\0\1\14previewer\1\rdropdown\tcore\rfrecency\15extensions\14telescope\frequire[\0\0\4\1\5\0\n-\0\0\0009\0\0\0009\0\1\0009\0\1\0006\2\2\0009\2\3\0029\2\4\2B\2\1\0A\0\0\1K\0\1\0\1¿\rdropdown\14telescope\tcore\vnotify\15extensionsj\0\0\4\0\6\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\3\0006\2\4\0009\2\1\0029\2\5\2B\2\1\0A\0\0\1K\0\1\0\rdropdown\tcore\fluasnip\15extensions\14telescope\frequireΩ\1\0\0\v\3\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2-\1\0\0009\1\3\0015\3\a\0-\4\1\0'\6\4\0-\a\2\0009\a\5\a\18\t\0\0'\n\6\0B\a\3\0A\4\1\2=\4\b\3=\0\t\3B\1\2\1K\0\1\0\n¿\a¿\b¿\bcwd\17prompt_title\1\0\0\t:~:.\16fnamemodify\17Searching %s\15find_files\15buffer_dir\20telescope.utils\frequireî\1\0\0\6\1\b\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2'\4\6\0&\3\4\3=\3\a\2B\0\2\1K\0\1\0\n¿\bcwd\22/site/pack/packer\tdata\fstdpath\afn\bvim\1\0\1\17prompt_title\22Installed plugins\15find_filesÕ'\1\0!\0ç\2\0≠\0036\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\6\0009\5\a\0059\5\b\0056\6\6\0009\6\a\0069\6\t\0066\a\n\0009\a\v\a6\b\f\0009\b\r\b6\t\6\0009\t\14\t'\v\15\0004\f\3\0005\r\16\0>\r\1\fB\t\3\0019\t\17\0'\v\2\0005\fH\0005\r7\0004\14\n\0005\15\23\0005\16\19\0009\17\18\6=\17\20\0165\17\21\0=\17\22\16=\16\24\15>\15\1\0145\15\27\0005\16\25\0009\17\18\6=\17\20\0165\17\26\0=\17\22\16=\16\28\15>\15\2\0145\15\31\0005\16\29\0009\17\18\6=\17\20\0165\17\30\0=\17\22\16=\16 \15>\15\3\0145\15#\0005\16!\0009\17\18\6=\17\22\0165\17\"\0=\17\20\16=\16$\15>\15\4\0145\15&\0005\16%\0=\16'\15>\15\5\0145\15)\0005\16(\0=\16*\15>\15\6\0145\15-\0005\16+\0009\17\18\6=\17,\16=\16.\15>\15\a\0145\0150\0005\16/\0=\0161\15>\15\b\0145\0155\0005\0163\0005\0172\0=\17\22\0165\0174\0=\17\20\16=\0166\15>\15\t\14=\0148\r4\14\5\0005\15:\0005\0169\0009\17\18\6=\17\20\16=\16\24\15>\15\1\0145\15=\0005\16;\0005\17<\0=\17,\16=\16>\15>\15\2\0145\15A\0005\16?\0009\17\18\6=\17\22\0165\17@\0=\17\20\16=\16$\15>\15\3\0145\15C\0005\16B\0=\16'\15>\15\4\14=\14D\r4\14\3\0005\15F\0005\16E\0=\16>\15>\15\1\14=\14G\r=\rI\fB\t\3\0013\tJ\0009\nK\0015\fé\0005\rO\0005\14N\0006\15\f\0009\15L\0159\15M\15=\15M\14=\14P\r5\14R\0005\15Q\0=\15S\0145\15T\0=\15U\0145\15V\0=\15W\14=\14X\r9\14Y\0059\14\2\14'\15Z\0&\14\15\14=\14[\r9\14Y\0059\14\\\14'\15Z\0&\14\15\14=\14]\r5\14^\0=\14_\r5\14w\0005\15a\0009\16`\2=\16b\0153\16c\0=\16d\0159\16e\2=\16f\0159\16g\2=\16h\0159\16i\2=\16j\0159\16k\2=\16l\0159\16m\3=\16n\0159\16o\3=\16p\0159\16q\2=\16r\0159\16s\2=\16t\15\18\16\t\0009\18u\2B\16\2\2=\16v\15=\15x\0145\15y\0009\16`\2=\16b\15=\15z\14=\14{\r5\14|\0=\14}\r5\14~\0=\14\127\r5\14É\0006\15\f\0009\15\r\0159\15Ä\15'\17Å\0B\15\2\2'\16Ç\0&\15\16\15=\15Ñ\14=\14Ö\r5\14á\0005\15Ü\0=\15à\0145\15â\0003\16ä\0=\16ã\15=\15å\14=\14ç\r=\rè\f5\rë\0005\14ê\0=\14í\r5\14ì\0005\15î\0=\15ï\0145\15ó\0006\16\f\0009\16L\0169\16ñ\16=\16ò\0156\16\f\0009\16L\0169\16ô\16=\16ö\15=\15õ\14=\14ú\r=\rù\f5\r£\0006\14\6\0009\14\2\0149\14û\0145\16ü\0005\17°\0005\18†\0=\18x\0175\18¢\0=\18z\17=\17{\16B\14\2\2=\14§\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14•\r6\14\6\0009\14\2\0149\14¶\0145\16®\0005\17ß\0=\17}\0163\17©\0=\17™\16B\14\2\2=\14´\r6\14\6\0009\14\2\0149\14û\0145\16¨\0B\14\2\2=\14≠\r5\14Æ\0=\14Ø\r5\14∞\0=\14±\r6\14\6\0009\14\2\0149\14û\0145\16≥\0005\17≤\0=\17ç\16B\14\2\2=\14¥\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14µ\r5\14∏\0005\15∑\0005\16∂\0=\16à\15=\15ç\14=\14π\r5\14º\0005\15ª\0005\16∫\0=\16à\15=\15ç\14=\14Ω\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14æ\r=\rø\fB\n\2\0016\n\0\0'\f¿\0B\n\2\0023\v¡\0003\f¬\0003\r√\0003\14ƒ\0003\15≈\0003\16∆\0003\17«\0003\18»\0003\19…\0003\20 \0003\21À\0003\22Ã\0003\23Õ\0003\24Œ\0003\25œ\0009\26–\0045\28“\0005\29—\0>\16\1\29=\29”\0285\29‘\0005\30’\0>\17\1\30=\30÷\0295\30◊\0009\31≠\n>\31\1\30=\30ÿ\0295\30Ÿ\0>\22\1\30=\30z\0295\30⁄\0005\31‹\0009 €\n> \1\31=\31›\0305\31ﬂ\0009 ﬁ\n> \1\31=\31÷\0305\31·\0009 ‡\n> \1\31=\31‚\30=\30„\0295\30‰\0005\31Ê\0009 Â\n> \1\31=\31Á\0305\31È\0009 Ë\n> \1\31=\31Í\0305\31Ï\0009 Î\n> \1\31=\31Ì\30=\30Ó\0295\30Ô\0>\23\1\30=\30\0295\30Ò\0>\25\1\30=\30Ú\0295\30Ù\0009\31Û\n>\31\1\30=\30ı\0295\30˜\0009\31ˆ\n>\31\1\30=\30¯\0295\30˘\0>\18\1\30=\30˙\0295\30˚\0>\24\1\30=\30\r\0295\30¸\0>\21\1\30=\30›\0295\30˝\0005\31˛\0009 µ\n> \1\31=\31ÿ\0305\31ˇ\0>\r\1\31' \0\1<\31 \0305\31\1\1>\14\1\31' \2\1<\31 \30'\31\3\1<\30\31\0295\30\4\1>\19\1\30=\30‚\0295\30\5\1>\20\1\30=\30Ì\0295\30\6\1>\15\1\30=\30Í\0295\30\a\1>\v\1\30'\31\0\1<\30\31\29'\30\b\1<\29\30\28B\26\2\0016\26\f\0'\27\t\0018\26\27\26'\27\n\0018\26\27\26'\28\v\0015\29\f\1B\26\3\0012\0\0ÄK\0\1\0\1\0\2\rmodeline\1\fpattern\28TelescopeConfigComplete\tUser\23nvim_exec_autocmds\bapi\14<leader>f\1\3\0\0\0\16nvim config\1\3\0\0\0\rdotfiles\1\3\0\0\0\14live grep\1\3\0\0\0\fbuffers\6g\6B\1\3\0\0\0\19buffer commits\6c\1\3\0\0\0\fcommits\1\3\0\0\0\rbranches\1\0\1\tname\t+git\1\3\0\0\0 Most (f)recently used files\1\3\0\0\0\20find near files\6f\1\3\0\0\0\15find files\6?\1\3\0\0\0\thelp\14help_tags\6r\1\3\0\0\0\23resume last picker\vresume\6p\1\3\0\0\0\fplugins\6L\1\3\0\0\0 luasnip: available snippets\6l\6s\1\3\0\0\0!telescope: workspace symbols\"lsp_dynamic_workspace_symbols\6d\1\3\0\0\0 telescope: document symbols\25lsp_document_symbols\6e\1\3\0\0\0%telescope: workspace diagnostics\16diagnostics\1\0\1\tname\t+lsp\6v\6o\1\3\0\0\0\foptions\16vim_options\1\3\0\0\0\17autocommands\17autocommands\6h\1\3\0\0\0\15highlights\15highlights\1\0\1\tname\t+vim\1\3\0\0\0\18notifications\6b\1\3\0\0\0\30current buffer fuzzy find\6a\1\3\0\0\0\rbuiltins\1\0\1\tname\15+telescope\n<c-p>\1\0\0\1\3\0\0\0\26telescope: find files\rregister\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\22telescope.builtin\fpickers\rreloader\16git_commits\1\0\0\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\17git_bcommits\1\0\0\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\17git_branches\fkeymaps\1\0\0\1\0\2\vheight\3\18\nwidth\4\0ÄÄÄˇ\3\15find_files\1\0\1\vhidden\2\16colorscheme\1\0\1\19enable_preview\2\30current_buffer_fuzzy_find\1\0\2\14previewer\1\17shorten_path\1\14live_grep\23on_input_filter_cb\0\1\0\1\16max_results\3–\15\1\4\0\0\n.git/\n%.svg\v%.lock\bivy\roldfiles\fbuffers\1\0\0\1\0\1\n<c-x>\18delete_buffer\1\0\0\1\0\1\n<c-x>\18delete_buffer\1\0\5\14previewer\1\26ignore_current_buffer\2\21show_all_buffers\2\18sort_lastused\2\rsort_mru\2\rdropdown\15extensions\rfrecency\15workspaces\fproject\17PROJECTS_DIR\tconf\1\0\0\rDOTFILES\20ignore_patterns\1\5\0\0\f*.git/*\f*/tmp/*\20*node_modules/*\14*vendor/*\1\0\2\22default_workspace\bLSP\19show_unindexed\1\bfzf\1\0\0\1\0\2\25override_file_sorter\2\28override_generic_sorter\2\rdefaults\1\0\0\18layout_config\vcursor\vheight\0\1\0\1\nwidth\4ö≥ÊÃ\tô≥Ê˛\3\15horizontal\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\fhistory\tpath\1\0\0\31/telescope_history.sqlite3\tdata\fstdpath\17path_display\1\2\0\0\rtruncate\25file_ignore_patterns\1\n\0\0\n%.jpg\v%.jpeg\n%.png\n%.otf\n%.ttf\15%.DS_Store\v^.git/\19^node_modules/\20^site-packages/\rmappings\6n\1\0\0\6i\1\0\0\t<CR>\19select_default\n<Tab>\21toggle_selection\n<c-/>\14which_key\n<c-l>\22cycle_layout_next\n<c-e>\19toggle_preview\n<c-k>\23cycle_history_prev\n<c-j>\23cycle_history_next\n<c-s>\22select_horizontal\n<esc>\nclose\n<c-c>\0\n<C-w>\1\0\0\28send_selected_to_qflist\22cycle_layout_list\1\6\0\0\tflex\15horizontal\rvertical\16bottom_pane\vcenter\20selection_caret\18chevron_right\18prompt_prefix\6 \tmisc\16borderchars\fpreview\1\t\0\0\b‚ñî\b‚ñï\b‚ñÅ\b‚ñè\tü≠Ω\tü≠æ\tü≠ø\tü≠º\fresults\1\t\0\0\b‚ñî\b‚ñï\b‚ñÅ\b‚ñè\tü≠Ω\tü≠æ\tü≠ø\tü≠º\vprompt\1\0\0\1\t\0\0\6 \b‚ñï\b‚ñÅ\b‚ñè\b‚ñè\b‚ñï\tü≠ø\tü≠º\fset_env\1\0\3\20layout_strategy\tflex\rwinblend\3\5\26dynamic_preview_title\2\1\0\0\tTERM\benv\nsetup\0\ntheme\1\0\0\rdoom-one\1\0\0\1\0\1\tlink\nTitle\fhorizon\1\0\0\1\0\1\tlink\24PanelDarkBackground\1\0\0\1\0\1\tfrom\24PanelDarkBackground\1\0\0\22TelescopeMatching\1\0\0\1\0\2\tattr\afg\tfrom\rVariable\1\0\1\tbold\1\1\0\0\1\0\2\afg\afg\tbold\2\6*\1\0\0\28TelescopeSelectionCaret\1\0\0\1\0\1\tfrom\23TelescopeSelection\1\0\0\1\0\1\tfrom\15Identifier\19TelescopeTitle\1\0\0\1\0\2\finherit\vNormal\tbold\2\20TelescopeBorder\1\0\0\15foreground\1\0\0\26TelescopePromptPrefix\1\0\0\1\0\1\tlink\14Statement\27TelescopePreviewNormal\1\0\0\1\0\1\tlink\20PanelBackground\27TelescopePreviewBorder\1\0\0\1\0\1\tfrom\20PanelBackground\1\0\0\26TelescopePreviewTitle\1\0\0\1\0\1\tfrom\vNormal\1\0\1\tbold\2\26TelescopeResultsTitle\1\0\0\1\0\1\tfrom\vNormal\1\0\1\tbold\2\25TelescopePromptTitle\1\0\0\afg\1\0\1\tfrom\14Directory\abg\1\0\1\tbold\2\tgrey\vplugin\1\0\3\fcommand\20setlocal number\nevent\tUser\fpattern\29TelescopePreviewerLoaded\22TelescopePreviews\faugroup\afn\bvim\vformat\vstring\fpalette\nicons\nstyle\tcore\14which-key\29telescope.actions.layout\22telescope.actions\14telescope\20core.highlights\frequire\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\nÈ\1\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0K\0\1\0\1\0\2\thint\vorange\nerror\f#ff0000\22tokyonight_colors\1\5\0\0\aqf\15vista_kind\rterminal\vpacker\24tokyonight_sidebars tokyonight_italic_functions\nnight\21tokyonight_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/marcusweber/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^copilot_cmp"] = "copilot-cmp"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: lsp-inlayhints.nvim
time([[Config for lsp-inlayhints.nvim]], true)
try_loadstring("\27LJ\2\nﬁ\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\16inlay_hints\1\0\0\15type_hints\1\0\2\23remove_colon_start\2\vprefix\b=> \20parameter_hints\1\0\1\vprefix\bÔûî\1\0\2\14highlight\fComment\21labels_separator\n ‚èê \nsetup\19lsp-inlayhints\frequire\0", "config", "lsp-inlayhints.nvim")
time([[Config for lsp-inlayhints.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nÍ\2\0\0\a\0\17\0\0286\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0004\4\4\0005\5\5\0005\6\4\0=\6\6\5>\5\1\0045\5\b\0005\6\a\0=\6\t\5>\5\2\0045\5\v\0005\6\n\0=\6\f\5>\5\3\4B\1\3\0016\1\0\0'\3\3\0B\1\2\0029\1\r\0015\3\14\0005\4\15\0=\4\16\3B\1\2\1K\0\1\0\14separator\1\3\0\0\b‚îÄ\18ContextBorder\1\0\2\24multiline_threshold\3\4\tmode\ftopline\nsetup TreesitterContextLineNumber\1\0\0\1\0\1\finherit\vLineNr\22TreesitterContext\1\0\0\1\0\1\finherit\vNormal\18ContextBorder\1\0\0\1\0\1\tlink\bDim\23treesitter-context\vplugin\20core.highlights\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\n„\1\0\0\5\0\n\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\b\0006\4\4\0009\4\5\0049\4\6\0049\4\a\4=\4\a\3=\3\t\2B\0\2\1K\0\1\0\17handler_opts\1\0\0\vborder\fcurrent\nstyle\tcore\1\0\6\21auto_close_after\3\15\ffix_pos\1\15toggle_key\n<C-K>\25select_signature_key\n<M-N>\tbind\2\16hint_enable\1\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nn\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\2\bRGB\1\tmode\15background\1\5\0\0\blua\bvim\nkitty\tconf\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\nÈ\1\0\0\2\0\t\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0K\0\1\0\1\0\2\thint\vorange\nerror\f#ff0000\22tokyonight_colors\1\5\0\0\aqf\15vista_kind\rterminal\vpacker\24tokyonight_sidebars tokyonight_italic_functions\nnight\21tokyonight_style\6g\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: neon
time([[Config for neon]], true)
try_loadstring("\27LJ\2\nõ\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\4\0006\0\0\0009\0\1\0+\1\2\0=\1\5\0006\0\0\0009\0\1\0+\1\2\0=\1\6\0K\0\1\0\21neon_transparent\25neon_italic_function\24neon_italic_keyword\tdoom\15neon_style\6g\bvim\0", "config", "neon")
time([[Config for neon]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n¢\3\0\0\t\0\28\0(6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\14\0005\4\a\0004\5\3\0005\6\5\0005\a\4\0=\a\6\6>\6\1\5=\5\b\0044\5\3\0005\6\f\0005\a\t\0005\b\n\0=\b\v\a=\a\6\6>\6\1\5=\5\r\4=\4\15\3B\0\3\0016\0\0\0'\2\3\0B\0\2\0029\0\16\0005\2\26\0005\3\18\0005\4\17\0=\4\19\0035\4\21\0005\5\20\0=\5\22\0045\5\23\0=\5\24\4=\4\25\3=\3\27\2B\0\2\1K\0\1\0\22excluded_argnames\1\0\0\vusages\blua\1\5\0\0\tself\buse\14use_rocks\6_\ago\1\0\0\1\2\0\0\6_\17declarations\1\0\0\1\4\0\0\buse\14use_rocks\6_\nsetup\ntheme\1\0\0\fhorizon\1\0\0\15foreground\1\0\1\tfrom\vNormal\1\0\1\vitalic\2\6*\1\0\0\vHlargs\1\0\0\1\0\2\vitalic\2\15foreground\f#A5D6FF\vhlargs\vplugin\20core.highlights\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n\27\0\0\3\2\0\0\4-\0\0\0-\2\1\0B\0\2\1K\0\1\0\0\0\0¿N\1\1\4\1\5\0\n6\1\0\0009\1\1\0019\1\2\1B\1\1\0016\1\0\0009\1\3\0013\3\4\0B\1\2\0012\0\0ÄK\0\1\0\0¿\0\rschedule\15stopinsert\bcmd\bvim\20\1\1\2\0\1\0\0033\1\0\0002\0\0ÄL\1\2\0\0.\0\0\2\0\3\0\0056\0\0\0009\0\1\0009\0\2\0B\0\1\1K\0\1\0\15stopinsert\bcmd\bvimb\0\3\b\0\4\1\0169\3\0\0009\3\1\3\21\3\3\0)\4\4\0006\5\2\0009\5\3\5\25\a\0\2B\5\2\2!\6\4\5\3\3\6\0X\6\3Ä \6\4\3\14\0\6\0X\a\1Ä\18\6\5\0L\6\2\0\nfloor\tmath\fresults\vfinder\4<\0\1\a\0\5\0\b5\1\3\0\18\4\0\0009\2\0\0'\5\1\0'\6\2\0B\2\4\2=\2\4\1L\1\2\0\vprompt\1\0\0\a.*\a%s\tgsubº\1\0\0\6\1\t\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\n¿\25file_ignore_patterns\1\4\0\0\f.git/.*\14dotbot/.*\19zsh/plugins/.*\bcwd\vconfig\fstdpath\afn\bvim\1\0\1\17prompt_title\20~ nvim config ~\15find_files≥\1\0\1\a\1\a\0\0165\1\0\0009\2\1\0'\3\2\0&\2\3\2>\2\a\1-\2\0\0\15\0\2\0X\3\aÄ6\2\3\0009\2\4\2\18\4\1\0005\5\5\0009\6\6\0>\6\2\5B\2\3\1L\1\2\0\1¿\17current_file\1\2\0\0\a--\16list_extend\bvim\a^!\nvalue\1\a\0\0\bgit\a-c\21core.pager=delta\a-c\29delta.side-by-side=false\tdiff∆\1\1\2\b\0\t\1\0216\2\0\0'\4\1\0B\2\2\0029\3\2\0025\5\4\0003\6\3\0=\6\5\5B\3\2\2\14\0\0\0X\4\1Ä4\0\0\0004\4\3\0>\3\1\0049\5\a\0029\5\b\5\18\a\0\0B\5\2\0?\5\0\0=\4\6\0002\0\0ÄL\0\2\0\bnew\23git_commit_message\14previewer\16get_command\1\0\0\0\27new_termopen_previewer\25telescope.previewers\frequire\5ÄÄ¿ô\0043\0\1\6\2\1\0\a-\1\0\0009\1\0\1-\3\1\0\18\5\0\0B\3\2\0A\1\0\1K\0\1\0\n¿\f¿\16git_commits8\0\1\a\2\1\0\b-\1\0\0009\1\0\1-\3\1\0\18\5\0\0+\6\2\0B\3\3\0A\1\0\1K\0\1\0\n¿\f¿\17git_bcommitsd\0\0\4\1\6\0\t-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3=\3\5\2B\0\2\1K\0\1\0\n¿\bcwd\rdotfiles\6g\bvim\1\0\1\17prompt_title\rdotfiles\15find_filesT\0\1\5\1\3\0\f6\1\0\0-\3\0\0009\3\1\3\18\4\0\0B\1\3\2\14\0\1\0X\1\4Ä-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\n¿\15find_files\14git_files\npcall<\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\n¿\1\0\1\23include_extensions\2\fbuiltin$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\15find_files!\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\fbuffers#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\n¿\14live_grep}\0\0\5\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\3\0006\2\4\0009\2\1\0029\2\5\0025\4\6\0B\2\2\0A\0\0\1K\0\1\0\1\0\1\14previewer\1\rdropdown\tcore\rfrecency\15extensions\14telescope\frequire[\0\0\4\1\5\0\n-\0\0\0009\0\0\0009\0\1\0009\0\1\0006\2\2\0009\2\3\0029\2\4\2B\2\1\0A\0\0\1K\0\1\0\1¿\rdropdown\14telescope\tcore\vnotify\15extensionsj\0\0\4\0\6\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\3\0006\2\4\0009\2\1\0029\2\5\2B\2\1\0A\0\0\1K\0\1\0\rdropdown\tcore\fluasnip\15extensions\14telescope\frequireΩ\1\0\0\v\3\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2-\1\0\0009\1\3\0015\3\a\0-\4\1\0'\6\4\0-\a\2\0009\a\5\a\18\t\0\0'\n\6\0B\a\3\0A\4\1\2=\4\b\3=\0\t\3B\1\2\1K\0\1\0\n¿\a¿\b¿\bcwd\17prompt_title\1\0\0\t:~:.\16fnamemodify\17Searching %s\15find_files\15buffer_dir\20telescope.utils\frequireî\1\0\0\6\1\b\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2'\4\6\0&\3\4\3=\3\a\2B\0\2\1K\0\1\0\n¿\bcwd\22/site/pack/packer\tdata\fstdpath\afn\bvim\1\0\1\17prompt_title\22Installed plugins\15find_filesÕ'\1\0!\0ç\2\0≠\0036\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\6\0009\5\a\0059\5\b\0056\6\6\0009\6\a\0069\6\t\0066\a\n\0009\a\v\a6\b\f\0009\b\r\b6\t\6\0009\t\14\t'\v\15\0004\f\3\0005\r\16\0>\r\1\fB\t\3\0019\t\17\0'\v\2\0005\fH\0005\r7\0004\14\n\0005\15\23\0005\16\19\0009\17\18\6=\17\20\0165\17\21\0=\17\22\16=\16\24\15>\15\1\0145\15\27\0005\16\25\0009\17\18\6=\17\20\0165\17\26\0=\17\22\16=\16\28\15>\15\2\0145\15\31\0005\16\29\0009\17\18\6=\17\20\0165\17\30\0=\17\22\16=\16 \15>\15\3\0145\15#\0005\16!\0009\17\18\6=\17\22\0165\17\"\0=\17\20\16=\16$\15>\15\4\0145\15&\0005\16%\0=\16'\15>\15\5\0145\15)\0005\16(\0=\16*\15>\15\6\0145\15-\0005\16+\0009\17\18\6=\17,\16=\16.\15>\15\a\0145\0150\0005\16/\0=\0161\15>\15\b\0145\0155\0005\0163\0005\0172\0=\17\22\0165\0174\0=\17\20\16=\0166\15>\15\t\14=\0148\r4\14\5\0005\15:\0005\0169\0009\17\18\6=\17\20\16=\16\24\15>\15\1\0145\15=\0005\16;\0005\17<\0=\17,\16=\16>\15>\15\2\0145\15A\0005\16?\0009\17\18\6=\17\22\0165\17@\0=\17\20\16=\16$\15>\15\3\0145\15C\0005\16B\0=\16'\15>\15\4\14=\14D\r4\14\3\0005\15F\0005\16E\0=\16>\15>\15\1\14=\14G\r=\rI\fB\t\3\0013\tJ\0009\nK\0015\fé\0005\rO\0005\14N\0006\15\f\0009\15L\0159\15M\15=\15M\14=\14P\r5\14R\0005\15Q\0=\15S\0145\15T\0=\15U\0145\15V\0=\15W\14=\14X\r9\14Y\0059\14\2\14'\15Z\0&\14\15\14=\14[\r9\14Y\0059\14\\\14'\15Z\0&\14\15\14=\14]\r5\14^\0=\14_\r5\14w\0005\15a\0009\16`\2=\16b\0153\16c\0=\16d\0159\16e\2=\16f\0159\16g\2=\16h\0159\16i\2=\16j\0159\16k\2=\16l\0159\16m\3=\16n\0159\16o\3=\16p\0159\16q\2=\16r\0159\16s\2=\16t\15\18\16\t\0009\18u\2B\16\2\2=\16v\15=\15x\0145\15y\0009\16`\2=\16b\15=\15z\14=\14{\r5\14|\0=\14}\r5\14~\0=\14\127\r5\14É\0006\15\f\0009\15\r\0159\15Ä\15'\17Å\0B\15\2\2'\16Ç\0&\15\16\15=\15Ñ\14=\14Ö\r5\14á\0005\15Ü\0=\15à\0145\15â\0003\16ä\0=\16ã\15=\15å\14=\14ç\r=\rè\f5\rë\0005\14ê\0=\14í\r5\14ì\0005\15î\0=\15ï\0145\15ó\0006\16\f\0009\16L\0169\16ñ\16=\16ò\0156\16\f\0009\16L\0169\16ô\16=\16ö\15=\15õ\14=\14ú\r=\rù\f5\r£\0006\14\6\0009\14\2\0149\14û\0145\16ü\0005\17°\0005\18†\0=\18x\0175\18¢\0=\18z\17=\17{\16B\14\2\2=\14§\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14•\r6\14\6\0009\14\2\0149\14¶\0145\16®\0005\17ß\0=\17}\0163\17©\0=\17™\16B\14\2\2=\14´\r6\14\6\0009\14\2\0149\14û\0145\16¨\0B\14\2\2=\14≠\r5\14Æ\0=\14Ø\r5\14∞\0=\14±\r6\14\6\0009\14\2\0149\14û\0145\16≥\0005\17≤\0=\17ç\16B\14\2\2=\14¥\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14µ\r5\14∏\0005\15∑\0005\16∂\0=\16à\15=\15ç\14=\14π\r5\14º\0005\15ª\0005\16∫\0=\16à\15=\15ç\14=\14Ω\r6\14\6\0009\14\2\0149\14û\14B\14\1\2=\14æ\r=\rø\fB\n\2\0016\n\0\0'\f¿\0B\n\2\0023\v¡\0003\f¬\0003\r√\0003\14ƒ\0003\15≈\0003\16∆\0003\17«\0003\18»\0003\19…\0003\20 \0003\21À\0003\22Ã\0003\23Õ\0003\24Œ\0003\25œ\0009\26–\0045\28“\0005\29—\0>\16\1\29=\29”\0285\29‘\0005\30’\0>\17\1\30=\30÷\0295\30◊\0009\31≠\n>\31\1\30=\30ÿ\0295\30Ÿ\0>\22\1\30=\30z\0295\30⁄\0005\31‹\0009 €\n> \1\31=\31›\0305\31ﬂ\0009 ﬁ\n> \1\31=\31÷\0305\31·\0009 ‡\n> \1\31=\31‚\30=\30„\0295\30‰\0005\31Ê\0009 Â\n> \1\31=\31Á\0305\31È\0009 Ë\n> \1\31=\31Í\0305\31Ï\0009 Î\n> \1\31=\31Ì\30=\30Ó\0295\30Ô\0>\23\1\30=\30\0295\30Ò\0>\25\1\30=\30Ú\0295\30Ù\0009\31Û\n>\31\1\30=\30ı\0295\30˜\0009\31ˆ\n>\31\1\30=\30¯\0295\30˘\0>\18\1\30=\30˙\0295\30˚\0>\24\1\30=\30\r\0295\30¸\0>\21\1\30=\30›\0295\30˝\0005\31˛\0009 µ\n> \1\31=\31ÿ\0305\31ˇ\0>\r\1\31' \0\1<\31 \0305\31\1\1>\14\1\31' \2\1<\31 \30'\31\3\1<\30\31\0295\30\4\1>\19\1\30=\30‚\0295\30\5\1>\20\1\30=\30Ì\0295\30\6\1>\15\1\30=\30Í\0295\30\a\1>\v\1\30'\31\0\1<\30\31\29'\30\b\1<\29\30\28B\26\2\0016\26\f\0'\27\t\0018\26\27\26'\27\n\0018\26\27\26'\28\v\0015\29\f\1B\26\3\0012\0\0ÄK\0\1\0\1\0\2\rmodeline\1\fpattern\28TelescopeConfigComplete\tUser\23nvim_exec_autocmds\bapi\14<leader>f\1\3\0\0\0\16nvim config\1\3\0\0\0\rdotfiles\1\3\0\0\0\14live grep\1\3\0\0\0\fbuffers\6g\6B\1\3\0\0\0\19buffer commits\6c\1\3\0\0\0\fcommits\1\3\0\0\0\rbranches\1\0\1\tname\t+git\1\3\0\0\0 Most (f)recently used files\1\3\0\0\0\20find near files\6f\1\3\0\0\0\15find files\6?\1\3\0\0\0\thelp\14help_tags\6r\1\3\0\0\0\23resume last picker\vresume\6p\1\3\0\0\0\fplugins\6L\1\3\0\0\0 luasnip: available snippets\6l\6s\1\3\0\0\0!telescope: workspace symbols\"lsp_dynamic_workspace_symbols\6d\1\3\0\0\0 telescope: document symbols\25lsp_document_symbols\6e\1\3\0\0\0%telescope: workspace diagnostics\16diagnostics\1\0\1\tname\t+lsp\6v\6o\1\3\0\0\0\foptions\16vim_options\1\3\0\0\0\17autocommands\17autocommands\6h\1\3\0\0\0\15highlights\15highlights\1\0\1\tname\t+vim\1\3\0\0\0\18notifications\6b\1\3\0\0\0\30current buffer fuzzy find\6a\1\3\0\0\0\rbuiltins\1\0\1\tname\15+telescope\n<c-p>\1\0\0\1\3\0\0\0\26telescope: find files\rregister\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\22telescope.builtin\fpickers\rreloader\16git_commits\1\0\0\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\17git_bcommits\1\0\0\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\17git_branches\fkeymaps\1\0\0\1\0\2\vheight\3\18\nwidth\4\0ÄÄÄˇ\3\15find_files\1\0\1\vhidden\2\16colorscheme\1\0\1\19enable_preview\2\30current_buffer_fuzzy_find\1\0\2\14previewer\1\17shorten_path\1\14live_grep\23on_input_filter_cb\0\1\0\1\16max_results\3–\15\1\4\0\0\n.git/\n%.svg\v%.lock\bivy\roldfiles\fbuffers\1\0\0\1\0\1\n<c-x>\18delete_buffer\1\0\0\1\0\1\n<c-x>\18delete_buffer\1\0\5\14previewer\1\26ignore_current_buffer\2\21show_all_buffers\2\18sort_lastused\2\rsort_mru\2\rdropdown\15extensions\rfrecency\15workspaces\fproject\17PROJECTS_DIR\tconf\1\0\0\rDOTFILES\20ignore_patterns\1\5\0\0\f*.git/*\f*/tmp/*\20*node_modules/*\14*vendor/*\1\0\2\22default_workspace\bLSP\19show_unindexed\1\bfzf\1\0\0\1\0\2\25override_file_sorter\2\28override_generic_sorter\2\rdefaults\1\0\0\18layout_config\vcursor\vheight\0\1\0\1\nwidth\4ö≥ÊÃ\tô≥Ê˛\3\15horizontal\1\0\0\1\0\1\18preview_width\4ö≥ÊÃ\tô≥Üˇ\3\fhistory\tpath\1\0\0\31/telescope_history.sqlite3\tdata\fstdpath\17path_display\1\2\0\0\rtruncate\25file_ignore_patterns\1\n\0\0\n%.jpg\v%.jpeg\n%.png\n%.otf\n%.ttf\15%.DS_Store\v^.git/\19^node_modules/\20^site-packages/\rmappings\6n\1\0\0\6i\1\0\0\t<CR>\19select_default\n<Tab>\21toggle_selection\n<c-/>\14which_key\n<c-l>\22cycle_layout_next\n<c-e>\19toggle_preview\n<c-k>\23cycle_history_prev\n<c-j>\23cycle_history_next\n<c-s>\22select_horizontal\n<esc>\nclose\n<c-c>\0\n<C-w>\1\0\0\28send_selected_to_qflist\22cycle_layout_list\1\6\0\0\tflex\15horizontal\rvertical\16bottom_pane\vcenter\20selection_caret\18chevron_right\18prompt_prefix\6 \tmisc\16borderchars\fpreview\1\t\0\0\b‚ñî\b‚ñï\b‚ñÅ\b‚ñè\tü≠Ω\tü≠æ\tü≠ø\tü≠º\fresults\1\t\0\0\b‚ñî\b‚ñï\b‚ñÅ\b‚ñè\tü≠Ω\tü≠æ\tü≠ø\tü≠º\vprompt\1\0\0\1\t\0\0\6 \b‚ñï\b‚ñÅ\b‚ñè\b‚ñè\b‚ñï\tü≠ø\tü≠º\fset_env\1\0\3\20layout_strategy\tflex\rwinblend\3\5\26dynamic_preview_title\2\1\0\0\tTERM\benv\nsetup\0\ntheme\1\0\0\rdoom-one\1\0\0\1\0\1\tlink\nTitle\fhorizon\1\0\0\1\0\1\tlink\24PanelDarkBackground\1\0\0\1\0\1\tfrom\24PanelDarkBackground\1\0\0\22TelescopeMatching\1\0\0\1\0\2\tattr\afg\tfrom\rVariable\1\0\1\tbold\1\1\0\0\1\0\2\afg\afg\tbold\2\6*\1\0\0\28TelescopeSelectionCaret\1\0\0\1\0\1\tfrom\23TelescopeSelection\1\0\0\1\0\1\tfrom\15Identifier\19TelescopeTitle\1\0\0\1\0\2\finherit\vNormal\tbold\2\20TelescopeBorder\1\0\0\15foreground\1\0\0\26TelescopePromptPrefix\1\0\0\1\0\1\tlink\14Statement\27TelescopePreviewNormal\1\0\0\1\0\1\tlink\20PanelBackground\27TelescopePreviewBorder\1\0\0\1\0\1\tfrom\20PanelBackground\1\0\0\26TelescopePreviewTitle\1\0\0\1\0\1\tfrom\vNormal\1\0\1\tbold\2\26TelescopeResultsTitle\1\0\0\1\0\1\tfrom\vNormal\1\0\1\tbold\2\25TelescopePromptTitle\1\0\0\afg\1\0\1\tfrom\14Directory\abg\1\0\1\tbold\2\tgrey\vplugin\1\0\3\fcommand\20setlocal number\nevent\tUser\fpattern\29TelescopePreviewerLoaded\22TelescopePreviews\faugroup\afn\bvim\vformat\vstring\fpalette\nicons\nstyle\tcore\14which-key\29telescope.actions.layout\22telescope.actions\14telescope\20core.highlights\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\nø\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\17key_bindings\tview\1\0\1\6q\27<Cmd>DiffviewClose<CR>\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\1\21enhanced_diff_hl\2\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: satellite.nvim
time([[Config for satellite.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14satellite\frequire\0", "config", "satellite.nvim")
time([[Config for satellite.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-cmp ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSHighlightCapturesUnderCursor lua require("packer.load")({'playground'}, { cmd = "TSHighlightCapturesUnderCursor", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'copilot.lua'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
