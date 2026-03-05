return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
        require("no-neck-pain").setup({
            autocmds = {
                skipEnteringNoNeckPainBuffer = true,
            },
            width = 120,
        })
    end,
}
