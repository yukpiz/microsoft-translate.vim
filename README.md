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
"It is a language that is based on that used in the translation,
"And automatically determined when you input 'auto'.
let g:translate_from_lang = 'en'
"It is a language that is target on that used in the translation.
let g:translate_to_lang = 'ja'
~~~

Open the translation window run the ``:MSTranslate`` Command.
After entering, It is the translated when leaving the insert mode.

Other commands,
~~~
"Translate arguments.
:MSTranslateArgs {text}

"Translate the text object at the cursor position.
:MSTranslateWord

"Translate by Visual mode selection.
:MSTranslateVisual

"Changing the language options.
:MSTranslateSetLang ja en
:MSTranslateSetFromLang ja
:MSTranslateSetToLang en
~~~


## Thanks

* [vim-jp/vital.vim](https://github.com/vim-jp/vital.vim)


## License and Author

* yukpiz \<yukpiz@gmail.com\>
