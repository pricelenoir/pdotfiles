local parsers = {
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "c",
    "cpp",
    "python",
    "bash",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "markdown",
    "markdown_inline",
}

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        -- Highlighting and indent, only when a parser is available
        if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
