function! translate#interface#window_open(from, to)
    let s:prev_window_nr = winnr()
    execute 'botright 7new Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
    execute 'vnew Language:\ ' . a:from
    call translate#interface#from_window_setting(a:from)
endfunction

function! translate#interface#to_window_open(to)
    let s:prev_window_nr = winnr()
    execute 'botright 7new Language:\ ' . a:to
    call translate#interface#to_window_setting(a:to)
endfunction

function! translate#interface#to_window_setting(to)
    let s:to_window_nr = winnr()
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn nomodifiable
    let w:to_lang = a:to
    let w:window_type = 'translate'
endfunction

function! translate#interface#from_window_setting(from)
    let s:from_window_nr = winnr()
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
