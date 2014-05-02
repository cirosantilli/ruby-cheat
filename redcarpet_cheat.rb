#!/usr/bin/env ruby
require 'redcarpet'

##Basic usage

  renderer = Redcarpet::Render::HTML.new()
  markdown = Redcarpet::Markdown.new(renderer)

  markdown.render("a") == "<p>a</p>\n" or raise
  markdown.render("*a*") == "<p><em>a</em></p>\n" or raise
  markdown.render("#a") == "<h1>a</h1>\n" or raise
  markdown.render("##a") == "<h2>a</h2>\n" or raise

##HTML_TOC produces only the TOC itself:

  renderer = Redcarpet::Render::HTML_TOC.new()
  markdown = Redcarpet::Markdown.new(renderer)
  #markdown.render("#a") == "<ul>\n<li>\n<a href=\"#toc_0\">a</a>\n</li>\n</ul>\n" or raise

##custom renderer

  input = <<HEREDOC
    code indent
    code indent

```
code fenced
code fenced
```

```ruby
code fenced ruby
code fenced ruby
```

- a
- b

a


b

# h1

# h1

# h1  #

h1
==
HEREDOC

  # TODO how to remove those `puts` and store the call trace on a variable?
  # TODO does not seem possible to get the actual list marker (`-` or `+`)

  class CustomRenderer < Redcarpet::Render::HTML
    def block_code(text, language)
      puts("block_code:   #{text.inspect} #{language.inspect}")
      "<code class=\"#{language}\">#{text}</code>\n"
    end

    def header(text, level, anchor)
      puts("header:       #{text.inspect} #{level.inspect} #{anchor}")
      "<h#{level} id=\"#{anchor}\">#{text}</h#{level}>\n"
    end

    def list(text, type)
      puts("list:         #{text.inspect} #{type.inspect}")
      if type == :unordered
        tag = 'ul'
      else
        tag = 'ol'
      end
      "<#{tag}>\n#{text}</#{tag}>\n"
    end

    def list_item(text, type)
      puts("list_item:    #{text.inspect} #{type.inspect}")
      "<li>#{text}</li>\n"
    end

    def paragraph(text)
      puts("paragraph:    #{text.inspect}")
      "<p>#{text}</p>\n"
    end

    #def entity(text)
      #puts("entity:       #{text.inspect}")
    #end

    #def normal_text(text)
      #puts("normal_text:  #{text.inspect}")
    #end
  end

  markdown = Redcarpet::Markdown.new(CustomRenderer, fenced_code_blocks: true)
  puts "#CustomRenderer"
  puts "method calls:\n\n"
  output = markdown.render(input)
  puts "\noutput:\n" + output
