local c = require("sigma.colors")

return {
    DirHiddenFile = { fg = c.commentHighlight },
    DirLicense = { fg = c.module, bold = true },
    DirReadme = { fg = c.stringSpecial },
    DirMovingMark = { link = "DiagnosticError" },
    DirCopyingMark = { link = "DiagnosticInfo" },
}
