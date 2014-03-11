#!/usr/bin/env ruby

require 'redcarpet'

# Defaults:

  renderer = Redcarpet::Render::HTML.new()
  markdown = Redcarpet::Markdown.new(renderer)

  markdown.render("a") == "<p>a</p>\n" or raise
  markdown.render("*a*") == "<p><em>a</em></p>\n" or raise
  markdown.render("#a") == "<h1>a</h1>\n" or raise
  markdown.render("##a") == "<h2>a</h2>\n" or raise

##HTML_TOC produces only the TOC itself:

  renderer = Redcarpet::Render::HTML_TOC.new()
  markdown = Redcarpet::Markdown.new(renderer)
  markdown.render("#a") == "<ul>\n<li>\n<a href=\"#toc_0\">a</a>\n</li>\n</ul>\n" or raise
