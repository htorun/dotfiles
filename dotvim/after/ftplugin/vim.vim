setlocal foldmethod=expr
setlocal foldexpr=VimFileFoldExpr()
setlocal foldtext=VimFileFoldText()

setlocal foldcolumn=3    " default is 0
setlocal foldnestmax=5   " default is 20
hi Folded term=NONE cterm=NONE ctermbg=NONE gui=NONE

"set fillchars=vert:\|,fold:\ 
let &fillchars="vert:|,fold: "

function! VimFileFoldExpr()
    let patternSection1 = '^\s*"\s*=\{2,}\s*.\+\s*=\{2,}\s*$'
    let patternSection2 = '^\s*"\s*-\{2,}\s*.\+\s*-\{2,}\s*$'

    let line = getline(v:lnum)

    if match(line, patternSection1) > -1
        return ">1"
    endif

    if match(line, patternSection2) > -1
        return ">2"
    endif

    return "="
endfunction

function! VimFileFoldText()
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    if strchars(foldchar) < 1
        let foldchar = ' '
    endif

    let leftcolwidth = &foldcolumn
    if &number || &relativenumber
        let leftcolwidth += &numberwidth
    endif

    let availablewidth = winwidth(0) - leftcolwidth
    if availablewidth > 95
        let availablewidth = 95
    endif

    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '(' . lines_count . ' lines) '

    let line = getline(v:foldstart)
    let linepre = '+'

    let pattern = '^\s*"\s*\|\s*["*-=]\{2,}\s*'
    let line = substitute(line, pattern, '', 'g')

    " indent according to foldlevel
    let linepre .= repeat('-', v:foldlevel * 2) . ' '

    let linepost= ' ' . lines_count_text
    let foldtextlength = strdisplaywidth(linepre . line . linepost)

    let widthdiff = availablewidth - foldtextlength

    if widthdiff < 1
        return strpart(linepre . line . linepost, 0, availablewidth - 1)
    endif

    return linepre . line . repeat(foldchar, widthdiff) . linepost
endfunction
