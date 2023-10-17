local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")

local function preview_selected_pr(self, entry, status)
  -- Execute another command using the highlighted entry
  return require("telescope.previewers.utils").job_maker({ "gh", "pr", "view", entry.value }, self.state.bufnr, {})
end

local function checkout_selected_pr(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    -- print(vim.inspect(selection))
    vim.fn.system("gh pr checkout " .. selection.value)
  end)
  return true
end

local function checkout_github_pr(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      results_title = "Github PRs",
      -- Run an external command and show the results in the finder window
      finder = finders.new_oneshot_job({ "gh", "pr", "list" }, opts),
      sorter = sorters.get_fuzzy_file(),
      previewer = previewers.new_buffer_previewer({
        define_preview = preview_selected_pr,
      }),
      attach_mappings = checkout_selected_pr,
    })
    :find()
end

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>gp", checkout_github_pr, desc = "Checkout Github PR" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },
  },
}
