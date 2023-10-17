local foldIcon = ""
local hlgroup = "NonText"
local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = "  " .. foldIcon .. "  " .. tostring(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, hlgroup })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  init = function()
    vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.opt.foldlevelstart = 99

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css" }
      if vim.tbl_contains(lspWithOutFolding, filetype) then
        return { "treesitter", "indent" }
      elseif filetype == "html" then
        return { "indent" } -- lsp & treesitter do not provide folds
      else
        return { "lsp", "indent" }
      end
    end,
    -- open opening the buffer, close these fold kinds
    -- use `:UfoInspect` to get available fold kinds from the LSP
    close_fold_kinds = { "imports" },
    open_fold_hl_timeout = 500,
    fold_virt_text_handler = foldTextFormatter,
  },
}