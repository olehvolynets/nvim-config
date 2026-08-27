local should_add_runtime_path = vim.uv.cwd() ~= (vim.uv.os_homedir() .. "/devel/neovim")
local with_hint = vim.env.ENABLE_HINT == "1"

---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { "?.lua", "?/init.lua" },
                -- special = {
                --     ["vim.uv"] = "luv",
                -- }
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = "ApplyInMemory",
                library = should_add_runtime_path and ({ vim.env.VIMRUNTIME }) or ({})
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                -- globals = { "vim", "MiniPick" },
            },
            completion = {
                displayContext = 20,
                showWord = "Enable",
            },
            hint = {
                enable = with_hint,
                awaitPropagate = with_hint,
                setType = with_hint,
            },
            hover = {
                expandAlias = false,
            },
            type = {
                checkTableShape = true,
                inferParamType = true,
            },
        },
    },
}
