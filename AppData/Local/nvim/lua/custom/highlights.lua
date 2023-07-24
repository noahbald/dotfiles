-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}


---@type Base46HLGroupsList
M.override = {
    Comment = {
        italic = true,
    },
    FoldColumn = {
        fg = "grey",
        bg = "black",
    },
    Folded = {
        fg = "grey",
        bg = "black",
    },
}

---@type HLTable
M.add = {
    IlluminatedWord = { bg = "grey" },
    IlluminatedCurWord = { bg = "grey" },
    IlluminatedWordText = { bg = "grey" },
    IlluminatedWordRead = { bg = "grey" },
    IlluminatedWordWrite = { bg = "grey" },

    NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
