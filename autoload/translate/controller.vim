function! translate#controller#init_variables()
    if !exists('g:translate_to_lang')
        let g:translate_to_lang = 'en'
    endif
    if !exists('g:translate_from_lang')
        let g:translate_from_lang = 'ja'
    endif
endfunction

function! translate#controller#buffer_mode()
    let lines = getline(0, '$')
    let response_list = []
    for line in lines
        let response = microsoft#api#translator(
        \  g:translate_from_lang,
        \  g:translate_to_lang, line)
        call add(response_list, response)
    endfor
    call translate#interface#parse_response(response_list)
endfunction
