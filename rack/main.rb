#!/usr/bin/env ruby

require 'rack'

app = Proc.new do |env|
  [
    200,
    {
      'Content-Type' => 'text/plain'
    },
    [
      "PATH_INFO = #{env['PATH_INFO']}\n",
      Time.now.to_s
    ]
  ]
end

Rack::Handler::WEBrick.run(app, Port: 4000)
