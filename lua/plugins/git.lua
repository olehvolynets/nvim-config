return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        cmd = "Gitsigns",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signcolumn = false,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 1000,
                virt_text_pos = 'eol'
            }
        }
    }
}
