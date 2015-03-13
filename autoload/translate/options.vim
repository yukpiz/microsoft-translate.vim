function! translate#options#detect_to_lang(from)
    for key in keys(g:translate_lang_relation)
        if a:from ==# key
            return g:translate_lang_relation[key]
        endif
    endfor
    return g:translate_lang_relation['etc']
endfunction
