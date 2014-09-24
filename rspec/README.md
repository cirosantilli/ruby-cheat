# RSpec

General unit test framework. Alternative to Minitest,
which is the 2.1.1 stdlib and is the default on Rails 4 templates.

Vs Minitest: Minitest interface is saner, `assert_x` instead of `expect(x).to X`, and is default.
So just use Minitest.

Main tutorial docs: <https://www.relishapp.com/rspec>

Meta gem: <https://github.com/rspec/rspec>

Contains 4 gems which can be used separately:

-   Core: `describe`, `it`.

-   Expectations: <https://github.com/rspec/rspec-expectations>.
    `expect`, the horrible `to` and `not_to` monkey-patches,
    the matchers (arguments passed to `to`) such as: `eq`, `be_xxx`
    which by `method_missing` invokes `xxx?`, etc.

-   Mocks. TODO

-   Rails. Shall not be covered here. <https://github.com/rspec/rspec-rails>

The `rspec` meta gem depends on `rspec-core`, `expectations` and `mocks`,
so only need to include it to include all three.

## rspec command

The conventional way of running RSpec test is through:

    bundle exec rspec main.rb

If used on a directory, all files that end in `_spec.rb` will be run.
The conventional location for tests is:

    bundle exec rspec spec

`spec` is the default path, so the following gives the same result:

    bundle exec rspec

If you use the `rspec` command, you don't need to add `require 'rspec'` to the file.

Only run tests at given lines:

    bundle exec rspec path/to/spec.rb:15
    bundle exec rspec path/to/spec.rb:15:32

## Rake usage

The conventional task name is `spec`:

    bundle exec rake spec

Only run tests from a single file
<http://stackoverflow.com/questions/6116668/rspec-how-to-run-a-single-test>:

    bundle exec rake spec SPEC=path/to/spec.rb

Pass `rspec` command line options:

    bundle exec rake spec SPEC=path/to/spec.rb SPEC_OPTS="-e \"should be successful and return 3 items\""
