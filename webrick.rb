#!/usr/bin/env ruby

require 'net/http'
require 'webrick'

port = 4000

# Simple HTTP server from the stdlib:
# <http://ruby-doc.org/stdlib-2.1.1/libdoc/webrick/rdoc/WEBrick.html>
#
# Not to be used in production.
#
# Default development server for Rails.
#
# Not directly Rack compatible, but the rack gem has an adapter which allows
# to use it as a rack compatible interface.
#
# You can run WEBrick conveniently from the command line with:
#
#     ruby -run -e httpd . -p 9090
#
# This works because `-r` loads the `un` convenience library which offers the `httpd` function
# <http://ruby-doc.org/stdlib-2.1.3/libdoc/un/rdoc/index.html>

case '##automatic'
#case '##interactive'
when '##automatic'

  # Automatic tests will be done with an explicit `fork` to the brackground

  # Linux specific and done behind the scenes by `Daemon`.

  # The advantage of this method over `Dameon` is that you don't need a `pid` file
  # as you can retrieve the pid from fork.

  # This will allow us to do automated tests easily and then kill the server.

  body = 'thebody'
  status = 200

  ##HTTPServer

    # This command will already bind to the port:

      server = WEBrick::HTTPServer.new(Port: port, BindAddress: '0.0.0.0',
        AccessLog: [], Logger: WEBrick::Log.new('/dev/null'))

    # Options:

    # -  Make WEBrick silent:
    #    <http://stackoverflow.com/questions/6387087/disabling-echo-from-webrick>
    #
    #        AccessLog: [], Logger: WEBrick::Log.new('/dev/null')
    #
    # -  If you don't set a bind port, then the server will listen both on
    #    '0.0.0.0' (IPv4) and ':::0' (IPv6). It will only raise if both are occupied.
    #
    # The best way get a list of all options is to look at the source:
    # docs are currently incomplete.

  # WEBrick binds to both TCP and TCP6 ports by default.
  # If both of them are occupied, then it raises.
  # If only one of them is occupied, it does not raise.

  ## Stop the server

    # By default the server will not stop on INT signals:
    # we have to explicitly code that:

      trap :INT do server.shutdown end

    # trap comes from Signal which is included by Kernel.

    # The trap must already have been called before forking because
    # the parent might execute the kill before the child runs.

  pid = fork
  unless pid

    ##mount_proc

    ##GCI
    server.mount_proc('/') do |req, res|
      res.status = status
      res.body = body
    end
    server.start
    Process.exit(0)
  end

  # Make sure that the server will be killed
  # or else the port won't be freed.
  at_exit { Process.kill(:INT, pid) }

  res = Net::HTTP.get_response(URI("http://localhost:#{port}/"))
  res.code == status.to_s or raise
  res.body == body or raise

when '##interactive'

  case '##CGI'
  when '##File server'
    #server = WEBrick::HTTPServer.new(Port: 4000, DocumentRoot: File.expand_path('.'))
  when '##CGI'
    server = WEBrick::HTTPServer.new(Port: port)
    server.mount_proc('/') do |req, res|
      res.status = 200
      res['Content-Type'] = 'text/plain'
      res.body = req.inspect
    end
  end

  trap :INT do server.shutdown end

  case '##Foreground'
  when '##Foreground'

    # Once started, the server will block the current process and bind to stdin and stdout. 

      server.start

    # Go and check it with your browser.

  when '##Daemon'

    # Perform standard Linux demonization calls and kill the current process:
    # nothing in front of this statement will ever get executed.

    # An optional block can be passed. A typical use is to save the PID to a file.
    # to kill it later on.

    # Linux specific since uses `fork`.

      cwd = Dir.getwd
      WEBrick::Daemon.start do
        File.write(File.join(cwd, 'webrick.pid'), Process.pid)
      end

    # It is still necessary to call `server.start`:

      server.start

    # Signal handlers are inherited by child processes so to stop the server
    # you can send the same signal as the handler that was set up at the parent
    # at `trap` with:

      #kill `cat webrick.pid`
      #Process.kill(:INT, File.read('webrick.pid').to_i)
  end
end
