# Gems

A gem is like a Python package: an interface which allows to install and publish Ruby projects.

It is also a command line utility that downloads and manages gems.

It is recommended that you use Bundler instead of gem to install gems,
since bundler also takes care of dependencies and more.

The de-facto standard gem index is `rubygems.org`, which is open source Rails application.

For gem documentation, the most widely used option is <http://rubydoc.info>, which is YARD based.

List all subcommands:

    gem help

Get help on one subcommand:

    gem help list

## gem install

Specify gem version;

    gem install -v 0.9.17 softcover

## gem uninstall

There is no clean built-in way to remove installed dependencies of a gem with it:
<http://stackoverflow.com/questions/952836/do-i-have-to-manually-uninstall-all-dependent-gems>

[gem-prune](https://github.com/ddollar/gem-prune/tree/master>) however seems to do the trick,
but you have to manually mark which gems you want to keep, it is not done automatically with install. So maybe:

    function gemi{ gem keep "$1" && gem install "$1"; }

List installed gems in current gemset:

    gem list

List all available versions of a gem on remote:

    gem list -ar gemname

## Find gem version

From the command line:

    gem list | grep rake

Each Gem may have multiple installed versions:

    rake (10.3.2, 10.1.0, 0.9.2.2)

In that case, by default Ruby will take the most recent version of the gem,
and the most recent compatible installed version of it's dependencies:
<http://yehudakatz.com/2011/05/30/gem-versioning-and-bundler-doing-it-right/ >

From inside Ruby:
<http://stackoverflow.com/questions/2054224/how-to-access-the-version-of-a-gem-from-within-ruby>.
TODO.

A common convention, followed by Rails, is to define a string with the version name at:

    puts Rails::VERSION::STRING

## gemspec file

Gem metadata for `rubygems.org` is specified on a `project_name.gemspec` file at the top-level of projects.
To install a project from it's `gemspec`, do:

    gem build project_name.gemspec
    gem install project_name.gemspec
