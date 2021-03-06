" Author: w0rp <devw0rp@gmail.com>, KabbAmine <amine.kabb@gmail.com>
" Description: This file adds support for checking Vim code with Vint.

" This flag can be used to change enable/disable style issues.
let g:ale_vim_vint_show_style_issues =
\   get(g:, 'ale_vim_vint_show_style_issues', 1)

let s:warning_flag = g:ale_vim_vint_show_style_issues ? '-s' : '-w'
let s:vint_version = ale#semver#Parse(system('vint --version'))
let s:has_no_color_support = ale#semver#GreaterOrEqual(s:vint_version, [3, 0, 7])
let s:enable_neovim = has('nvim') ? ' --enable-neovim ' : ''
let s:format = '-f "{file_path}:{line_number}:{column_number}: {severity}: {description} (see {reference})"'

call ale#linter#Define('vim', {
\   'name': 'vint',
\   'executable': 'vint',
\   'command': 'vint '
\       . s:warning_flag . ' '
\       . (s:has_no_color_support ? '--no-color ' : '')
\       . s:enable_neovim
\       . s:format
\       . ' %t',
\   'callback': 'ale#handlers#HandleGCCFormat',
\})
