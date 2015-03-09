function! translate#interface#translate()
    call translate#controller#init_variables()
    call translate#interface#window_open(g:translate_from_lang, g:translate_to_lang)
endfunction

function! translate#interface#window_open(from, to)
    let s:prev_buffer_nr = bufnr('%')
    execute 'botright 7new Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
    execute 'vnew Language:\ ' . a:from
    call translate#interface#from_window_setting(a:from)
endfunction

function! translate#interface#to_window_open(to)
    let s:prev_buffer_nr = bufnr('%')
    execute 'botright 7new Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
endfunction

function! translate#interface#to_window_setting(to)
    let s:to_buffer_nr = bufnr('%')
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn nomodifiable
    let w:to_lang = a:to
    let w:window_type = 'translate'
endfunction

function! translate#interface#from_window_setting(from)
    let s:from_buffer_nr = bufnr('%')
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn
    let w:from_lang = a:from
    let w:window_type = 'translate'
    autocmd InsertLeave <buffer> call translate#controller#buffer_mode()
    execute 'startinsert'
endfunction

function! translate#interface#window_close()
    for b in range(1, bufnr('$'))
        let wintype = getwinvar(bufwinnr(b), 'window_type', '')
        if wintype ==# 'translate'
            execute bufwinnr(b) . 'wincmd w'
            execute 'q'
        endif
    endfor
endfunction

function! translate#interface#parse_response(response_list)
    let xml = vital#of('microsoft_translate').import('Web.XML')

    execute bufwinnr(s:to_buffer_nr) . 'wincmd w'
    setlocal modifiable

    let linecount = len(getline(0, '$'))
    let i = 0
    while i < linecount
        execute 'delete'
        let i = i + 1
    endwhile

    let lines = []
    for response in a:response_list
        let parsed = xml.parse(response.content)
        call add(lines, parsed['child'][0])
    endfor
    call setline('.', lines)

    setlocal nomodifiable
    execute bufwinnr(s:from_buffer_nr) . 'wincmd w'
endfunction
