#!/usr/bin/env ruby
require 'erubis'
require 'erb'

# TODO vs ERB in stdlib? There are some behaviour differences.
# What about ERB with options?

## -%

  # Only useful with `=`, becase `<% %>` already has empty line removal.

  # Remove the current line because only whitesapaces:
  Erubis::Eruby.new(" <% 0 %> \nb").result == 'b' or raise

  # Don't do anything because line not empty.
  Erubis::Eruby.new("a <% 0 %> \nb").result == "a  \nb" or raise
  Erubis::Eruby.new("a <% 0 -%> \nb").result == "a  \nb" or raise
  Erubis::Eruby.new(" <% 0 %> a\nb").result == "  a\nb" or raise
  Erubis::Eruby.new(" <% 0 -%> a\nb").result == "  a\nb" or raise

  # Same as above, thus useless because longer.
  Erubis::Eruby.new(" <% 0 -%> \nb").result == 'b' or raise

  # Don't remove the current line because of `=`:
  Erubis::Eruby.new(" <%= 0 %> \nb").result == " 0 \nb" or raise

  # Remove the current line even with `=`:
  Erubis::Eruby.new(" <%= 0 -%> \nb").result == " 0b"   or raise

  # Remove forward:
  Erubis::Eruby.new("a <%= 0 -%> \nb").result == "a 0b"   or raise

  # Don't do anything because non-whitespace forward:
  Erubis::Eruby.new(" <%= 0 -%> a\nb").result == " 0 a\nb"   or raise

## %-

  # Never does anything useful, don't use it.
