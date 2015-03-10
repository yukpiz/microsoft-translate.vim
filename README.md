# microsoft-translate.vim

## Description

This plug-in is for using Microsoft Translator.

* With so many languages can be translated.
* Automatic language detection is possible.


## Installation

After writing to the ``~/.vimrc``, and please run the ``:NeoBundleInstall``

~~~
NeoBundle "yukpiz/microsoft-translate.vim"
~~~


## Usage

Need options,
~~~
It is a language that is based on that used in the translation, and automatically determined when you input 'auto'.
let g:translate_from_lang = 'en'
let g:translate_to_lang = 'ja'
~~~

Open the translation window run the ``:MSTranslate`` Command.
After entering, It is the translated when leaving the insert mode.

Other commands,
~~~
:MSTranslateArgs

    TODO


:MSTranslateWord

    TODO


:MSTranslateVisual

    TODO


:MSTranslateSetLang ja en

~~~








## Thanks

* [vim-jp/vital.vim](https://github.com/vim-jp/vital.vim)


## License and Author

* yukpiz <yukpiz@gmail.com>
