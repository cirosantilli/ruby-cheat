#!/usr/bin/env ruby

# Embedded Ruby. Ruby inside HTML, much like PHP does by default.

# Documented at: http://ruby-doc.org/stdlib-2.1.1/libdoc/erb/rdoc/ERB.html

# Part of the Ruby stdlib, but it does not clearly specify the format:
# http://stackoverflow.com/questions/20910212/where-is-rubys-erb-format-officially-defined

# Both a Ruby API and an executable.

# CLI executable:

    #echo '<% a = 1; b = 2 %>a = <%= a %>, b = <%= b %><%# comment %>' | erb

# Output:

    #a = 1, b = 2

# Ruby usage:

    require 'erb'
    ERB.new('<% a = 1; b = 2 %>a = <%= a %>, '\
            'b = <%= b %><%# comment %>').result == 'a = 1, b = 2' or raise

# Conditionals:

    ERB.new('<% if false %>if<% elsif false  %>else if<% else %>else<% end %>').result == 'else' or raise

# Loop:

    ERB.new('<% (1..3).each do |n| %><%= n %> <% end %>').result == '1 2 3 ' or raise

## Newline removal

  # Newline removal: *must* pass the `-` trim option, otherwise exception.

      ERB.new("<%= 'a' %>\nb").result              == "a\nb"  or raise
      begin ERB.new("<%= 'a' -%>\nb").result; rescue SyntaxError ; else raise; end
      ERB.new("<%= 'a'  %>\nb"  , nil, '-').result == "a\nb"  or raise
      ERB.new("<%= 'a' -%>\nb"  , nil, '-').result == 'ab'    or raise
      ERB.new("<%= 'a' -%> \nb" , nil, '-').result == "a \nb" or raise
      ERB.new("<%= 'a' -%>\n b" , nil, '-').result == 'a b'   or raise
      ERB.new("<%= 'a' -%>\n\nb", nil, '-').result == "a\nb"  or raise

  # Remove white spaces before the tag until the newline,
  # but only if the line only contains whitespaces (before and after):

      ERB.new("a \n  <%- 0 %> b\n c", nil, '-').result == "a \n b\n c" or raise
      ERB.new("a \nb  <%- 0 %> c\n d", nil, '-').result == "a \nb   c\n d" or raise

  # `%-` and `-%` can be combined to have both effecs summed.
  # In particular, if the tag is the only thing in the line except for whitespace,
  # the line disappears:

      ERB.new("a \n  <%- 0 -%>\n b", nil, '-').result == "a \n b" or raise

  # Always remove trailing newlines with `<>`:

      ERB.new("a\n<%= 'b' %>\nc"  , nil, '<>').result == "a\nbc" or raise
