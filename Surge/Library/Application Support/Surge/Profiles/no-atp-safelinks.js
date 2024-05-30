// https://www.o365atp.com/
// https://manual.nssurge.com/scripting/common.html
// https://manual.nssurge.com/scripting/http-response.html

const paramUrl = new URL($request.url).searchParams.get('url')
const targetUrl = decodeURIComponent(paramUrl)
const headers = $response.headers
headers['Location'] = targetUrl
$done({status: 302, headers})
