# Extensions

Write code that can be called from Ruby in C.

Fast and inconvenient: use only for speed critical parts of the project.

You can use and offer an interface for anything that you can do in the Ruby core language
(without the stdlib) but in C: all core classes (`Module`, `Class`, `Integer`, etc.),
exceptions, etc.

Try to keep it to C89 to be able to compile in Windows.

Files:

- `conf.rb`: configuration file that generates the makefile
- `ext0.c`: the extension
- `ext0.so`: the main output file. Can be required like other Ruby files.

## mkmf

<http://ruby-doc.org/stdlib-2.1.0/libdoc/mkmf/rdoc/index.html>

## Sources

-   <http://clalance.blogspot.fr/2011/01/writing-ruby-extensions-in-c-part-1.html>
