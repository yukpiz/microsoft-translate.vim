function! microsoft#translate#trans(from, to, text)
    let token = microsoft#oauth#access_token()

    let trans_url = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'
    let trans_get_parameters = {
    \  'text': a:text,
    \  'from': a:from,
    \  'to': a:to,
    \}

    let trans_get_headers = {
    \  'Authorization': 'Bearer ' . token,
    \}

    let http = vital#of('vital').import('Web.HTTP')
    return http.get(trans_url, trans_get_parameters, trans_get_headers)
endfunction

