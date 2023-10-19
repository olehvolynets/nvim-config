return {
    "jiangmiao/auto-pairs", -- find lua analogue
    "andrewradev/splitjoin.vim",

    {
        "szw/vim-maximizer",
        lazy = true,
        cmd = "MaximizerToggle",
        keys = {
            { '<Leader>m', ':MaximizerToggle<CR>', noremap = true, silent = true }
        }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        main = "ibl",
        opts = {
            indent = {
                char = {
                    "│",
                    -- "┃"
                },
            },
            scope = {
                show_start = false,
                show_end = false,
            }
        }
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = { default = true }
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>nl", function() require("noice").cmd("last") end,    desc = "Noice Last Message" },
            -- { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            -- { "<leader>na", function() require("noice").cmd("all") end,     desc = "Noice All" },
        },
        opts = {
            cmdline = {
                format = {
                    search_down = { icon = " " },
                    search_up = { icon = " " },
                },
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
            },
            views = {
                mini = {
                    timeout = 5000
                }
            },
            popupmenu = {
                enabled = false,
            },
            -- routes = {
            --     {
            --         filter = {
            --             event = "msg_show",
            --             kind = "",
            --             find = "written",
            --         },
            --         opts = { skip = true },
            --     },
            -- },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        }
    },

    {
        "folke/todo-comments.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "TodoTrouble",
        keys = {
            { '<Leader>fn', '<CMD>TodoTrouble<CR>', noremap = true, silent = true }
        },
        opts = {
            search = {
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--glob=!node_modules",
                    "--glob=!vendor/bundle",
                    "--glob=!.git",
                }
            }
        }
    },


    {
        "brenoprata10/nvim-highlight-colors",
        lazy = true,
        cmd = {
            "HighlightColorsOn",
            "HighlightColorsOff",
            "HighlightColorsToggle",
        },
    }
}
