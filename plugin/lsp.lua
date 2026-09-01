vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local protocol = vim.lsp.protocol
local ms = protocol.Methods

local api = vim.api

vim.lsp.buf.code_action = require("override.code_action")

local caps = protocol.make_client_capabilities()

-- local border_icons = {
--     { "╭", "FloatBorder" },
--     { "─", "FloatBorder" },
--     { "╮", "FloatBorder" },
--     { "│", "FloatBorder" },
--     { "╯", "FloatBorder" },
--     { "─", "FloatBorder" },
--     { "╰", "FloatBorder" },
--     { "│", "FloatBorder" },
-- }
--
-- override privew func to add borders
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, preview_opts, ...)
--     preview_opts = preview_opts or {}
--     preview_opts.border = preview_opts.border or border_icons
--     return orig_util_open_floating_preview(contents, syntax, preview_opts, ...)
-- end

vim.lsp.config("*", { capabilities = caps })

vim.lsp.enable({
    "clangd",
    "cssls",
    -- "dockerls",
    -- "eslint",
    "gopls",
    "html",
    "jsonls",
    -- "emmylua_ls",
    "lua_ls",
    "ols",
    "neocmake",
    "pyright",
    "ruby_lsp",
    "rust_analyzer",
    "tailwindcss",
    "ts_ls",
    "zls",
})

local lsp_attach_group = vim.api.nvim_create_augroup("sagg0t.LspAttach", { clear = true })
local completion_group = vim.api.nvim_create_augroup("sagg0t.completion", { clear = true })

local kind_icons = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
}

---@param lnum? number
_G.sagg0t_foldtext = function(lnum)
    local chunks = vim.lsp.foldtext(lnum)

    -- for _, chunk in ipairs(chunks) do
    --     if chunk[1] 
    -- end

    return chunks
end

-- vim.lsp.log.set_level(vim.lsp.log.levels.TRACE)

-- vim.lsp.inlay_hint.enable(true)
vim.lsp.linked_editing_range.enable(true)
vim.lsp.document_color.enable(true, nil, { style = "virtual" })
vim.lsp.codelens.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buf = event.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format, { buf = event.buf, desc = "Format document" })

        -- if client:supports_method(ms.textDocument_formatting) then
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = pre_write_group,
        --         buf = event.buf,
        --         callback = function()
        --             vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        --         end
        --     })
        -- end

        if client:supports_method(ms.textDocument_foldingRange) then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            vim.wo[win][0].foldtext = "v:lua.sagg0t_foldtext()"
        end

        if client:supports_method(ms.textDocument_documentHighlight) then
            api.nvim_create_autocmd({ "CursorHold" }, {
                buf = event.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.lsp.buf.document_highlight()
                end,
            })
            api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                buf = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        if client:supports_method(ms.textDocument_completion) then
            vim.lsp.completion.enable(true, event.data.client_id, event.buf, {
                autotrigger = true,
                convert = function(item)
                    local kind = protocol.CompletionItemKind[item.kind] or "unknown"
                    local kind_hl = "@lsp.kind." .. kind:sub(1, 1):lower() .. kind:sub(2)

                    return {
                        kind = " " .. kind_icons[kind] .. "  ",
                        kind_hlgroup = kind_hl,
                        menu = ""
                    }
                end
            })

            local existing_handlers = vim.api.nvim_get_autocmds({
                buf = event.buf,
                event = { "CompleteChanged" },
                group = completion_group,
            })
            if #existing_handlers == 0 then
                vim.api.nvim_create_autocmd("CompleteChanged", {
                    buf = event.buf,
                    group = completion_group,
                    callback = function()
                        local info = vim.fn.complete_info({
                            "selected",
                            "preview_bufnr",
                            "preview_winid",
                        })

                        if info.preview_bufnr and vim.bo[info.preview_bufnr].filetype == "" then
                            vim.bo[info.preview_bufnr].filetype = "markdown"
                            vim.wo[info.preview_winid].conceallevel = 2
                            vim.wo[info.preview_winid].concealcursor = "niv"
                        end

                        -- if info.preview_winid then
                        --     vim.w
                        -- end
                    end,
                })

                vim.api.nvim_create_autocmd("CompleteDone", {
                    buf = event.buf,
                    group = completion_group,
                    desc = "Auto show signature help when compeltion done",
                    callback = function()
                        local item = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
                        if not item then return end

                        if item.kind == 3
                            and item.insertTextFormat == vim.lsp.protocol.InsertTextFormat.Snippet
                            and (item.textEdit ~= nil or item.insertText ~= nil)
                        then
                            vim.schedule(function()
                                if vim.api.nvim_get_mode().mode == "s" then
                                    vim.lsp.buf.signature_help()
                                end
                            end)
                        end
                    end,
                })
            end
        end
    end
})

api.nvim_create_autocmd({ "LspProgress" }, {
    callback = function(evt)
        local params = evt.data.params
        local value = params.value
        local ls = vim.lsp.get_client_by_id(evt.data.client_id)

        local source = "lsp_" .. tostring(evt.data.client_id)

        vim.api.nvim_echo({ { value.message or "done" }, }, false, {
            id = source .. tostring(params.token),
            source = source,
            kind = "progress",
            title = ("(%s) "):format(ls.name) .. value.title,
            status = value.kind ~= "end" and "running" or "success",
            percent = value.percentage,
        })
    end,
})

api.nvim_create_user_command("LspLog", function(opts)
    local logfile = vim.lsp.log.get_filename()

    if opts.args == "clear" then
        local success, error = os.remove(logfile)

        if success then
            vim.notify("LspLog: LSP log file deleted")
        else
            vim.notify(error, vim.log.levels.ERROR)
        end
    elseif opts.args == "" then
        vim.cmd("tabnew " .. logfile)
    else
        vim.notify("LspLog: unknow arg - " .. opts.args)
    end
end, {
    nargs = "?",
    desc = "Opens LSP logfile in a new tab",
    complete = function() return { "clear" } end,
})
