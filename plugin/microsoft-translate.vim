command! -nargs=0 MSTranslateClose :call translate#interface#window_close()
command! -nargs=0 MSTranslate :call translate#controller#default_mode()
command! -nargs=* MSTranslateArgs :call translate#controller#args_mode(<f-args>)
command! -nargs=0 MSTranslateWord :call translate#controller#textobj_mode()
command! -nargs=0 -range MSTranslateVisual :call translate#controller#visual_mode()

command! -nargs=* MSTranslateSetLang :call translate#controller#set_lang(<f-args>)
command! -nargs=1 MSTranslateSetFromLang :call translate#controller#set_from_lang(<f-args>)
command! -nargs=1 MSTranslateSetToLang :call translate#controller#set_to_lang(<f-args>)
