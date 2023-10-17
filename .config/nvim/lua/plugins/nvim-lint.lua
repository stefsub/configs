return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      css = { "stylelint" },
      html = { "tidy" },
      javascript = { "eslint" },
      lua = { "selene" },
      python = { "pylint" },
      shell = { "shellcheck" },
      sql = { "sqlfluff" },
      terraform = { "tfsec" },
      yaml = { "cfn_lint" },
    },
    linters = {
      cfn_lint = {
        ignore_exitcode = true,
      },
    },
  },
}
