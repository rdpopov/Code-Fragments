" Contents:
"
" This is something that is really niche. It is a langauge switcher. In
" simple terms, you have to define a list of languages that you want to cycle
" between and you can. It is mostly useless since most people use vim with
" english, but i want to use it with my native languge, and i  want to use it
" while not switching language every 3 seconds to do vim commands, and i only
" have the input i want in insert mode and vhen searching, while keeping the
" ability to use command mode and shortcuts normally
"
" I even have integrated it into my lightline and have provided a
" variable/function to show what language its currently in
"
"

if !exists("g:lang")
    let g:lang = ['english']
endif

let s:crnt_lang = 0

" Truncate current language to a 3-letter based string (+ 3-letter for every '-'
" in it each '-' separated word is considered a new word)
function! GetLangLabl()
    let s:cut  = split(g:lang[s:crnt_lang],'-')
    let s:res = []
    for part in s:cut
        let s:res = s:res + [toupper(part[0:2])]
    endfor
    return join(s:res,'-')
endfunction

let g:langid = GetLangLabl()

" Meant for getting the current language form the list, for lightline and similar
function! GetInputLang()
    return g:langid
endfunction

" Cycles to the next language in the list
function! CycleLanguagesUp()
    let s:len = len(g:lang)
    let s:crnt_lang = (s:crnt_lang + 1 ) % s:len
    call SetKeymapTo(g:lang[s:crnt_lang])
endfunction

" Cycles to the previous language in the list
function! CycleLanguagesDown()
    let s:len = len(g:lang)
    if s:crnt_lang > 0
        let s:crnt_lang = (s:crnt_lang + 1 ) % s:len 
    else
        let s:crnt_lang = s:len - 1
    endif
    call SetKeymapTo(g:lang[s:crnt_lang])
endfunction

" Sets language to argument
" Thing is, that vim has no explicit setting for english
" english is default language but does not have a keymap=something setting 
" so keymap has to be set to the empty sting to reset it 
function! SetKeymapTo(lang)
    let s:lng = a:lang
    if a:lang == 'english'
        let s:lng = ""
    endif
    execute('set keymap='.s:lng)
    let g:langid = GetLangLabl()
endfunction
