local theme = {}

theme.colors = require("sigma.colors")

local uncategorised = {
    UNSET = {
        fg = "#0000FF",
        bg = "#FF0000",
        bold = true,
    }
}

theme.groups = vim.tbl_extend("force", uncategorised,
    require("sigma.theme.base"),
    require("sigma.theme.dir"),
    require("sigma.theme.lang_overrides"),
    require("sigma.theme.treesitter"),
    require("sigma.theme.lsp"),
    require("sigma.theme.lsp_kind"),
    require("sigma.theme.dap"),
    require("sigma.theme.diagnostic"),
    require("sigma.theme.picker"),
    -- require("sigma.theme.ibl"),
    require("sigma.theme.neotest"))

return theme
