local api = vim.api
local augroup = api.nvim_create_augroup("sagg0t.image", { clear = true })

api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
-- api.nvim_create_autocmd({ "WinNew" }, {
    group = augroup,
    pattern = "*.png",
    callback = function(ev)
        if not vim.b[ev.buf]._img_id then
            vim.b[ev.buf]._img_id = {}
        end

        local path = api.nvim_buf_get_name(ev.buf)
        if not vim.uv.fs_stat(path) then return end

        local w = math.min(api.nvim_win_get_width(0), 80)
        local id = vim.ui.img.set(vim.fn.readblob(path), { row = 1, col = 1, width = w })

        local wid = api.nvim_get_current_win()
        vim.b[ev.buf]._img_id[wid] = id
    end
})

api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*.png",
    callback = function(ev)
        local wid = api.nvim_get_current_win()

        local id = vim.b[ev.buf]._img_id[wid]
        if not id then return end

        vim.ui.img.del(id)
    end
})
