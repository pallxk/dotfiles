$httpClient.get('https://ipinfo.io', function (error, response, data) {
  const ipinfo = JSON.parse(data)
  $done({
    title: `IP: (${(new Date).toLocaleString()})`,
    content: JSON.stringify(ipinfo, null, 2),
  })
})
