#!/usr/bin/env ruby

require 'haml'

def r(input)
  Haml::Engine.new(input).render
end

r('%p a') == "<p>a</p>\n" or raise
