vim.treesitter.query.add_predicate("has-sql-comment?", function(matches, _, bufnr)
    local node

    for _, match in pairs(matches) do
        local n = match[1]
        if n and (n:type() == "interpreted_string_literal_content" or n:type() == "raw_string_literal_content") then
            node = n
            break
        end
    end

    if not node then return false end

    local ancestor = node:parent()
    while ancestor and ancestor:type() ~= "const_spec" and ancestor:type() ~= "var_spec" do
        ancestor = ancestor:parent()
    end

    if not ancestor then return false end

    local function has_sql_comment(n)
        if n:type() == "comment" then
            local text = vim.treesitter.get_node_text(n, bufnr)
            return text:match("[Ss][Qq][Ll]") ~= nil
        end

        for child in n:iter_children() do
            if has_sql_comment(child) then
                return true
            end
        end

        return false
    end

    return has_sql_comment(ancestor)
end)
