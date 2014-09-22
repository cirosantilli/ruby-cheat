#!/usr/bin/env ruby

require 'rack'

App = Proc.new do |env|
    ['200', {'Content-Type' => 'text/plain'}, ['A barebones rack app.']]
end

Rack::Handler::WEBrick.run App
