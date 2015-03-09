" :MSTranslateWord
" :MSTranslate
"
"

command! -nargs=0 MicrosoftTranslateOpen :call translate#interface#translate()

command! -nargs=0 MicrosoftTranslateClose :call translate#interface#window_close()
