# Rack

Rack is two things:

-   the de-facto standard Ruby SGI interface.

    It has several implementations, including a WEBrick (stdlib), adapter on the Gem
    Apache modules, Nginx modules, Phusion, Litespeed, Mongrel, etc.

    Used by all major Ruby web frameworks: Rails, Sinatra, etc.

    The advantage of the standard is obvious: programs you write can then be with in any server.

-   a Gem which implements lot's of convenience functionality for Rack.

    For instance, the Gem adapts Rack IO to WEBrick, the stdlib server.

Both the gem and the protocol are maintained at: <https://github.com/rack/rack>

### rackup

### config.ru

`rackup` is a command provided by the `rack` gem to conveniently start a Rack application.

`config.ru` is the configuration file for `rackup`:

Try it out with:

    bundle exec rackup &
    firefox localhost:9292

This is called a *rackup file*.

This is a convenient way to start a server from the command line.
