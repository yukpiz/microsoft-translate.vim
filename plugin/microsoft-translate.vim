command! -nargs=0 MSTranslateClose :call translate#interface#window_close()
command! -nargs=0 MSTranslate :call translate#controller#default_mode()
command! -nargs=* MSTranslateArgs :call translate#controller#args_mode(<f-args>)
command! -nargs=0 MSTranslateWord :call translate#controller#textobj_mode()
command! -nargs=0 -range MSTranslateVisual :call translate#controller#visual_mode()

