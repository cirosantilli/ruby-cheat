# Rack

Standard Ruby SGI interface.

Source: <https://github.com/jnicklas/capybara>

Documentation: <http://rubydoc.info/github/jnicklas/capybara>

TODO what are Phusion Passenger, Litespeed, Mongrel, Thin, Ebb, WEBrick etc.
and why are they needed with Rack?

Main Gem that implements the Rack standard: <https://github.com/rack/rack>

## Usage

One liner sanity check:

    ruby -Ilib lib/rack/lobster.rb

### rackup

### config.ru

Configuration file for `rackup`:

    bundle exec rackup &
    firefox localhost:9292

This is called a *rackup file*.

This is a convenient way to start a server from the command line.

## WEBrick

Part of the stdlib: <http://ruby-doc.org/stdlib-2.1.2/libdoc/webrick/rdoc/WEBrick.html>
