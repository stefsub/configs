return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      css = { "stylelint" },
      javascript = { "prettier" },
      lua = { "stylua" },
      python = { "black" },
      rust = { "rustfmt" },
      shell = { "shfmt" },
      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
    },
  },
}
