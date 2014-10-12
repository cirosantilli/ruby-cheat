#!/usr/bin/env ruby

require 'haml'

# Test template:

=begin

puts r(<<EOF)
%
EOF

=end

def r(input)
  Haml::Engine.new(input).render
end

r('%p a') == "<p>a</p>\n" or raise

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
