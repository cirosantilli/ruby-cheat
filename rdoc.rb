#!/usr/bin/env ruby

## RDoc

# Stdlib tool to generate documentation from comments.

# Has yet another markup language.

# Also consider the more advanced YARD tool, and writing docs in a more popular language like Markdown.

  require 'rdoc'
  h = RDoc::Markup::ToHtml.new(RDoc::Options.new)

## Paragraphs

  # Only on double newlines:

    h.convert("a\nb")   == "\n<p>a b</p>\n"           or raise
    h.convert("a\n\nb") == "\n<p>a</p>\n\n<p>b</p>\n" or raise

## Links

  # Single word:

    h.convert('a[http://example.com]') == %{\n<p><a href="http://example.com">a</a></p>\n} or raise

  # Multi word:

    h.convert('{a b}[http://example.com]') == %{\n<p><a href="http://example.com">a b</a></p>\n} or raise

## HTML tags

  # Most tags get converted to HTML character entities,
  # but a few magic combinations can get converted to other tags!
  # Insane.

    h.convert('<')          == "\n<p>&lt;</p>\n"           or raise
    h.convert('<tt>')       == "\n<p>&lt;tt&gt;</p>\n"     or raise
    h.convert('<tt>a</tt>') == "\n<p><code>a</code></p>\n" or raise

## code

    h.convert("  a\n  b")     == "\n<pre>a\nb</pre>\n"         or raise
    h.convert('+a+')          == "\n<p><code>a</code></p>\n"   or raise
    h.convert('+a b+')        == "\n<p>+a b+</p>\n"            or raise
    h.convert('<tt>a b</tt>') == "\n<p><code>a b</code></p>\n" or raise
