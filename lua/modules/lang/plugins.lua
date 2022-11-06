local plugin = require('core.pack').register_plugin
local conf = require('modules.lang.config')

plugin({
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    run = ':TSUpdate',
    after = 'telescope.nvim',
    commit = "58f61e563fadd1788052586f4d6869a99022df3c",
    config = conf.nvim_treesitter,
    })

plugin({ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' })
