const http = require('http');
const url = require('url');

const port = process.argv[2] ?? 8080

const server = http.createServer((req, res) => {
  const ip = req.headers['x-forwarded-for'] ?? (
    req.socket.remoteAddress ??
    "unknown"
  )

  console.log(`[${ip}] ${req.method} - ${req.url}`)

  const msg = url.parse(req.url, true).query?.message ?? "pong"

  res.statusCode = 200
  res.setHeader('cache-control', 'no-cache')
  res.setHeader('content-type', 'text/plain')
  res.end(msg)
});

server.listen(port, () => {
  console.log(`listen on :${port}`);
});
