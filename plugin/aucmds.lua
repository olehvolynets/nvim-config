local api = vim.api

api.nvim_create_autocmd({ "TextYankPost", "TextPutPost" }, {
    group = api.nvim_create_augroup("sagg0t.highlight_yank", { clear = true }),
    pattern = "*",
    callback = function()
        vim.hl.hl_op({ higroup = "IncSearch", timeout = 69 })
    end,
})

api.nvim_create_autocmd("BufWritePre", {
    group = api.nvim_create_augroup("sagg0t.remove_trailing_whitespace", { clear = true }),
    pattern = { "rb", "ts", "tsx", "js", "jsx" },
    command = [[%s/\s\+$//e]],
    desc = "removes trailing whitespace"
})

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("sagg0t.big_file", { clear = true }),
    desc = "Disable features in big files",
    pattern = "bigfile",
    callback = function(args)
        vim.schedule(function()
            vim.bo[args.buf].syntax = vim.filetype.match({ buf = args.buf }) or ""
        end)
    end,
})

api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("sagg0t.close_with_q", { clear = true }),
    desc = "Close with <q>",
    pattern = { "git", "help", "man", "qf", "scratch", "directory" },
    callback = function(args)
        vim.keymap.set("n", "q", "<cmd>quit<cr>", { buf = args.buf })
    end,
})

api.nvim_create_autocmd("BufReadPost", {
    group = api.nvim_create_augroup("saggot.goto_last_location", { clear = true }),
    desc = "Go to the last location when opening a buffer",
    callback = function(args)
        local mark = api.nvim_buf_get_mark(args.buf, '"')
        local line_count = api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})

local line_numbers_group = api.nvim_create_augroup("sagg0t.toggle_rel_numbers", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    group = line_numbers_group,
    desc = "Toggle relative line numbers on",
    callback = function()
        if vim.wo.nu and not vim.startswith(api.nvim_get_mode().mode, "i") then
            vim.wo.relativenumber = true
        end
    end,
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
    group = line_numbers_group,
    desc = "Toggle relative line numbers off",
    callback = function(args)
        if vim.wo.nu then
            vim.wo.relativenumber = false
        end

        -- Redraw here to avoid having to first write something for the line numbers to update.
        if args.event == "CmdlineEnter" then
            if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
                vim.cmd.redraw()
            end
        end
    end,
})
