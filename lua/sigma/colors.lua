local u = require("sigma.util")
COLORU = u

local colors = require("sigma.palette.v3")

colors.none = "NONE"
colors.white = "#ffffff"
colors.black = "#000000"

colors.severity = {
    -- error = u.darken("#f92672", 0.7),
    error = "#B52156",
    -- warning = u.lighten("#ed722e", 0.8),
    warning = "#EF8D51",
    -- info = u.darken("#00dfff", 0.7),
    info = "#07A3B9",
    -- hint = u.darken("#d4d8c0", 0.8),
    hint = "#AEB19E",
    ok = "#44b273",
}

colors.severity.bg = {
    error = u.darken(colors.severity.error, 0.1),
    warning = u.darken(colors.severity.warning, 0.1),
    info = u.darken(colors.severity.info, 0.1),
    hint = u.darken(colors.severity.hint, 0.1),
    ok = u.darken(colors.severity.ok, 0.1),
}

colors.git = {
    add = "#266d6a",
    change = "#536c93",
    delete = "#b2555b",
    conflict = "#bb7a61",
}

return colors
