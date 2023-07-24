local overrides = require("custom.configs.overrides")

local function init_git(plugin)
    -- load flog only when a git file is opened
    vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup(plugin, { clear = true }),
        callback = function()
            vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
            if vim.v.shell_error == 0 then
                vim.api.nvim_del_augroup_by_name(plugin)
                vim.schedule(function()
                    require("lazy").load { plugins = { plugin } }
                end)
            end
        end,
    })
end

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options
    -- UI

    {
        "echasnovski/mini.animate",
        config = function()
            local opts = require "custom.configs.mini"
            require("mini.animate").setup(opts.animate)
        end,
        event = "VeryLazy",
    },

    {
        "echasnovski/mini.trailspace",
        event = "VeryLazy",
    },

    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
    },

    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = require 'custom.configs.barbar',
        lazy = false,
        version = "^1.0.0",
        name = "barbar",
    },

    {
        "gorbit99/codewindow.nvim",
        config = function()
            local codewindow = require("codewindow")
            codewindow.setup()
            codewindow.apply_default_keybinds()
            codewindow.open_minimap()
        end,
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                callback = function()
                    vim.schedule(function()
                        require("lazy").load { plugins = { "codewindow.nvim" } }
                    end)
                end,
            })
        end,
    },

    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
            require("core.utils").load_mappings("todo-comments")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
    },

    -- Editor

    {
        "rmagatti/auto-session",
        config = function()
            local opts = require "custom.configs.auto-session"
            require("auto-session").setup(opts)
        end,
        init = function()
            -- Ignore auto-session if files are given in args
            local arg_count = vim.api.nvim_exec("echo argc()", true)
            if tonumber(arg_count) ~= 0 then
                return
            end
            require("lazy").load { plugins = { "auto-session" } }
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        config = function()
            local opts = require("custom.configs.ufo")
            require("ufo").setup(opts)
        end,
        dependencies = {
            "kevinhwang91/promise-async",
            "luukvbaal/statuscol.nvim",
        },
        event = "VeryLazy",
    },

    {
        "MunifTanjim/prettier.nvim",
        config = function()
            require("prettier").setup({
                bin = "prettier", -- or `prettierd`
            })
            require("core.utils").load_mappings("prettier")
        end,
        init = function()
            local dir = vim.fn.expand("%:p:h")
            local is_prettier_project = require("custom.configs.prettier").find_prettier_conf(dir)
            if not is_prettier_project then
                return
            end
            vim.schedule(function()
                require("lazy").load { plugins = { "prettier.nvim" } }
            end)
        end,
    },

    {
        "mattn/emmet-vim",
        ft = { "html", "eruby", "javascript" },
    },

    {
        config = function()
            require("core.utils").load_mappings("color-converter")
        end,
        "NTBBloodbath/color-converter.nvim",
        ft = { "html", "eruby", "javascript", "css" },
    },

    -- Debugging

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("core.utils").load_mappings("dap")
        end,
        dependencies = {
            "Weissle/persistent-breakpoints.nvim",
        },
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            require("core.utils").load_mappings("dap-ui")
        end,
    },

    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            require("persistent-breakpoints").setup {
                load_breakpoints_event = { "BufReadPost" },
            }
        end,
    },

    {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
            local utils = require("dap-vscode-js.utils")
            require("dap-vscode-js").setup {
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
                debugger_path = utils.join_paths(utils.get_runtime_dir(), "lazy/vscode-js-debug"),
            }
            require("custom.configs.nvim-dap-vscode-js")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            {
                "microsoft/vscode-js-debug",
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
            }
        },
        ft = "javascript",
    },

    -- Tools

    {
        "nvim-pack/nvim-spectre",
        config = function()
            require("spectre").setup()
            require("core.utils").load_mappings("spectre")
        end,
        keys = {
            { "<leader>fr", mode = "n", desc = "Find and replace" },
            { "<leader>fr", mode = "v", desc = "Find and replace" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Git

    {
        "f-person/git-blame.nvim",
        config = function()
            require("gitblame")
            require("core.utils").load_mappings("gitblame")
        end,
        init = init_git("git-blame.nvim"),
    },

    {
        "rbong/vim-flog",
        config = function()
            require("core.utils").load_mappings("flog")
        end,
        dependencies = {
            "tpope/vim-fugitive",
        },
        ft = { "gitcommit", "diff" },
        init = init_git("vim-flog"),
    },

    -- default custom plugins

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = overrides.mason
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },

    -- Install a plugin
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    -- To make a plugin not be loaded
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
}

return plugins
