#!/usr/bin/env ruby

require 'net/http'
require 'webrick'

# Nice cheatsheet at: https://github.com/augustl/net-http-cheat-sheet

port = 4000
body = 'thebody'
status = 200

server = WEBrick::HTTPServer.new(Port: port,
  AccessLog: [], Logger: WEBrick::Log.new('/dev/null'))
trap :INT do server.shutdown end
pid = fork
unless pid
  server.mount_proc('/') do |req, res|
    res.status = status
    res.body = body
  end
  server.start
  Process.exit(0)
end
at_exit { Process.kill(:INT, pid) }

res = Net::HTTP.get_response(URI("http://localhost:#{port}/"))
res.code == status.to_s or raise
res.body == body or raise
