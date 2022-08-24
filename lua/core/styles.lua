----------------------------------------------------------------------------------------------------
-- Styles
----------------------------------------------------------------------------------------------------
-- Consistent store of various UI items to reuse throughout my config

local palette = {
  green = '#98c379',
  dark_green = '#10B981',
  blue = '#82AAFE',
  dark_blue = '#4e88ff',
  bright_blue = '#51afef',
  teal = '#15AABF',
  pale_pink = '#b490c0',
  magenta = '#c678dd',
  pale_red = '#E06C75',
  light_red = '#c43e1f',
  dark_red = '#be5046',
  dark_orange = '#FF922B',
  bright_yellow = '#FAB005',
  light_yellow = '#e5c07b',
  whitesmoke = '#9E9E9E',
  light_gray = '#626262',
  comment_grey = '#5c6370',
  grey = '#3E4556',
}

core.style = {
  border = {
    line = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
    rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
  },
  icons = {
    separators = {
      vert_bottom_half_block = '▄',
      vert_top_half_block = '▀',
    },
    lsp = {
      error = '', -- '✗'
      warn = '',
      warning = '',
      info = '', -- 
      hint = '', -- ⚑
    },
    git = {
      add = '', -- '',
      mod = '',
      remove = '', -- '',
      ignore = '',
      rename = '',
      diff = '',
      repo = '',
      logo = '',
      branch = '',
    },
    documents = {
      file = '',
      files = '',
      folder = '',
      open_folder = '',
    },
    type = {
      array = '',
      number = '',
      object = '',
      null = '[]',
      float = '',
    },
    misc = {
      ellipsis = '…',
      up = '⇡',
      down = '⇣',
      line = 'ℓ', -- ''
      indent = 'Ξ',
      tab = '⇥',
      bug = '', -- 'ﴫ'
      question = '',
      clock = '',
      lock = '',
      circle = '',
      project = '',
      dashboard = '',
      history = '',
      comment = '',
      robot = 'ﮧ',
      lightbulb = '',
      search = '',
      code = '',
      telescope = '',
      gear = '',
      package = '',
      list = '',
      sign_in = '',
      check = '',
      fire = '',
      note = '',
      bookmark = '',
      pencil = '',
      tools = '',
      arrow_right = '',
      caret_right = '',
      chevron_right = '',
      double_chevron_right = '»',
      table = '',
      calendar = '',
      block = '▌',
    },
  },
  -- LSP Kinds come via the LSP spec
  -- @see: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
  lsp = {
    colors = {
      error = palette.pale_red,
      warn = palette.dark_orange,
      hint = palette.bright_blue,
      info = palette.teal,
    },
    highlights = {
      Text = 'String',
      Method = 'TSMethod',
      Function = 'Function',
      Constructor = 'TSConstructor',
      Field = 'TSField',
      Variable = 'TSVariable',
      Class = 'TSStorageClass',
      Interface = 'Constant',
      Module = 'Include',
      Property = 'TSProperty',
      Unit = 'Constant',
      Value = 'Variable',
      Enum = 'Type',
      Keyword = 'Keyword',
      File = 'Directory',
      Reference = 'PreProc',
      Constant = 'Constant',
      Struct = 'Type',
      Snippet = 'Label',
      Event = 'Variable',
      Operator = 'Operator',
      TypeParameter = 'Type',
      Namespace = 'TSNamespace',
      Package = 'Include',
      String = 'String',
      Number = 'Number',
      Boolean = 'Boolean',
      Array = 'StorageClass',
      Object = 'Type',
      Key = 'TSField',
      Null = 'ErrorMsg',
      EnumMember = 'TSField',
    },
    kinds = {
      codicons = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
        Namespace = '?',
        Package = '?',
        String = '?',
        Number = '?',
        Boolean = '?',
        Array = '?',
        Object = '?',
        Key = '?',
        Null = '?',
      },
      nerdfonts = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = '', -- '',
        Variable = '', -- '',
        Class = '', -- '',
        Interface = '',
        Module = '',
        Property = 'ﰠ',
        Unit = '塞',
        Value = '',
        Enum = '',
        Keyword = '', -- '',
        Snippet = '', -- '', '',
        Color = '',
        File = '',
        Reference = '', -- '',
        Folder = '',
        EnumMember = '',
        Constant = '', -- '',
        Struct = '', -- 'פּ',
        Event = '',
        Operator = '',
        TypeParameter = '',
        Namespace = '?',
        Package = '?',
        String = '?',
        Number = '?',
        Boolean = '?',
        Array = '?',
        Object = '?',
        Key = '?',
        Null = '?',
      },
    },
  },
  palette = palette,
}

----------------------------------------------------------------------------------------------------
-- Global style settings
----------------------------------------------------------------------------------------------------
-- Some styles can be tweaked here to apply globally i.e. by setting the current value for that style

-- The current styles for various UI elements
core.style.current = {
  border = core.style.border.line,
  lsp_icons = core.style.lsp.kinds.codicons,
}
