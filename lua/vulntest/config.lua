local M = {}

-- Default options (not used in this example but available for extensibility)
M.opts = {}

function M.setup(user_opts)
    M.opts = vim.tbl_deep_extend("force", M.opts, user_opts or {})
end

return M
