local api = vim.api

local M = {}

local config = {
  key = '<leader>wz',
  cmd = 'ToggleMaximize',
  mappings = true,
  save_on_winleave = false,
}

M._state = M._state or {}

local function get_win_sizes(win)
  local ok_h, h = pcall(api.nvim_win_get_height, win)
  local ok_w, w = pcall(api.nvim_win_get_width, win)
  if not ok_h or not ok_w then return nil end
  return { height = h, width = w }
end

function M.toggle()
  local win = api.nvim_get_current_win()
  local state = M._state[win]

  if state and state.maximized then
    if state.prev and state.prev.height and state.prev.width then
      pcall(vim.cmd, 'vertical resize ' .. tostring(state.prev.width))
      pcall(vim.cmd, 'resize ' .. tostring(state.prev.height))
    end
    M._state[win] = nil
    return false
  end

  local sizes = get_win_sizes(win)
  if not sizes then return nil end
  M._state[win] = { maximized = true, prev = sizes }
  pcall(vim.cmd, 'wincmd _')
  pcall(vim.cmd, 'wincmd |')
  return true
end

function M.setup(opts)
  opts = opts or {}
  for k, v in pairs(opts) do config[k] = v end

  api.nvim_create_user_command(config.cmd, function() M.toggle() end, { desc = 'Toggle maximize current window' })

  if config.mappings and config.key and config.key ~= '' then
    vim.keymap.set('n', config.key, function() M.toggle() end, { desc = 'Toggle window maximize', silent = true })
  end

  api.nvim_create_autocmd('WinClosed', {
    pattern = '*',
    callback = function()
      for winid, _ in pairs(M._state) do
        if not pcall(api.nvim_win_get_buf, winid) then
          M._state[winid] = nil
        end
      end
    end,
  })

  if config.save_on_winleave then
    api.nvim_create_autocmd('WinLeave', {
      pattern = '*',
      callback = function()
        local win = api.nvim_get_current_win()
        local s = get_win_sizes(win)
        if s then
          M._state[win] = M._state[win] or {}
          M._state[win].prev = s
        end
      end,
    })
  end
end

return M
