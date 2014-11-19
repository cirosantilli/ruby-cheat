# Rack

Rack is two things:

-   the de-facto standard Ruby to webserver interface.

    It has several implementations listed under
    <https://github.com/rack/rack/tree/dc53a8c26dc55d21240233b3d83d36efdef6e924/lib/rack/handler>,
    including a WEBrick (stdlib), CGI, FastCGI, etc.

    Used by all major Ruby web frameworks: Rails, Sinatra, etc.

    The advantage of the standard is obvious: programs you write can then be with in any server.

-   a Gem which implements lot's of convenience functionality for Rack.

    For instance, the Gem adapts Rack IO to WEBrick, the stdlib server.

Both the gem and the protocol are maintained at: <https://github.com/rack/rack>

## rackup

## config.ru

`rackup` is a command provided by the `rack` gem to conveniently start a Rack application.

`config.ru` is the configuration file for `rackup`:

Try it out with:

    bundle exec rackup &
    firefox localhost:9292

This is called a *rackup file*.

This is a convenient way to start a server from the command line.

## use

## Middleware

<http://www.rubydoc.info/github/rack/rack/Rack/Builder#use-instance_method>

<http://stackoverflow.com/questions/2256569/what-is-rack-middleware>

A rack app that wraps the main app. It can therefore pre and post process request and response from the main app.

Called middleware because it stands in the middle of the Ruby application and the server.

Advantage: functionality can be reused with any Rack framework, i.e. all important Ruby frameworks. This is the case for instance of Sprockets: <https://github.com/sstephenson/sprockets>

## Unicorn

<http://unicorn.bogomips.org/>

TODO who made it?

Popular Rack HTTP server.

Often used in production together behind Nginx.

Good for fast clients, Nginx deals with slow clients when on top of it.

POSIX only, as the POSIX API is critical for performance.

Introductory architecture review: <http://sirupsen.com/setting-up-unicorn-with-nginx/>

Start:

    bundle exec unicorn

Will read the `config.ru`.

Configuration file:

    bundle exec unicorn -c config/unicorn.rb
