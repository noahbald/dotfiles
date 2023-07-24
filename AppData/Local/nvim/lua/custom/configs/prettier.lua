local function is_file_existant(dir, config)
    local file = io.open(dir .. "/" .. config, "r")
    if file then
        file:close()
        return true
    end
    return false
end

local function find_prettier_conf(dir)
    local configs = { '.prettierrc', '.prettierrc.js', '.prettierrc.json', '.prettierrc.yaml', '.prettierrc.yml', 'prettier.config.js' }

    for _, config in ipairs(configs) do
        if is_file_existant(dir, config) then
            return true
        end
    end

    return false
end

return {
    find_prettier_conf = find_prettier_conf,
}
