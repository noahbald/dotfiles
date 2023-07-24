for _, language in ipairs({ "typescript", "javascript" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "node-terminal",
            request = "launch",
            name = "Launch terminal",
            cwd = "${workspaceFolder}",
        }
    }
end

