# zoom.nvim

A small Neovim plugin to toggle maximizing the current window split and restoring it.  
Written in pure Lua, no dependencies.

## Features
- Toggle maximize current split (height + width)
- Restore previous size on un-toggle
- Per-window state (you can maximize different windows independently)
- Pure Lua, no dependencies
- Provides `:ToggleMaximize` command and `<leader>wt` mapping by default

## Installation

### lazy.nvim
```lua
{
  "lrappenhoener/zoom.nvim",
  config = function()
    require('zoom').setup({ key = '<leader>wz' })
  end
}
```

### packer.nvim
```lua
use {
  'lrappenhoener/zoom.nvim',
  config = function()
    require('zoom').setup({ key = '<leader>wz' })
  end
}
```

### vim-plug
```vim
Plug 'lrappenhoener/zoom.nvim'
```
Then in `init.lua`:
```lua
require('zoom').setup({ key = '<leader>wz' })
```

## Usage
- `:ToggleMaximize` — toggles maximize/restore for current window
- `<leader>wz` — default mapping to toggle

## License
MIT
