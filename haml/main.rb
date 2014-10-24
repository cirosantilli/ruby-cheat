#!/usr/bin/env ruby

require 'haml'

# Test template:

=begin

p r(<<EOF)
%
EOF

=end

##render

  # Pass locals:

    Haml::Engine.new('= a').render(Object.new, {a: 0}) == "0\n" or raise

def r(input, locals = {}, instance = Object.new)
  Haml::Engine.new(input).render(instance, locals)
end

r('%p a') == "<p>a</p>\n" or raise

##Ruby Blocks

  # Lines that would render outside of the block also render inside of it,
  # before the block's return value is rendered if called with `=`.

  # TODO where does the return value come from?

    class Blocks
      def f
        yield
      end
    end

    #r(<<EOF, {}, Blocks.new) == "1\n" or raise
#- f do
  #1
#EOF

    #r(<<EOF, {}, Blocks.new) == "1\n2\n" or raise
#- f do
  #1
  #2
#EOF


    #r(<<EOF, {}, Blocks.new) == "0\n10\n" or raise
#= f do
  #0
#EOF

    #p r(<<EOF, {}, Blocks.new)
#= f do
  #2
  #1
#EOF

    #r(<<EOF, {}, Blocks.new) == "<p>a</p>\n0\n" or raise
#= f do
  #%p a
#EOF

##Pre

##Textarea

  # Those tags are magic: <http://haml.info/docs/yardoc/file.REFERENCE.html#whitespace_preservation>

    r(<<EOF) == "<pre>ab</pre>\n" or raise
%pre
  = 'a'
  = 'b'
EOF

    r(<<EOF) == "<div>\n  a\n  b\n</div>\n" or raise
%div
  = 'a'
  = 'b'
EOF
