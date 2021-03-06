function! microsoft#api#word_translator(from, to, text)
    let response = microsoft#api#translator(a:from, a:to, a:text)
    return microsoft#api#parse_response(response)
endfunction

function! microsoft#api#translator(from, to, text)
    let token = microsoft#oauth#access_token()

    let trans_url = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'

    let from = a:from
    let to = a:to

    if a:from ==# 'auto'
        let response = microsoft#api#detect(a:text)
        let from = microsoft#api#parse_response(response)

        let to = translate#options#detect_to_lang(from)
        call translate#interface#force_to_window_refresh(to)
    endif

    let trans_get_parameters = {
    \  'text': a:text,
    \  'from': from,
    \  'to': to,
    \}

    let trans_get_headers = {
    \  'Authorization': 'Bearer ' . token,
    \}

    let http = vital#of('microsoft_translate').import('Web.HTTP')
    return http.get(trans_url, trans_get_parameters, trans_get_headers)
endfunction

function! microsoft#api#detect(text)
    let token = microsoft#oauth#access_token()

    let detect_url = 'http://api.microsofttranslator.com/V2/Http.svc/Detect'
    let detect_get_parameters = {
    \  'text': a:text,
    \}

    let detect_get_headers = {
    \  'Authorization': 'Bearer '. token,
    \}

    let http = vital#of('microsoft_translate').import('Web.HTTP')
    return http.get(detect_url, detect_get_parameters, detect_get_headers)
endfunction

function! microsoft#api#parse_response(response)
    let xml = vital#of('microsoft_translate').import('Web.XML')
    return xml.parse(a:response.content)['child'][0]
endfunction
