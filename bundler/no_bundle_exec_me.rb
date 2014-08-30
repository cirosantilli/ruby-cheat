#!/usr/bin/env ruby

begin Haml;    rescue NameError; else raise; end
begin Faker;   rescue NameError; else raise; end
begin Bundler; rescue NameError; else raise; end
# The result of this assertions depends on wether you have the
# faker installed on the shared system or not.
# If you don't, it passes.
#begin require 'faker'; rescue LoadError; else raise; end

# Requires the global `Bundler` and does `Bundler.setup`.
# Bundler must of course be globally installed
# since we use it with `bundle install` before anything is istalled.
require 'bundler/setup'

begin Haml;  rescue NameError; else raise; end
begin Faker; rescue NameError; else raise; end

Bundler.require
Haml
begin Faker; rescue NameError; else raise; end

# Require possible because `Bundler.setup` was done.
require 'faker'
Faker
