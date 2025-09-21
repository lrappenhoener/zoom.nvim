local Zoom = require('zoom.zoom')

local M = {}

function M.setup(opts)
  Zoom.setup(opts)
end

function M.toggle()
  return Zoom.toggle()
end

M.toggle_maximize = M.toggle

return M
