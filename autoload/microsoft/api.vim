function! microsoft#api#word_translator(from, to, text)
    let response = microsoft#api#translator(a:from, a:to, a:text)
    return microsoft#api#parse_response(response)
endfunction

function! microsoft#api#translator(from, to, text)
    let token = microsoft#oauth#access_token()

    let trans_url = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'
    let from = a:from ==# 'auto' ? '' : a:from
    let trans_get_parameters = {
    \  'text': a:text,
    \  'from': from,
    \  'to': a:to,
    \}

    let trans_get_headers = {
    \  'Authorization': 'Bearer ' . token,
    \}

    let http = vital#of('microsoft_translate').import('Web.HTTP')
    return http.get(trans_url, trans_get_parameters, trans_get_headers)
endfunction

function! microsoft#api#parse_response(response)
    let xml = vital#of('microsoft_translate').import('Web.XML')
    return xml.parse(a:response.content)['child'][0]
endfunction
