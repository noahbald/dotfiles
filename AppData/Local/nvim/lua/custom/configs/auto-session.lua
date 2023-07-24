-- FIXME: Adding globals doesn't seem to help in saving barbar sessions
-- FIXME: Adding globals causes error when writing to statusline
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

-- Ensure nvim-tree stays in view as session changes
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

local M = {
    log_level = "info",
    pre_save = function()
        -- Include barbar.nvim in session, for tab order and pins
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
    end,
}
return M
