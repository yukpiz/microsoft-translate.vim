function! microsoft#oauth#access_token()
    let access_url = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
    let access_client_id = 'microsoft-translate'
    let access_client_secret = 'dhP5Dnqx2Y2JIR2BS8pH+k+Q2jP2yPmZtO2C5kcDSh4='
    let access_scope = 'http://api.microsofttranslator.com'
    let access_grant_type = 'client_credentials'

    let access_token_post_parameters = {
    \  'client_id': access_client_id,
    \  'client_secret': access_client_secret,
    \  'scope': access_scope,
    \  'grant_type': access_grant_type,
    \}

    try
        let http = vital#of('vital').import('Web.HTTP')
        let response = http.post(access_url, access_token_post_parameters)
        if response !=# {}
            if response['status'] ==# '200'
                let json = vital#of('vital').import('Web.JSON')
                let decoded = json.decode(response.content)
                return decoded['access_token']
            else
                throw 'Bad Request'
            endif
        else
            throw 'Empty Response'
        endif
    catch /Bad Request/
        echo 'Bad Request'
    catch /Empty Response/
        echo 'Empty Response.'
    endtry
endfunction
