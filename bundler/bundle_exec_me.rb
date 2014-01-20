# Bundle exec automatically does `require 'bundler/setup'` for us,
# which requires the `Bundler` constant available and does `Bundler.setup`.
#require 'bundler/setup'

begin Haml; rescue NameError; else raise; end
begin Faker; rescue NameError; else raise; end

Bundler.require
Haml
# Not required because of the require: false on the Gemfile:
begin Faker; rescue NameError; else raise; end

require 'faker'
Faker
