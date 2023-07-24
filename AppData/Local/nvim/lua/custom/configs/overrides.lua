local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "embedded_template",
        "c",
        "markdown",
        "markdown_inline",
    },
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
    },
    autotag = {
        enable = true,
        enable_rename = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'eruby',
            'xml',
            'php',
            'markdown',
            'astro', 'glimmer', 'handlebars', 'hbs',
        },
    }
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
        "ruby-lsp",
        "eslint_d",

        -- c/cpp stuff
        "clangd",
        "clang-format",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M
