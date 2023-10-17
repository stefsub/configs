local snyk_ls_config = {
  default_config = {
    cmd = { "snyk-ls" },
    root_dir = require("lspconfig.util").find_git_ancestor,
    single_file_support = true,
    filetypes = {}, -- empty equates to all filetypes
    settings = {},
    init_options = {},
  },
  docs = {
    description = [[
https://github.com/snyk/snyk-ls
LSP for Snyk Open Source, Snyk Infrastructure as Code, and Snyk Code.
]],
    default_config = {
      filetypes = "Empty by default, override to add filetypes",
      root_dir = "Vim's starting directory",
      init_options = "Configuration from https://github.com/snyk/snyk-ls#configuration-1",
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = true },
      setup = {
        snyk = function(_, opts)
          local configs = require("lspconfig.configs")
          configs.snyk = configs.snyk or snyk_ls_config
        end,
      },
      servers = {
        snyk = {
          init_options = {
            activateSnykOpenSource = "true",
            activateSnykCode = "true",
            activateSnykIac = "true",
            enableTrustedFoldersFeature = "false", -- Whether or not LS will prompt to trust a folder (default: true)
            token = "",
          },
        },
      },
    },
  },
}
