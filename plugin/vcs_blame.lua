if not vim.fn.executable("git") then return end

local is_git_repo = vim.uv.fs_stat(assert(vim.uv.cwd()) .. "/.git") ~= nil
if not is_git_repo then return end

local api = vim.api
local line_blame_group = api.nvim_create_augroup("sagg0t.current_line_blame", { clear = true })
local line_blame_ns = api.nvim_create_namespace("sagg0t.current_line_blame")

local sec_per_min = 60
local sec_per_h = sec_per_min * 60
local sec_per_d = sec_per_h * 24
local sec_per_month = sec_per_d * 30
local sec_per_year = sec_per_d * 365

---@param ts integer
local function format_timestamp(ts)
    local diff = os.time() - ts
    if diff < sec_per_h then
        return math.floor(diff / sec_per_min) .. "m ago"
    elseif diff < sec_per_d then
        return math.floor(diff / sec_per_h) .. "h ago"
    elseif diff < sec_per_month then
        return math.floor(diff / sec_per_d) .. "d ago"
    elseif diff < sec_per_year then
        return math.floor(diff / sec_per_month) .. "M ago"
    else
        return math.floor(diff / sec_per_year) .. "y ago"
    end
end

---@class (private) sagg0t.blame_details
---@field commit string
---@field author string
---@field author-mail string
---@field author-time string
---@field author-tz string
---@field committer string
---@field committer-mail string
---@field committer-time string
---@field committer-tz string
---@field summary string
---@field previous? string
---@field filename string
---@field line string

---@param output string
---@return sagg0t.blame_details? # `nil` when not committed yet
local function parse_blame(output)
    local lines = vim.split(output, "\n", { plain = true })
    if lines[#lines] == "" then
        lines[#lines] = nil
    end

    ---@type sagg0t.blame_details
    local details = {} ---@diagnostic disable-line miising-fileds

    local commit_end = string.find(lines[1], " ", 1, true) - 1
    details.commit = string.sub(lines[1], 1, commit_end)

    details.line = string.sub(lines[#lines], 2) -- remove leading tab

    for i = 2, #lines - 1 do
        local line = lines[i]
        local key_end = string.find(line, " ", 1, true)
        -- Sometimes can be a single word e.g. initial commit will have "boundary" as a line of parent commit.
        if key_end then
            local key = string.sub(line, 1, key_end - 1)

            local value = string.sub(line, #key + 2)
            details[key] = assert(value)
        end
    end

    if details.commit ~= "0000000000000000000000000000000000000000" then
        return details
    end
end

---@param path string
---@param line integer
---@param callback fun(output?: sagg0t.blame_details)
---@return string?
local function get_blame(path, line, callback)
    local cmd = { "git", "blame", "--porcelain", "-w", "-L", line .. "," .. line, path }
    vim.system(cmd, { text = true }, function(result)
        if result.code ~= 0 or not result.stdout then return end

        local details = parse_blame(result.stdout)
        callback(details)
    end)
end

local blamed_line = -1
api.nvim_create_autocmd("CursorHold", {
    group = line_blame_group,
    callback = function()
        local buf = api.nvim_get_current_buf()
        local file = vim.api.nvim_buf_get_name(buf)
        if file == "" then return end

        local line = api.nvim_win_get_cursor(0)[1]
        blamed_line = line
        api.nvim_buf_clear_namespace(buf, line_blame_ns, 0, -1)
        local line_text = api.nvim_get_current_line()

        get_blame(file, line, function(details)
            local text ---@type string

            if not details or details.line ~= line_text then
                -- not committed or text differs from the commit
                text = "    Not Committed Yet"
            else
                local author = details.author
                if author == "" then author = details["author-mail"] end
                if author == "" then author = "<UNKNOWN AUTHOR>" end

                local short_commit = string.sub(details.commit, 1, 7)
                local timestamp = tonumber(details["author-time"])
                local time_ago = timestamp and format_timestamp(timestamp) or ""

                text = string.format("    %s %s %s, %s", short_commit, time_ago, author, details.summary)
            end

            vim.schedule(function()
                api.nvim_buf_set_extmark(buf, line_blame_ns, line - 1, 0, {
                    hl_mode = "combine",
                    virt_text = { { text, "Comment" } },
                    virt_text_pos = "eol",
                })
                api.nvim_create_autocmd("CursorMoved", {
                    group = line_blame_group,
                    callback = function()
                        local move_line = api.nvim_win_get_cursor(0)[1]
                        if move_line == blamed_line then return end

                        blamed_line = -1
                        api.nvim_buf_clear_namespace(buf, line_blame_ns, 0, -1)
                    end,
                })
            end)
        end)
    end,
})

api.nvim_create_autocmd({ "InsertEnter" }, {
    group = line_blame_group,
    callback = function()
        api.nvim_buf_clear_namespace(0, line_blame_ns, 0, -1)
    end
})

api.nvim_create_user_command("Blame", function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then return end

    local line = api.nvim_win_get_cursor(0)[1]
    local line_text = api.nvim_get_current_line()

    get_blame(file, line, function(details)
        if not details then return end

        if details.line ~= line_text then
            vim.notify("Not Committed Yet")
            return
        end

        local author ---@type string
        if details.author ~= "" and details["author-mail"] ~= "" then
            author = details.author .. " " .. details["author-mail"]
        elseif details.author ~= "" then
            author = details.author
        else
            author = details["author-mail"]
        end

        local committer ---@type string
        if details.committer ~= "" and details["committer-mail"] ~= "" then
            committer = details.committer .. " " .. details["committer-mail"]
        elseif details.committer ~= "" then
            committer = details.committer
        else
            committer = details["committer-mail"]
        end

        ---@type string[]
        local lines = {
            "commit: " .. details.commit,
            "author: " .. author,
            "committer: " .. committer,
            "",
            details.summary,
        }

        if details.previous then
            table.insert(lines, "")
            table.insert(lines, "previous: " .. details.previous)
        end

        vim.schedule(function()
            local buf = api.nvim_create_buf(false, true)
            api.nvim_buf_set_lines(buf, 0, -1, false, lines)

            api.nvim_set_option_value("modifiable", true, { buf = buf })
            api.nvim_set_option_value("readonly", true, { buf = buf })
            api.nvim_set_option_value("buftype", "nofile", { buf = buf })

            local max_w = 0
            for _, l in ipairs(lines) do
                max_w = math.max(max_w, #l)
            end

            local wid = api.nvim_open_win(buf, true, {
                relative = "cursor",
                row = 1, col = 1,
                width = math.min(max_w, 80),
                height = #lines,
            })

            api.nvim_create_autocmd("WinLeave", {
                group = line_blame_group,
                callback = function(ev)
                    if ev.buf == buf then
                        if api.nvim_buf_is_valid(buf) then
                            api.nvim_buf_delete(buf, { force = true })
                        end
                        return true
                    end
                end
            })

            vim.keymap.set("n", { "q", "<Esc>" }, function()
                if api.nvim_win_is_valid(wid) then
                    api.nvim_win_close(wid, true)
                    if api.nvim_buf_is_valid(buf) then
                        api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end, { buf = buf })
        end)
    end)
end)
