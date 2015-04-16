# Bibliography

## De-facto official

-   <https://www.ruby-lang.org> Official website.

    There seems to be no Ruby Foundation analogous to the Python Foundation which is endorsed by the main author and holds copyright: <https://www.ruby-forum.com/topic/85675>. So we consider official anything endorsed (linked from) `ruby-lang.org`, which seems to be the most popular source.

-   <https://github.com/ruby/www.ruby-lang.org>

    Source code of `ruby-lang.org`.

-   <http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=59579>

    Ruby ISO spec. Not free.

-   <https://github.com/ruby/ruby>

    Official GitHub source code mirror. Includes stdlib. Takes pull requests, but does not merge them from there.

-   <http://www.ruby-doc.org/core-2.1.3/> Language built-ins docs.

-   <http://www.ruby-doc.org/stdlib-2.1.3/> Stdlib docs.

    Tips on reading `ruby-doc.org`:

    -   on the left sidebar:

        - `#foo`: means instance method `foo`
        - `::foo`: means class method `foo`

    -   when on a library (e.g. <http://ruby-doc.org/stdlib-2.1.0/libdoc/mkmf/rdoc/index.html>), look for general introductory information on the documentation on the top-level module (<http://ruby-doc.org/stdlib-2.1.0/libdoc/mkmf/rdoc/MakeMakefile.html>)

    -   Many parts of Ruby are under-documented, in particular the stdlib.

        The only way to get around that is to look at the source (click on `Toggle source`.

        For the Core, this will open the C code: for it to make any sense you need to have some understanding of Ruby internals or extensions.

        Also keep a clone of the source code handy at all times with an up-to-date generated `tags` file.

-   <https://github.com/rubyspec/rubyspec> Executable specification for the Ruby language: tons of unit tests asserting it's behavior.

    Followed by several implementations.

## Third party

-   <http://rubylearning.com/satishtalim/tutorial.html> Good intro tutorial.

-   <http://www.rubycentral.org/about> Organization that supports RubyConf and RailsConf.
