return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      html = { "tidy" },
      javascript = { "eslint" },
      lua = { "selene" },
      sql = { "sqlfluff" },
      yaml = { "cfn_lint" },
    },
    linters = {
      cfn_lint = {
        ignore_exitcode = true,
      },
    },
  },
}
