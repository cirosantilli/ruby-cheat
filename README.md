# Ruby Cheat

[![Build Status](https://travis-ci.org/cirosantilli/ruby-cheat.svg?branch=master)](https://travis-ci.org/cirosantilli/ruby-cheat)

Ruby information and cheatsheets.

For Rails and libraries that are very commonly related to Rails or web dev,
see [this](https://github.com/cirosantilli/rails-cheat).

All runnable Ruby files are meant to be run with `bundle exec ruby <filename>`.

Most important files:

-   [main.rb](main.rb): will contain every testable thing that:

    -   is in the Language Core or Stdlib

    -   does not slow running down considerably:

        - user input
        - network
        - profiling

    -   does not produce large amounts of output

-   [Implementations](implementations.md)

-   [Gems](gems.md)

-   [Version managers](version-managers.md): RVM, rbenv.

-   [Ruby vs Python](ruby-vs-python.md)

-   [Notable uses](notable-uses.md)

-   [Lint tools and Style guides](lint-tools.md)

-   [capybara/](capybara/)

-   [bundler/](bundler/)

-   [Foreman](foreman.md)

## Sources

### Official

-   <https://www.ruby-lang.org> Official website.

-   <https://github.com/ruby/ruby>

    Official GitHub source code mirror. Includes stdlib.
    Takes pull requests, but does not merge them from there.

-   <http://www.ruby-doc.org/core-2.1.3/> Language built-ins docs.

-   <http://www.ruby-doc.org/stdlib-2.1.3/> Stdlib docs.

### Third party

-   <http://rubylearning.com/satishtalim/tutorial.html>

    Good intro tutorial.
