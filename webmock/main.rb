#!/usr/bin/env ruby

require 'net/http'
require 'webrick'

require 'webmock'

# Setup a test server to differentiate form the mocks.

  port = 4000
  domain = "http://localhost:#{port}"
  path = '/'
  url = domain + path
  body = 'thebody'
  body_mock = body + 'a'
  body_mock2 = body_mock + 'a'
  status = 200
  status_mock = status + 1

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

# Helpers

  def assert_not_allowed(url)
    begin
      Net::HTTP.get_response(URI(url))
    rescue WebMock::NetConnectNotAllowedError
    else
      raise
    end
  end

  def assert_body(url, body)
    Net::HTTP.get_response(URI(url)).body == body or raise
  end

##with

  # Determines what is required for the stub to be used.

##to_return

  # Sets the response if the request gets stubbed.

    stub = WebMock::API.stub_request(:get, url)
      .to_return(status: status_mock, body: body_mock)
    res = Net::HTTP.get_response(URI(url))
    res.code == status_mock.to_s or raise
    res.body == body_mock or raise
    WebMock::API.remove_request_stub(stub)

  ##disable_net_connect

  ##allow_net_connect

    # By default, any request that does match a mock is disabled and raises an exception:

    # This can be changed with `allow_net_connect`.

      assert_not_allowed(url)
      WebMock.allow_net_connect!
      assert_body(url, body)
      stub = WebMock::API.stub_request(:get, url).to_return(body: body_mock)
      assert_body(url, body_mock)
      WebMock::API.remove_request_stub(stub)
      WebMock.disable_net_connect!
      assert_not_allowed(url)

##remove_request_stub

  # Remove stub.

    stub = WebMock::API.stub_request(:get, url).to_return(body: body_mock)
    WebMock::API.remove_request_stub(stub)
    begin
      Net::HTTP.get_response(URI(url))
    rescue WebMock::NetConnectNotAllowedError
    else
      raise
    end

# Stubs can be used any number of times:

  stub = WebMock::API.stub_request(:get, url).to_return(body: body_mock)
  WebMock::API.remove_request_stub(stub)

# Multiple stubs can be defined. The last one wins.

stub = WebMock::API.stub_request(:get, url)
  .to_return(status: status_mock, body: body_mock2)
Net::HTTP.get_response(URI(url)).body == body_mock2 or raise
