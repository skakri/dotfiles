" kk_tig_dark: low-glare palette aligned with the terminal tig/less theme.

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'kk_tig_dark'
set background=dark

if has('termguicolors')
  set termguicolors
endif

function! s:Hi(group, guifg, guibg, ctermfg, ctermbg, attr) abort
  execute printf(
        \ 'highlight %s guifg=%s guibg=%s ctermfg=%s ctermbg=%s gui=%s cterm=%s',
        \ a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:attr, a:attr)
endfunction

" Core UI
call s:Hi('Normal',        '#b2b2b2', 'NONE',    '249', 'NONE', 'NONE')
call s:Hi('CursorLine',    'NONE',    '#303030', 'NONE','236',  'NONE')
call s:Hi('CursorColumn',  'NONE',    '#303030', 'NONE','236',  'NONE')
call s:Hi('ColorColumn',   'NONE',    '#303030', 'NONE','236',  'NONE')
call s:Hi('CursorLineNr',  '#ffd75f', '#303030', '221', '236',  'bold')
call s:Hi('LineNr',        '#626262', 'NONE',    '241', 'NONE', 'NONE')
call s:Hi('SignColumn',    '#808080', 'NONE',    '244', 'NONE', 'NONE')
call s:Hi('EndOfBuffer',   '#303030', 'NONE',    '236', 'NONE', 'NONE')
call s:Hi('VertSplit',     '#585858', 'NONE',    '240', 'NONE', 'NONE')
call s:Hi('WinSeparator',  '#585858', 'NONE',    '240', 'NONE', 'NONE')
call s:Hi('StatusLine',    '#b2b2b2', '#303030', '249', '236',  'bold')
call s:Hi('StatusLineNC',  '#626262', '#303030', '241', '236',  'NONE')
call s:Hi('TabLine',       '#808080', '#303030', '244', '236',  'NONE')
call s:Hi('TabLineFill',   '#626262', '#303030', '241', '236',  'NONE')
call s:Hi('TabLineSel',    '#b2b2b2', '#303030', '249', '236',  'bold')
call s:Hi('Pmenu',         '#b2b2b2', '#303030', '249', '236',  'NONE')
call s:Hi('PmenuSel',      '#ffd75f', '#585858', '221', '240',  'bold')
call s:Hi('PmenuSbar',     'NONE',    '#303030', 'NONE','236',  'NONE')
call s:Hi('PmenuThumb',    'NONE',    '#626262', 'NONE','241',  'NONE')
call s:Hi('Visual',        'NONE',    '#585858', 'NONE','240',  'NONE')
call s:Hi('Search',        '#1c1c1c', '#ffd75f', '234', '221',  'bold')
call s:Hi('IncSearch',     '#1c1c1c', '#ffaf00', '234', '214',  'bold')
call s:Hi('MatchParen',    '#ffd75f', '#303030', '221', '236',  'bold')
call s:Hi('Folded',        '#808080', '#303030', '244', '236',  'NONE')
call s:Hi('FoldColumn',    '#626262', 'NONE',    '241', 'NONE', 'NONE')
call s:Hi('Directory',     '#87afd7', 'NONE',    '110', 'NONE', 'bold')
call s:Hi('Title',         '#b2b2b2', 'NONE',    '249', 'NONE', 'bold')
call s:Hi('ErrorMsg',      '#ff5f5f', 'NONE',    '203', 'NONE', 'bold')
call s:Hi('WarningMsg',    '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('MoreMsg',       '#87af87', 'NONE',    '108', 'NONE', 'bold')
call s:Hi('Question',      '#87afd7', 'NONE',    '110', 'NONE', 'bold')
call s:Hi('NonText',       '#585858', 'NONE',    '240', 'NONE', 'NONE')
call s:Hi('SpecialKey',    '#585858', 'NONE',    '240', 'NONE', 'NONE')
call s:Hi('Whitespace',    '#585858', 'NONE',    '240', 'NONE', 'NONE')

" Syntax
call s:Hi('Comment',       '#626262', 'NONE',    '241', 'NONE', 'NONE')
call s:Hi('Constant',      '#d7af87', 'NONE',    '180', 'NONE', 'NONE')
call s:Hi('String',        '#d7af87', 'NONE',    '180', 'NONE', 'NONE')
call s:Hi('Character',     '#d7af87', 'NONE',    '180', 'NONE', 'NONE')
call s:Hi('Number',        '#ffaf00', 'NONE',    '214', 'NONE', 'NONE')
call s:Hi('Boolean',       '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('Float',         '#ffaf00', 'NONE',    '214', 'NONE', 'NONE')
call s:Hi('Identifier',    '#87afd7', 'NONE',    '110', 'NONE', 'NONE')
call s:Hi('Function',      '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('Statement',     '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('Conditional',   '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('Repeat',        '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('Label',         '#ffd75f', 'NONE',    '221', 'NONE', 'NONE')
call s:Hi('Operator',      '#afafaf', 'NONE',    '145', 'NONE', 'NONE')
call s:Hi('Keyword',       '#ffaf00', 'NONE',    '214', 'NONE', 'bold')
call s:Hi('Exception',     '#ff5f5f', 'NONE',    '203', 'NONE', 'bold')
call s:Hi('PreProc',       '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('Include',       '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('Define',        '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('Macro',         '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('PreCondit',     '#5fd7ff', 'NONE',    '81',  'NONE', 'NONE')
call s:Hi('Type',          '#87af87', 'NONE',    '108', 'NONE', 'NONE')
call s:Hi('StorageClass',  '#87af87', 'NONE',    '108', 'NONE', 'bold')
call s:Hi('Structure',     '#87af87', 'NONE',    '108', 'NONE', 'bold')
call s:Hi('Typedef',       '#87af87', 'NONE',    '108', 'NONE', 'bold')
call s:Hi('Special',       '#ff5f5f', 'NONE',    '203', 'NONE', 'NONE')
call s:Hi('SpecialChar',   '#ff5f87', 'NONE',    '204', 'NONE', 'NONE')
call s:Hi('Tag',           '#87afd7', 'NONE',    '110', 'NONE', 'bold')
call s:Hi('Delimiter',     '#808080', 'NONE',    '244', 'NONE', 'NONE')
call s:Hi('SpecialComment','#808080', 'NONE',    '244', 'NONE', 'NONE')
call s:Hi('Debug',         '#ff5f5f', 'NONE',    '203', 'NONE', 'bold')
call s:Hi('Underlined',    '#5fd7ff', 'NONE',    '81',  'NONE', 'underline')
call s:Hi('Ignore',        '#585858', 'NONE',    '240', 'NONE', 'NONE')
call s:Hi('Error',         '#ff5f5f', 'NONE',    '203', 'NONE', 'bold')
call s:Hi('Todo',          '#1c1c1c', '#ffd75f', '234', '221',  'bold')

" Diff
call s:Hi('DiffAdd',       '#87d787', '#1c3a1c', '114', '22',   'NONE')
call s:Hi('DiffChange',    '#ffd75f', '#303030', '221', '236',  'NONE')
call s:Hi('DiffDelete',    '#ff5f87', '#3a1c1c', '204', '52',   'NONE')
call s:Hi('DiffText',      '#ffd75f', '#5f5f00', '221', '58',   'bold')

" Diagnostics / spelling
call s:Hi('DiagnosticError', '#ff5f5f', 'NONE', '203', 'NONE', 'bold')
call s:Hi('DiagnosticWarn',  '#ffaf00', 'NONE', '214', 'NONE', 'bold')
call s:Hi('DiagnosticInfo',  '#87afd7', 'NONE', '110', 'NONE', 'NONE')
call s:Hi('DiagnosticHint',  '#87af87', 'NONE', '108', 'NONE', 'NONE')
call s:Hi('SpellBad',        '#ff5f5f', 'NONE', '203', 'NONE', 'underline')
call s:Hi('SpellCap',        '#5fd7ff', 'NONE', '81',  'NONE', 'underline')
call s:Hi('SpellRare',       '#ffaf00', 'NONE', '214', 'NONE', 'underline')
call s:Hi('SpellLocal',      '#87af87', 'NONE', '108', 'NONE', 'underline')

" Language focus: C / C++ / Python
call s:Hi('cIncluded',       '#afafaf', 'NONE', '145', 'NONE', 'NONE')
call s:Hi('cppAccess',       '#afafaf', 'NONE', '145', 'NONE', 'bold')
call s:Hi('cppCast',         '#ffaf00', 'NONE', '214', 'NONE', 'bold')
call s:Hi('cppModifier',     '#87af87', 'NONE', '108', 'NONE', 'bold')
call s:Hi('cppModule',       '#5fd7ff', 'NONE', '81',  'NONE', 'bold')
call s:Hi('pythonBuiltin',   '#afafaf', 'NONE', '145', 'NONE', 'NONE')
call s:Hi('pythonDecorator', '#87afd7', 'NONE', '110', 'NONE', 'bold')
call s:Hi('pythonDecoratorName', '#5fd7ff', 'NONE', '81', 'NONE', 'bold')
call s:Hi('pythonExceptions', '#87af87', 'NONE', '108', 'NONE', 'bold')
call s:Hi('pythonAsync',     '#ffd75f', 'NONE', '221', 'NONE', 'bold')
