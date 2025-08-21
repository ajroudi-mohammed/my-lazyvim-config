local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then return end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

-- Helper function to trim leading/trailing whitespace and pipe characters
local function trim_path(s)
    -- Remove leading and trailing whitespace, and also any leading pipes.
    return s:gsub("^%s*|?%s*(.-)%s*$", "%1")
end

function M.flutter_errors()
  local opts = {}

  vim.notify("Running flutter analyze...", vim.log.levels.INFO)

  local output_string = vim.fn.system({
    "powershell",
    "-Command",
    "flutter analyze | Select-String 'error -'"
  })

  local results = {}

  -- The gmatch pattern is fine for capturing the general structure.
  -- We'll trim the 'file' variable afterwards to be safe.
  -- Pattern: `error - <message> - <path>:<line>:<col> - <error_code>`
  -- The last `.-` is to capture the error code at the end if present,
  -- but we only care about the first three captures for now.
  for message, file, line_num_str, col_str in output_string:gmatch("error %- (.-) %- ([^:]+):(%d+):(%d+)") do
    local lnum = tonumber(line_num_str)
    local col = tonumber(col_str)

    -- Trim the captured file path and normalize slashes
    local cleaned_file = trim_path(file)
    local normalized_file = cleaned_file:gsub("\\", "/")

    table.insert(results, {
      filename = normalized_file,
      lnum = lnum,
      col = col,
      text = message,
      display = string.format("%s:%s:%s • %s", normalized_file, lnum, col, message),
    })
  end

  if vim.tbl_isempty(results) then
    vim.notify("No errors found! ✨", vim.log.levels.INFO)
    return
  end

  pickers.new(opts, {
    prompt_title = "Flutter Analyze Errors 🐛",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.display, -- Used for fuzzy matching
          filename = entry.filename,
          lnum = entry.lnum,
          col = entry.col,
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          local col_to_jump = math.max(1, selection.col)
          local cmd = string.format("silent edit +%d %s | call cursor(0, %d)",
                                    selection.lnum, selection.filename, col_to_jump)
          vim.cmd(cmd)
        end
      end)
      return true
    end,
    vim.notify("Results ready!", vim.log.levels.INFO)
  }):find()

  
end

return M