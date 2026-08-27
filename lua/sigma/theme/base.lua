local c = require("sigma.colors")

return {
    ColorColumn = { bg = c.overlay.selection },
    Conceal = { link = "Comment" },
    Cursor = { bg = c.white },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    CursorLine = { bg = c.invisible },
    CursorColumn = { link = "CursorLine" },

    Directory = { fg = c.proc },

    Added = { bg = c.git.add },
    Changed = { bg = c.git.change },
    Removed = { bg = c.git.delete },

    DiffAdd = { link = "Added" },
    DiffChange = { link = "Changed" },
    DiffDelete = { link = "Removed" },
    DiffText = { fg = c.fg },

    EndOfBuffer = { fg = c.invisible },
    TermCursor = { link = "Cursor" },
    TermCursorNC = { link = "Cursor" },

    OkMsg = { fg = c.severity.ok },
    ErrorMsg = { fg = c.severity.error },
    WarningMsg = { fg = c.severity.warning },

    -- No idea where this comes from, but some groups in "log" ft
    --      are linked to this one.
    LogGreen = { fg = c.severity.ok },

    -- WinSeparator = { fg = c.invisible, bg = c.bg },
    WinSeparator = { fg = c.overlay.fg },
    Folded = { fg = c.comment },
    FoldColumn = { fg = c.overlay.fg, bg = c.overlay.bg },
    SignColumn = { fg = c.overlay.fg, bg = c.overlay.bg, },
    LineNr = { fg = c.overlay.fg, bg = c.overlay.bg },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    CursorLineNr = { fg = c.overlay.accent, bg = c.overlay.bg },
    CursorLineFold = { link = "FoldColumn" },
    CursorLineSign = { link = "SignColumn" },
    -- MatchParen = { fg = c.keyword, bold = true, underline = true },
    MatchParen = { fg = c.bg, bg = c.fg },
    ModeMsg = { fg = c.fg, bold = true },
    MsgArea = { fg = c.fg, bg = c.overlay.bg },
    MsgSeparator = { fg = c.overlay.bg, bg = c.overlay.bg },
    MoreMsg = { fg = c.stringSpecial, bg = c.overlay.bg },
    NonText = { fg = c.invisible },
    -- Normal = { fg = c.fg, bg = c.bg },
    Normal = { fg = c.fg, bg = c.none },
    NormalNC = { link = "Normal" },

    NormalFloat = { bg = c.overlay.bg },
    FloatBorder = { fg = c.invisible, bg = c.overlay.bg },
    FloatTitle = { fg = c.module, bg = c.overlay.bg },
    FloatFooter = { link = "FloatTitle" },

    Pmenu = { bg = c.overlay.bg },
    PmenuSel = { bg = c.overlay.selection },
    PmenuKind = { fg = c.comment },
    PmenuKindSel = { fg = c.comment, bg = c.overlay.selection },
    PmenuExtra = { fg = c.fg },
    PmenuExtraSel = { fg = c.fg, bg = c.overlay.selection },
    PmenuSbar = { bg = c.overlay.bg },
    PmenuThumb = { bg = c.overlay.accentDark },
    PmenuMatch = { fg = c.type, bold = true },

    Question = { link = "Comment" },

    QuickFixLine = { bold = true },

    Search = { fg = c.bg, bg = c.search, bold = true },
    CurSearch = { fg = c.bg, bg = c.replace, bold = true },
    IncSearch = { link = "Search" },
    Substitute = { fg = c.bg, bg = c.keyword, bold = true },

    SpecialKey = { fg = c.invisible },
    SpellBad = { sp = c.severity.error, undercurl = true },
    SpellCap = { sp = c.severity.warning, undercurl = true },
    SpellLocal = { sp = c.severity.info, undercurl = true },
    SpellRare = { sp = c.severity.hint, undercurl = true },

    StatusLine = { fg = c.fg, bg = c.overlay.bg },
    StatusLineNC = { link = "StatusLine" },

    TabLine = { fg = c.overlay.fg, bg = c.overlay.bg },
    TabLineFill = { bg = c.overlay.bg },
    TabLineSel = { fg = c.fg, bg = c.overlay.accentDark },

    Title = { fg = c.module },

    Visual = { bg = c.selection },
    VisualNOS = { bg = c.selection },

    Whitespace = { fg = c.invisible },
    WildMenu = { fg = c.fg },
    WinBar = { link = "TabLine" },
    WinBarNC = { link = "WinBar" },
    Scrollbar = { fg = c.overlay.accentDark },
    Menu = { link = "UNSET" },    -- Mostly GUI only
    Tooltip = { link = "UNSET" }, -- Mostly GUI only

    -- :h syntax.txt:184
    Comment = { fg = c.comment, italic = true },

    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.stringSpecial },
    Number = { fg = c.number },
    Float = { link = "Number" },
    Boolean = { fg = c.boolean },

    Identifier = { fg = c.fg },
    Function = { fg = c.proc },

    Statement = { fg = c.keyword },
    Keyword = { link = "Statement" },
    Conditional = { fg = c.keyword, bold = true },
    Repeat = { fg = c.keyword, bold = true },
    Label = { fg = c.keyword, underline = true },
    Operator = { fg = c.operator },
    Exception = { link = "Statement" },

    PreProc = { fg = c.number },
    Include = { fg = c.number, bold = true },
    Define = { link = "PreProc" },
    Macro = { link = "PreProc" },
    PreCondit = { link = "PreProc" },

    Type = { fg = c.type },
    StorageClass = { fg = c.keyword, italic = true },
    Structure = { fg = c.module },
    Typedef = { link = "Type" },

    Special = { fg = c.stringSpecial },
    SpecialChar = { fg = c.stringSpecial },
    Tag = { fg = c.tag },
    Delimiter = { link = "Operator" },
    SpecialComment = { fg = c.comment, bold = true },
    Debug = { fg = c.keyword, italic = true, underline = true },

    Underlined = { underline = true },
    Bold = { bold = true },

    Ignore = { link = "Comment" },

    Error = { fg = c.severity.error },
    Todo = { fg = c.severity.info },

    NvimInternalError = { fg = "#0000ff", bg = "#ff0000" },
}
