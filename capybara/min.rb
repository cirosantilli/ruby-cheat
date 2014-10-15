#!/usr/bin/env ruby

# When you're about to scream in desperation, come back here.

require 'capybara'
require 'capybara/poltergeist'

Capybara.app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, [File.read('index.html')]]
end

class CapybaraTest
  include Capybara::DSL

  def run
  end
end

CapybaraTest.new.run
