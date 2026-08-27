local sources = require("statusline.sources")

local function stl_format(name, val)
    return ("%%#StatusLine_%s#%s%%*"):format(name, val)
end

local events, pieces = {}, {}
local components = {
    "  ",
    sources.fileinfo(),
    " ",
    sources.diagnostic(),
    "%=",
    sources.debugger(),
    "%=",
    -- sources.progress(),
    -- "   ",
    sources.filetype(),
    sources.encoding(),
    {
        name = "percent",
        stl = " %P ",
    },
    -- {
    --     name = "linenr",
    --     stl = "%l",
    -- },
    "%l",
    {
        name = "separator",
        stl = ":"
    },
    "%c",
    -- {
    --     name = "colnr",
    --     stl = "%c",
    -- },
    " ",
}

vim.api.nvim_set_hl(0, "StatusLine_fileinfo", { bg = "#0C0C0C", bold = true })
vim.api.nvim_set_hl(0, "StatusLine_separator", { fg = "#686868" })
-- vim.api.nvim_set_hl(0, "StatusLine_linenr", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "StatusLine_colnr", { fg = "#787878" })
vim.api.nvim_set_hl(0, "StatusLine_percent", { fg = "#a1bebf" })
vim.api.nvim_set_hl(0, "StatusLine_dap_status", { link = "DiagnosticWarn" })

vim.iter(ipairs(components)):map(function(key, item)
    if type(item) == "string" then
        table.insert(pieces, item)
    elseif type(item.stl) == "string" then
        table.insert(pieces, stl_format(item.name, item.stl))
    else
        pieces[#pieces + 1] = item.default and stl_format(item.name, item.default) or ""
        for _, event in ipairs({ unpack(item.event or {}) }) do
            events[event] = events[event] or {}
            events[event][#events[event] + 1] = key
        end
    end
    if item.attr and item.name then
        vim.api.nvim_set_hl(0, ("StatusLine_%s"):format(item.name), item.attr)
    end
end):totable()

vim.tbl_map(function(e)
    local tmp = e
    local pattern
    if e:find("User") then
        pattern = vim.split(e, "%s")[2]
        tmp = "User"
    elseif e == "OptionSet" then
        pattern = "modified"
    end
    vim.api.nvim_create_autocmd(tmp, {
        pattern = pattern,
        callback = function(args)
            vim.schedule(function()
                local ok, err = pcall(function()
                    local event = args.event == "User" and ("%s %s"):format(args.event, args.match) or args.event
                    for _, idx in ipairs(events[event]) do
                        pieces[idx] = stl_format(components[idx].name, components[idx].stl(args))
                    end
                    vim.opt.stl = table.concat(pieces)
                end)

                if not ok then
                    vim.notify("[StatusLine] render failed: " .. err, vim.log.levels.ERROR)
                end
            end)
        end,
        desc = "[StatusLine] update",
    })
end, vim.tbl_keys(events))
