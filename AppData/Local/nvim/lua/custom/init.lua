-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- editor defaults
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.spell = true
vim.opt.spelllang = "en_au"

-- Restore barbar session
vim.api.nvim_create_user_command(
    'Mksession',
    function(attr)
        vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})

        -- Neovim 0.8+
        vim.cmd.mksession {bang = attr.bang, args = attr.fargs}

        -- Neovim 0.7
        -- vim.api.nvim_command('mksession ' .. (attr.bang and '!' or '') .. attr.args)
    end,
    {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
)
