function! translate#controller#init_variables()
    if !exists('g:translate_to_lang')
        let g:translate_to_lang = 'ja'
    endif
    if !exists('g:translate_from_lang')
        let g:translate_from_lang = 'auto'
    endif
    if !exists('g:translate_lang_relation')
        let g:translate_lang_relation = {
        \  'en': 'ja',
        \  'ja': 'en',
        \  'etc': 'ja',
        \}
    endif
endfunction

function! translate#controller#set_lang(from, to)
    let g:translate_from_lang = a:from
    let g:translate_to_lang = a:to
    call translate#interface#window_refresh()
endfunction

function! translate#controller#set_from_lang(from)
    let g:translate_from_lang = a:from
    call translate#interface#window_refresh()
endfunction

function! translate#controller#set_to_lang(to)
    let g:translate_to_lang = a:to
    call translate#interface#window_refresh()
endfunction

function! translate#controller#buffer_mode()
    let lines = getline(0, '$')
    let word_list = []
    for line in lines
        if line ==# '' || strlen(line) == 0
            continue
        endif
        let word = microsoft#api#word_translator(
        \  g:translate_from_lang,
        \  g:translate_to_lang, line)
        call add(word_list, word)
    endfor
    call translate#interface#to_window_set(word_list)
endfunction

function! translate#controller#default_mode()
    call translate#controller#init_variables()
    call translate#interface#window_open(g:translate_from_lang, g:translate_to_lang)
endfunction

function! translate#controller#args_mode(...)
    call translate#controller#init_variables()
    let i = 1
    let strline = ''
    while i <= a:0
        let strline = strline ==# '' ? get(a:, i, '') : strline . ' ' . get(a:, i, '')
        let i = i + 1
    endwhile
    call translate#interface#text_window_open(g:translate_from_lang, g:translate_to_lang, strline)
endfunction

function! translate#controller#textobj_mode()
    call translate#controller#init_variables()
    let word = expand('<cword>')
    call translate#interface#text_window_open(g:translate_from_lang, g:translate_to_lang, word)
endfunction

function! translate#controller#visual_mode()
    call translate#controller#init_variables()
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    let lines = split(selected, '\n')
    call translate#interface#text_window_open(g:translate_from_lang, g:translate_to_lang, lines)
endfunction
