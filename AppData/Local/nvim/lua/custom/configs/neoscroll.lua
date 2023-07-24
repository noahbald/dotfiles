local multiplier = 2
local timing = {
    ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', tostring(250 / multiplier)}},
    ['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', tostring(250 / multiplier)}},
    ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', tostring(450 / multiplier)}},
    ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', tostring(450 / multiplier)}},
    ['<C-y>'] = {'scroll', {'-0.10', 'false', tostring(100 / multiplier)}},
    ['<C-e>'] = {'scroll', { '0.10', 'false', tostring(100 / multiplier)}},
    ['zt']    = {'zt', {tostring(250 / multiplier)}},
    ['zz']    = {'zz', {tostring(250 / multiplier)}},
    ['zb']    = {'zb', {tostring(250 / multiplier)}},
}

return timing
