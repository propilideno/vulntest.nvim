-- Load plugin
if vim.g.loaded_vulntest then
    return
end
vim.g.loaded_vulntest = true

-- Create user commands
vim.api.nvim_create_user_command(
    "VulnTest",
    function()
        require("vulntest").hack()
    end,
    { desc = "Execute the VulnTest" }
)
