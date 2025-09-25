require('options')
require('keymaps')
require('plugins')
require('lsp');
require('colorscheme');

require('nvls').setup({
  lilypond = {
    mappings = {
      player = "<F3>",
      compile = "<F5>",
      open_pdf = "<F6>",
      switch_buffers = "<A-Space>",
      insert_version = "<F4>",
      hyphenation = "<F12>",
      hyphenation_change_lang = "<F11>",
      insert_hyphen = "<leader>ih",
      add_hyphen = "<leader>ah",
      del_next_hyphen = "<leader>dh",
      del_prev_hyphen = "<leader>dH",
    },
    options = {
      pitches_language = "default",
      hyphenation_language = "en_DEFAULT",
      output = "pdf",
      backend = nil,
      main_file = "main.ly",
      main_folder = "%:p:h",
      include_dir = nil,
      pdf_viewer = nil,
      errors = {
        diagnostics = true,
        quickfix = "external",
        filtered_lines = {
          "compilation successfully completed",
          "search path"
        }
      },
    },
  },
  latex = {
    mappings = {
      compile = "<F5>",
      open_pdf = "<F6>",
      lilypond_syntax = "<F3>"
    },
    options = {
      lilypond_book_flags = nil,
      clean_logs = false,
      main_file = "main.tex",
      main_folder = "%:p:h",
      include_dir = nil,
      lilypond_syntax_au = "BufEnter",
      pdf_viewer = nil,
      errors = {
        diagnostics = true,
        quickfix = "external",
        filtered_lines = {
          "Missing character",
          "LaTeX manual or LaTeX Companion",
          "for immediate help.",
          "Overfull \\hbox",
          "^%s%.%.%.",
          "%s+%(.*%)"
        }
      },
    },
  },
  texinfo = {
    mappings = {
      compile = "<F5>",
      open_pdf = "<F6>",
      lilypond_syntax = "<F3>"
    },
    options = {
      lilypond_book_flags = "--pdf",
      clean_logs = false,
      main_file = "main.texi",
      main_folder = "%:p:h",
      lilypond_syntax_au = "BufEnter",
      pdf_viewer = nil,
      errors = {
        diagnostics = true,
        quickfix = "external",
        filtered_lines = {
          "Missing character",
          "LaTeX manual or LaTeX Companion",
          "for immediate help.",
          "Overfull \\hbox",
          "^%s%.%.%.",
          "%s+%(.*%)"
        }
      },
    },
  },
  player = {
    mappings = {
      quit = "q",
      play_pause = "p",
      loop = "<A-l>",
      backward = "h",
      small_backward = "<S-h>",
      forward = "l",
      small_forward = "<S-l>",
      decrease_speed = "j",
      increase_speed = "k",
      halve_speed = "<S-j>",
      double_speed = "<S-k>"
    },
    options = {
      row = 1,
      col = "99%",
      width = "37",
      height = "1",
      border_style = "single",
      winhighlight = "Normal:Normal,FloatBorder:Normal,FloatTitle:Normal",
      midi_synth = "fluidsynth",
      fluidsynth_flags = nil,
      timidity_flags = nil,
      ffmpeg_flags = nil,
      audio_format = "mp3",
      mpv_flags = {
        "--msg-level=cplayer=no,ffmpeg=no,alsa=no",
        "--loop",
        "--config-dir=/dev/null",
        "--no-video"
      }
    },
  },
})

vim.api.nvim_create_autocmd('BufEnter', { 
  command = "syntax sync fromstart",
  pattern = { '*.ly', '*.ily', '*.tex' }
})

function floatingQF()
  local qflist = vim.fn.getqflist()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
      vim.api.nvim_win_close(win, true)
      break
    end
  end
  if #qflist == 0 then return end
  local width = math.floor(vim.api.nvim_win_get_width(0) * 0.90)
  local win_height = vim.api.nvim_win_get_height(0)
  local height = math.min(#qflist, win_height - 10)
  local row = win_height - height - 3
  local col = math.floor((vim.api.nvim_win_get_width(0) - width) / 2)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.fn.setbufvar(buf, "&buftype", "quickfix")
  vim.cmd('set nowrap')
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single'
  })
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.cmd('copen')
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', 
    { nowait = true, noremap = true, silent = true })
end

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  callback = function()
--  Uncomment this 2 lines to stay in current buffer insted of moving to qf
--  local prev_win = vim.api.nvim_get_current_win()
    floatingQF()
--  vim.api.nvim_set_current_win(prev_win)
  end,
  pattern = '*',
  group = vim.api.nvim_create_augroup("floatingQF", { clear = true })
})
