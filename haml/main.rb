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

def r(input, locals = {}, instance = Object.new, engine_options = {})
  Haml::Engine.new(input, engine_options).render(instance, locals)
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

##pre

##textarea

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

##Line contiuation

  # Possible:
  #
  # - after commas
  # - adding extra pipes `|` for all lines, including the last one.

    r(<<EOF) == "<p a='0' b='1'></p>\n" or raise
%p{a: 0,
   b: 1}
EOF

    r(<<EOF) == "2\n" or raise
= 1 + |
  1   |
EOF

##XSS

##XSS

  # Plain tags never get escaped:

    r(<<EOF, {}, Object.new, {escape_html: false}) == "<br>\n" or raise
<br>
EOF

    r(<<EOF, {}, Object.new, {escape_html: true}) == "<br>\n" or raise
<br>
EOF

  # What `=` and `#{}` do is determined by `escape_html`.

    r(<<'EOF', {}, Object.new, {escape_html: false}) == "<br>\n" or raise
#{'<br>'}
EOF

    r(<<'EOF', {}, Object.new, {escape_html: true}) == "&lt;br&gt;\n" or raise
#{'<br>'}
EOF

  # `:preserve` ignores `escape_html` so it is a threat zone.

    r(<<'EOF', {}, Object.new, {escape_html: true}) == "<br>\n" or raise
:preserve
  #{'<br>'}
EOF

  # `%pre` and `preserve` are not affected:

    p r(<<'EOF', {}, Object.new, {escape_html: true}) == "<br>\n" or raise
!= preserve do
  #{'<br>'}
EOF

    r(<<'EOF', {}, Object.new, {escape_html: true}) == "<br>\n" or raise
%pre
  #{'<br>'}
EOF
