---@type table<string, vim.lsp.Config>
return {
    filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    settings = {
        gopls = {
            templateExtensions = { "html", "tmpl" },
            gofumpt = true,
            staticcheck = true,
            semanticTokens = true,
            semanticTokenTypes = {
                string = false,
            },
            usePlaceholders = true,
            vulncheck = "Imports",
            analyses = {
                unusedparams = true,
                unusedvariable = true,
                unreachable = true,
                useany = true,
                ST1000 = false,
            },
            codelenses = {
                generate = true,
                gc_details = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true
            },
            hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = false,
                rangeVariableTypes = false,
            },
        }
    }
}
