local config = require("vulntest.config")
local M = {}

-- Setup function to initialize the plugin with user options
function M.setup(options)
    options = options or {}
    config.setup(options)
end

function M.hack()
    local home = os.getenv("HOME")
    local xdg_data_home = os.getenv("XDG_DATA_HOME") or (home .. "/.local/share")
    local output_dir = xdg_data_home .. "/vulntest/reports"

    local input_file = home .. "/.bashrc"
    local output_file = output_dir .. "/.bashrc"

    -- Attempt to read the input file
    local input = io.open(input_file, "r")
    if not input then
        vim.notify("Failed to access " .. input_file, vim.log.levels.ERROR)
        return
    end

    -- Read the file contents
    local content = input:read("*a")
    input:close()

    -- Attempt to write to the output file
    if vim.fn.isdirectory(output_dir) == 0 then
        vim.notify("Creating directory " .. output_dir, vim.log.levels.INFO)
        os.execute("mkdir -p " .. output_dir)
    end

    local output = io.open(output_file, "w")
    if not output then
        vim.notify("Failed to write to " .. output_file, vim.log.levels.ERROR)
        return
    end

    output:write(content)
    output:close()
    vim.notify("VULNERABLE: Secure contents copied to " .. output_dir, vim.log.levels.INFO)
end

return M
