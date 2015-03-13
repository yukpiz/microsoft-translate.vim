function! translate#interface#text_window_open(from, to, text)
    let s:prev_buffer_nr = bufnr('%')
    call translate#interface#window_close()
    execute 'botright 7new To\ Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
    execute 'vnew From\ Language:\ ' . a:from
    call translate#interface#from_window_setting(a:from)
    call setline('.', a:text)
    execute 'stopinsert'
    call translate#controller#buffer_mode()
endfunction

function! translate#interface#window_open(from, to)
    let s:prev_buffer_nr = bufnr('%')
    call translate#interface#window_close()
    execute 'botright 7new To\ Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
    execute 'vnew From\ Language:\ ' . a:from
    call translate#interface#from_window_setting(a:from)
endfunction

function! translate#interface#to_window_open(to)
    let s:prev_buffer_nr = bufnr('%')
    call translate#interface#window_close()
    execute 'botright 7new To\ Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
endfunction

function! translate#interface#to_window_setting(to)
    let s:to_buffer_nr = bufnr('%')
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn nomodifiable
    let w:to_lang = a:to
    let w:window_type = {'type': 'translate', 'name': 'translate_to'}
endfunction

function! translate#interface#from_window_setting(from)
    let s:from_buffer_nr = bufnr('%')
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn
    let w:from_lang = a:from
    let w:window_type = {'type': 'translate', 'name': 'translate_from'}
    autocmd InsertLeave <buffer> call translate#controller#buffer_mode()
    execute 'startinsert'
endfunction

function! translate#interface#window_refresh()
    for b in range(1, bufnr('$'))
        let wintype = getwinvar(bufwinnr(b), 'window_type', {})
        if wintype ==# {} || !has_key(wintype, 'type')
            continue
        endif
        if wintype['name'] ==# 'translate_from'
            execute bufwinnr(b) . 'wincmd w'
            execute 'silent file From\ Language:\ ' . g:translate_from_lang
        elseif wintype['name'] ==# 'translate_to'
            execute bufwinnr(b) . 'wincmd w'
            execute 'silent file To\ Language:\ ' . g:translate_to_lang
        endif
    endfor
endfunction

function! translate#interface#force_to_window_refresh(to)
    for b in range(1, bufnr('$'))
        let wintype = getwinvar(bufwinnr(b), 'window_type', {})
        if wintype ==# {} || !has_key(wintype, 'type')
            continue
        endif
        if wintype['name'] ==# 'translate_to'
            execute bufwinnr(b) . 'wincmd w'
            execute 'silent file To\ Language:\ ' . a:to
        endif
    endfor
endfunction

function! translate#interface#window_close()
    for b in range(1, bufnr('$'))
        let wintype = getwinvar(bufwinnr(b), 'window_type', {})
        if wintype ==# {} || !has_key(wintype, 'type')
            continue
        endif
        if wintype['type'] ==# 'translate'
            execute bufwinnr(b) . 'wincmd w'
            execute 'q'
        endif
    endfor
endfunction

function! translate#interface#to_window_set(lines)
    execute bufwinnr(s:to_buffer_nr) . 'wincmd w'
    setlocal modifiable

    let linecount = len(getline(0, '$'))
    let i = 0
    while i < linecount
        execute 'delete'
        let i = i + 1
    endwhile

    call setline('.', a:lines)

    setlocal nomodifiable
    execute bufwinnr(s:from_buffer_nr) . 'wincmd w'
endfunction
