local api, fs, uv = vim.api, vim.fs, vim.uv

local augroup = api.nvim_create_augroup("sagg0t.dir")
local ns = api.nvim_create_namespace("sagg0t.dir")

local hidden_visible = false
local HIDE_TOGGLE_MSG_ID = "sagg0t.dir.hidden_toggle"

api.nvim_create_autocmd("User", {
    group = augroup,
    pattern = "DirReadPost",
    callback = function(args)
        local fnames = vim.api.nvim_buf_get_lines(args.buf, 0, -1, true)

        local visible_items = {} ---@type string[]
        for _, name in ipairs(fnames) do
            if hidden_visible or (not vim.startswith(name, ".")) then
                table.insert(visible_items, name)
            end
        end

        api.nvim_buf_set_lines(args.buf, 0, -1, true, visible_items)
    end,
    desc = "control displayed items",
})

---@param buf integer
---@return string root
---@return string abs_path
---@return string path
local function get_paths(buf)
    local root = vim.fn.getcwd(-1, -1, -1)
    local dir = api.nvim_buf_get_name(buf)
    local rel_path = fs.relpath(root, dir)

    if not rel_path then
        return "/", dir, dir
    elseif rel_path == "." then
        rel_path = ""
    else
        rel_path = rel_path .. "/"
    end

    return root, dir, rel_path
end

---@param rel_target string
---@param root string
---@return string target
local function to_abs_path(rel_target, root)
    local target = vim.trim(rel_target)

    target = fs.joinpath(root, target)
    target = fs.normalize(target)

    return target
end

api.nvim_create_autocmd("FileType", {
    pattern = "directory",
    group = augroup,
    callback = function(args)
        vim.keymap.set("n", "-", "<Plug>(nvim-dir-up)", { silent = true, desc = "Go to parent directory" })

        vim.keymap.set("n", "a", function()
            local root, abs_dir, rel_dir = get_paths(args.buf)

            vim.ui.input({
                prompt = "File name: ",
                scope = "buffer",
                default = rel_dir,
                highlight = function(text)
                    local rev = string.reverse(text)
                    local sep_inverse_idx = string.find(rev, "/", 1, true)

                    if not sep_inverse_idx then
                        return {}
                    end

                    local sep_idx = #text - sep_inverse_idx + 1
                    return { { 0, sep_idx, "Directory" } }
                end,
            }, function(rel_target)
                if not rel_target then return end

                local target = to_abs_path(rel_target, root)

                local already_exists = uv.fs_stat(target)
                if already_exists  then
                    local target_is_browsing_dir = (target .. "/") == abs_dir
                    if not target_is_browsing_dir then
                        vim.notify(string.format("File already exists: %s", target), vim.log.levels.ERROR)
                    end
                    return
                end

                local buf ---@type integer?

                local all_bufs = api.nvim_list_bufs()
                for _, b in ipairs(all_bufs) do
                    if api.nvim_buf_get_name(b) == target then
                        buf = b
                        break
                    end
                end

                if not buf then
                    buf = api.nvim_create_buf(true, false)
                    api.nvim_buf_set_name(buf, target)
                    api.nvim_buf_call(buf, function()
                        vim.cmd("filetype detect")
                    end)
                end

                api.nvim_win_set_buf(0, buf)
            end)
        end, { buf = args.buf, desc = "Create a file" })

        vim.keymap.set("n", "d", function()
            local root, abs_dir, rel_dir = get_paths(args.buf)

            vim.ui.input({
                prompt = "Directory name: ",
                scope = "buffer",
                default = rel_dir,
                highlight = function(text)
                    return { { 0, #text, "Directory" } }
                end,
            }, function(rel_target)
                if not rel_target then return end

                local target = to_abs_path(rel_target, root)

                local already_exists = uv.fs_stat(target)
                if already_exists then
                    local target_is_browsing_dir = (target .. "/") == abs_dir
                    if not target_is_browsing_dir then
                        vim.notify(string.format("Directory already exists: %s", target), vim.log.levels.ERROR)
                    end
                    return
                end

                fs.mkdir(target, { parents = true })
                require("nvim.dir").open(args.buf, target, require("nvim.dir.fs"))
            end)
        end, { buf = args.buf, desc = "Create a [d]irectory(s)", nowait = true })

        vim.keymap.set("n", "D", function()
            local _, dir, rel_dir = get_paths(args.buf)

            local item = api.nvim_get_current_line()
            if vim.endswith(item, "/") then
                item = string.sub(item, 1, -2)
            end

            local rel_path = fs.joinpath(rel_dir, item)
            rel_path = fs.normalize(rel_path)
            local prompt = string.format("Confirm deletion of %q", rel_path)
            local choice = vim.fn.confirm(prompt, "&yes\n&No", 2)

            if choice == 1 then
                local abs_path = fs.joinpath(dir, item)
                local normal_abs_path = fs.normalize(abs_path)
                fs.rm(normal_abs_path, { force = true, recursive = true })
                require("nvim.dir")._reload(args.buf)
            end
        end, { buf = args.buf, desc = "[D]elete item" })

        vim.keymap.set("n", "r", function()
            local root, abs_dir, rel_dir = get_paths(args.buf)

            local item = api.nvim_get_current_line()
            if vim.endswith(item, "/") then
                item = string.sub(item, 1, -2)
            end

            local original_rel_path = fs.joinpath(rel_dir, item)
            original_rel_path = fs.normalize(original_rel_path)
            local prompt = string.format("Move %s -> ", original_rel_path)
            vim.ui.input({
                prompt = prompt,
                scope = "buffer",
                default = original_rel_path,
            }, function(input)
                if not input then return end

                local dest = to_abs_path(input, root)

                local already_exists = uv.fs_stat(dest)
                if already_exists then
                    local choice = vim.fn.confirm(
                        string.format("File %s already exists. Overwrite?", dest),
                        "&yes\n&No",
                        2
                    )

                    if choice ~= 1 then return end
                end

                local origin = fs.joinpath(abs_dir, item)
                origin = fs.normalize(origin)
                -- overwrites if `dest` already exists
                local ok, err = uv.fs_copyfile(origin, dest)
                if not ok then
                    vim.notify("Failed to move a file: " .. err, vim.log.levels.ERROR)
                    return
                end

                fs.rm(origin)

                require("nvim.dir")._reload(args.buf)
            end)
        end, { buf = args.buf, desc = "Move item ([r]ename)" })

        vim.keymap.set("n", "<C-h>", function()
            hidden_visible = not hidden_visible
            require("nvim.dir")._reload(args.buf)

            local msg ---@type string
            if hidden_visible then
                msg = "Showing hidden files"
            else
                msg = "Hiding hidden files "
            end
            api.nvim_echo({ { msg, "DiagnosticHint" } }, false, {
                id = HIDE_TOGGLE_MSG_ID,
                kind = "dir.settin-toggle",
            })
        end, { buf = args.buf, desc = "Toggle [h]idden files visibility" })
    end,
    desc = "",
})


local glyph = { fifo = "|", socket = "=", char = "%", block = "#", }

api.nvim_set_decoration_provider(ns, {
    on_win = function(_, _, buf)
        return vim.bo[buf].filetype == "directory"
    end,
    on_range = function(_, _, buf, row)
        local dir = api.nvim_buf_get_name(buf)
        local name = api.nvim_buf_get_lines(buf, row, row + 1, true)[1]
        local path = fs.joinpath(dir, (name:gsub("/$", "")))
        local stat = uv.fs_lstat(path) or {}

        local exe = stat.type == "file" and bit.band(stat.mode, tonumber("111", 8)) ~= 0
        local char = glyph[stat.type] or (exe and "*")
        if char then
            api.nvim_buf_set_extmark(buf, ns, row, #name, {
                virt_text = { { char, "Dimmed" } },
                virt_text_pos = "overlay",
                ephemeral = true,
            })
        end

        if stat.type == "link" then
            local target = uv.fs_readlink(path) or "?"
            api.nvim_buf_set_extmark(buf, ns, row, 0, {
                virt_text = { { "-> " .. target, "Dimmed" } },
                virt_text_pos = "eol",
                ephemeral = true,
                hl_mode = "combine",
            })
        end

        if vim.startswith(name, ".") and stat.type == "file" then
            api.nvim_buf_set_extmark(buf, ns, row, 0, {
                end_col = #name,
                hl_group = "DirHiddenFile",
                ephemeral = true,
            })
        elseif string.upper(name) == "LICENSE" then
            api.nvim_buf_set_extmark(buf, ns, row, 0, {
                end_col = #name,
                hl_group = "DirLicense",
                ephemeral = true,
            })
        elseif string.upper(name) == "README.MD" then
            api.nvim_buf_set_extmark(buf, ns, row, 0, {
                end_col = #name,
                hl_group = "DirReadme",
                ephemeral = true,
            })
        end

        return row + 1
    end,
})
