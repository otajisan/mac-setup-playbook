require 'plugins'
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

function SetOptions()
  local api = vim.api

  local opts = {
    splitright = true,
    splitbelow = true,
    clipboard = 'unnamedplus',
    hlsearch = true,
    mouse = 'a',
    whichwrap = 'b,s,h,l,<,>,[,]',
    ignorecase = true,
    smartcase = true,
    pumheight = 10,
    lazyredraw = true,
    showcmd = false,
    guicursor = vim.o.guicursor..',a:blinkon0',
    encoding = 'utf-8',
    undodir = vim.env.HOME..'/.local/share/nvim/backup',
    termguicolors = true
  }

  local wopts = {
    cursorline = true,
    signcolumn = 'yes',
    number = true,
    foldmethod = 'marker'
  }

  local bopts = {
    autoindent = true,
    smartindent = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    undofile = true
  }

  for opt, val in pairs(opts) do
    vim.api.nvim_set_option(opt, val)
  end

  for opt, val in pairs(wopts) do
    vim.api.nvim_win_set_option(0, opt, val)
  end

  for opt, val in pairs(bopts) do
    vim.api.nvim_buf_set_option(0, opt, val)
  end
end

SetOptions()

vim.cmd('autocmd FileType * lua SetOptions()')

require("github-theme").setup({
  theme_style = "dark",
  transparent = false,
  dark_sidebar = true,
  hide_inactive_statusline = false,
  sidebars = {"qf", "vista_kind", "terminal", "packer"},

  comment_style = "italic",
  keyword_style = "italic",
  function_style = "italic",
  variable_style = "italic",

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = {hint = "orange", error = "#ff0000"},

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      TSField = {},
    }
  end
})

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})

require('hlslens').setup({
  override_lens = function(render, plist, nearest, idx, r_idx)
    local sfw = vim.v.searchforward == 1
    local indicator, text, chunks
    local abs_r_idx = math.abs(r_idx)
    if abs_r_idx > 1 then
      indicator = ('%d%s'):format(abs_r_idx, sfw ~= (r_idx > 1) and '▲' or '▼')
    elseif abs_r_idx == 1 then
      indicator = sfw ~= (r_idx == 1) and '▲' or '▼'
    else
      indicator = ''
    end

    local lnum, col = unpack(plist[idx])
    if nearest then
      local cnt = #plist
      if indicator ~= '' then
        text = ('[%s %d/%d]'):format(indicator, idx, cnt)
      else
        text = ('[%d/%d]'):format(idx, cnt)
      end
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
    else
      text = ('[%s %d]'):format(indicator, idx)
      chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
    end
    render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
  end
})

require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

vim.cmd("let g:fern#default_hidden = 1")
vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -reveal=* -drawer -toggle -width=40<CR>', { noremap = true })
vim.cmd('let g:cursorhold_updatetime = 100')

vim.cmd([[
  function! s:fern_settings() abort
    nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
    nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
    nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
    nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  endfunction

  augroup fern-settings
    autocmd!
    autocmd FileType fern call s:fern_settings()
  augroup END

  function! s:init_fern() abort
    " Use 'select' instead of 'edit' for default 'open' action
    nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END
]])

vim.cmd("autocmd VimEnter * ++nested Fern . -stay -reveal=% -drawer -toggle")
