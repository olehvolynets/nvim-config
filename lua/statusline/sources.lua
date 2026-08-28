local M = {}
local fnamemodify = vim.fn.fnamemodify
local fs = vim.fs

local stl_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg or "#000000"

function M.fileinfo()
    return {
        stl = function()
            local path = vim.api.nvim_buf_get_name(0)
            local root = vim.fn.getcwd(-1, -1, -1)
            local rel_path = fs.relpath(root, path) or path
            local dir, file ---@type string, string

            local stat = vim.uv.fs_stat(path) or {}
            if stat.type == "directory" then
                dir = rel_path
                file = ""
            else
                dir = fs.dirname(rel_path) .. "/"
                file = vim.fs.basename(rel_path)
            end

            if dir == "./" then
                dir = ""
            end
            if file == "." then
                file = "[No Name]"
            end

            local path_format = string.format("%%#Directory#%s%%*%s", dir, file)

            return path_format .. " %h%w%m%r"
        end,
        name = "fileinfo",
        attr = {
            bold = true,
            bg = stl_bg,
        },
        event = { "BufEnter" },
    }
end

local ft_alias = {
    cpp = "C++",
    javascript = "JavaScript",
    ["nvim-debugger.breakpoints-widget"] = "DBG Breakpoints",
    ["nvim-debugger.breakpoints-widget.details"] = "DBG Breakpoint details",
    ["nvim-debugger.modules-widget"] = "DBG Modules",
    ["nvim-debugger.threads-widget"] = "DBG Threads",
    ["nvim-debugger.stack-trace-widget"] = "DBG Stack trace",
    ["nvim-debugger.variables-widget"] = "DBG Variables",
    ["nvim-debugger.watch-widget"] = "DBG Watches",
    ["nvim-debugger.watch-widget.info"] = "DBG Watch Info",
    ["nvim-debugger.output-widget"] = "DBG Output",
}

function M.filetype()
    return {
        name = "filetype",
        stl = function()

            local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            local capital = ft:sub(1, 1):upper()
            local pretty_ft = ft_alias[ft] and ft_alias[ft] or capital .. ft:sub(2, #ft)
            local icon, icon_hl_group = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t", ft))

            if icon ~= nil and icon_hl_group ~= nil then
                local hl_name = "StatusLineFT" .. icon_hl_group
                local existing_hl = vim.api.nvim_get_hl(0, { name = hl_name })

                if vim.tbl_isempty(existing_hl) then
                    local icon_hl = vim.api.nvim_get_hl(0, { name = icon_hl_group })
                    local stl_icon_hl = {
                        fg = icon_hl.fg,
                        bg = stl_bg,
                        ctermfg = icon_hl.ctermfg,
                    }

                    vim.api.nvim_set_hl(0, hl_name, stl_icon_hl)
                end

                icon = ("%%#%s#%s%%*"):format(hl_name, icon)
            elseif icon == nil then
                return ""
            end

            return icon .. " " .. pretty_ft
        end,
        event = { "BufEnter", "FileType" },
    }
end

-- local spinner = { "⣶", "⣧", "⣏", "⡟", "⠿", "⢻", "⣹", "⣼" }

function M.lsp()
    return {
        stl = function(args)
            local client = vim.lsp.get_clients({ bufnr = 0 })[1]
            if not client then
                return ""
            end
            local msg = ""
            if args.data and args.data.params then
                local val = args.data.params.value
                if not val.message or val.kind == "end" then
                    msg = ("[%s:%s]"):format(
                        client.name,
                        client.root_dir and fnamemodify(client.root_dir, ":t") or "single"
                    )
                else
                    msg = ("%s %s%s"):format(
                        val.title,
                        (val.message and val.message .. " " or ""),
                        (val.percentage and val.percentage .. "%" or "")
                    )
                end
            elseif args.event == "BufEnter" or args.event == "LspAttach" then
                msg = ("[%s:%s]"):format(
                    client.name,
                    client.root_dir and fnamemodify(client.root_dir, ":t") or "single"
                )
            elseif args.event == "LspDetach" then
                msg = ""
            end
            return "   %-20s" .. msg
        end,
        name = "Lsp",
        event = { "LspProgress", "LspAttach", "LspDetach", "BufEnter" },
    }
end

function M.diagnostic()
    return {
        stl = function()
            return vim.diagnostic.status()
        end,
        event = { "DiagnosticChanged", "BufEnter", "LspAttach" },
    }
end

function M.encoding()
    return {
        stl = ("%s"):format(vim.bo.fileencoding),
        name = "filencode",
        event = { "BufEnter" },
    }
end

function M.debugger()
    return {
        stl = function()
            local ok, dbg = pcall(require, "debugger")
            return ok and dbg.status() or ""
        end,
        name = "debugger",
        event = {
            "User DBGStatus",
        },
    }
end

return M
