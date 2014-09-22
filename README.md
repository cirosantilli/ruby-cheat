# Ruby Cheat

Ruby information and cheatsheets.

For Rails and libraries that are very commonly related to Rails or web dev,
see [this](https://github.com/cirosantilli/rails-cheat).

All runnable Ruby files are meant to be run with `bundle exec ruby <filename>`.

## Implementations

Ruby has a few major implementations.

### MRI

Matt's ruby, after the original creator of the language.

Reference implementation. Coded in C.

### JRuby

Runs on top of JVM: compiles Ruby to Java object code.

### Rubinius

Seems to use LLVM JIT compilation.

## Ruby vs Python

As of 2013, Ruby is almost equivalent to Python:

- main implementations are mostly interpreted (with some on the fly compiling)
- dynamically typed
- large cross platform stdlib

It is a shame that the FOSS community must be divided over trivial differences.

Advantages of Python:

-   part of the LSB.

-   much more used. Ruby is only used because of RoR.

    Python is more useful in every other application domain.

-   Ruby uses many punctuation characters, often based on `sh` or `perl`,
    where using actual names would be saner.

    - `$:` for `require` path
    - `@`  for class instance variables
    - `?`, `!` and `=` allowed as method name suffixes

-   many convenience function which are too easily derivable from others.

    This means that programmers have to learn more language primitives:

    - `if` vs `unless`
    - `any?` vs `empty?`
    - `alias` is even a keyword to create more redundancy.
    - `not` vs `!`, only differentiated by precedence,
        so `!` which has lower precedence is more general
        (you can always add precedence with parenthesis, but not remove it)
    - `raise` vs `fail`

-   requires of requires are also required.

    It becomes very hard to find where a function comes from.

    If you have ever tried to hack a large project,
    you will know that Python explicit `import` make your job *much* easier.

-   identifier first letter case matters:

        i = 0
        i = 1
        I = 0
        I = 1 #warning

-   `super` without parenthesis is different from `super()` with parenthesis!

Disadvantages of Python:

-   confusing global functions in places where methods would be adequate: `len` vs `split`.

-   statements that could be functions such as `print` (corrected in Python 3), `del`, `in`, etc.

-   Ruby built-in types look more like objects than Python's.

-   Ruby have some important tools on its stdlib, including:

    - ERB: a ruby/HTML template language, much like PHP.
    - rake: a Makefile system.

    In Python, those tools are lacking a good implementation as of 2013.

## Programs that use ruby

The most notable ones are:

-   ruby on rails. Major importance to the Ruby language.

    Powers:

    - GitHub
    - parts of Twitter

-   rake

-   GRUB2. [This](http://www.amazon.co.uk/Ruby-Grub-Abi-Burlingham/dp/1848120346) is the reason why!

-   puppet

-   Mac Homebrew.

## Lint tools

## Style guides

-   <https://github.com/styleguide/ruby>

    Official GitHub style guide.

-   <https://github.com/bbatsov/ruby-style-guide>

    Batsov's style guide. 5,500 stars as of 2014-04. Lots of examples.

    Automatically checked by the RuboCop lint tool: <https://github.com/bbatsov/rubocop>

-   <https://github.com/thoughtbot/guides/tree/master/style#ruby>

    Thoughbot Inc. styles.

    Includes many tools of the Rails workflow, not just Ruby.

    Automatically checked by the Hound CI lint tool: <https://github.com/thoughtbot/hound>
    Uses RuboCop on the backend.

-   ruby-lint: <https://github.com/YorickPeterse/ruby-lint>

Duplication finders:

-   <https://github.com/seattlerb/flay>. HAML extension: <https://github.com/UncleGene/flay-haml>

-   <https://github.com/gilesbowkett/towelie>

## IRB

Interactive REPL interface: `irb`.

Repeat last command: `<up>`

Enable persistent history:
<http://stackoverflow.com/questions/10465251/can-i-get-the-ruby-on-rails-console-to-remember-my-command-history-umm-better>:

    echo 'require "irb/ext/save-history"
    IRB.conf[:SAVE_HISTORY] = 200
    IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
    ' > ~/.irbrc

Note that RVM has a default `.irbrc` that does that for you automatically.

### Reading the prompt

    irb(main):001:0>
    ^^^ ^^^^  ^^^ ^^
    1   2     3   45

1.  Tells you it's IRB!

2.  TODO

3.  Number of commands since you started the session.

4.  `end` depth level:

        irb(main):001:0> if true
        irb(main):002:1> if true
        irb(main):003:2> 0
        irb(main):004:2> end
        irb(main):005:1> end
        => 0

5.  If a statement needs closing.

    Quotes:

        irb(main):001:0> 'a
        irb(main):002:0' b'
        => "a\nb"

    In the middle of a statement: `*` appears;

        irb(main):001:0> 1 +
        irb(main):002:0* 1
        => 2

    When on the middle of a statement, you can cancel it with Ctrl+C.

## Gem

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

### gem install

Specify gem version;

    gem install -v 0.9.17 softcover

### gem uninstall

There is no clean built-in way to remove installed dependencies of a gem with it:
<http://stackoverflow.com/questions/952836/do-i-have-to-manually-uninstall-all-dependent-gems>

[gem-prune](https://github.com/ddollar/gem-prune/tree/master>) however seems to do the trick,
but you have to manually mark which gems you want to keep, it is not done automatically with install. So maybe:

    function gemi{ gem keep "$1" && gem install "$1"; }

List installed gems in current gemset:

    gem list

List all available versions of a gem on remote:

    gem list -ar gemname

### Find gem version

From the command line:

    gem list | grep rake

Each Gem may have multiple installed versions:

    rake (10.3.2, 10.1.0, 0.9.2.2)

In that case, by default Ruby will take the most recent version of the gem, and the most recent compatible installed version of it's dependencies: <http://yehudakatz.com/2011/05/30/gem-versioning-and-bundler-doing-it-right/ >

From inside Ruby: <http://stackoverflow.com/questions/2054224/how-to-access-the-version-of-a-gem-from-within-ruby>. TODO.

A common convention, followed by Rails, is to define a string with the version name at:

    puts Rails::VERSION::STRING

### gemspec file

Gem metadata for `rubygems.org` is specified on a `project_name.gemspec` file at the top-level of projects.
To install a project from it's `gemspec`, do:

    gem build project_name.gemspec
    gem install project_name.gemspec

## Version managers

Manage multiple Ruby versions on a single system. Run programs in specific environments.

Programs similar to Python `virtualenv`.

The best way to install Ruby, do that you can manage multiple versions easily.

**Always** use it one of those methods.

### rbenv

<https://github.com/sstephenson/rbenv>

As of 2014-03, has 2x more stars than RVM. It is much more recent than RVM (2 years vs 4 for RVM).

### RVM

Ruby version manager: <https://github.com/wayneeseguin/rvm>

Recognizes Gemfile's `ruby` lines and automatically changes the ruby version to match it.

Basic install command you will want to use most of the time:

    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.1.1

Log out, login, and it will work well on all new shells.

The RVM install adds to `bash_profile`:

    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

And to `~/.bashrc`:

    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

Install another version of Ruby:

    rvm install 1.9.3

This may download and compile its source if a binary is not found, so it may take some time.

This seems to generate instructions to the system's package manager to install build dependency programs,
such as build tools. Works on a clean Ubuntu 12.04.

The ruby interpreter is installed only for the current user under `~/.rvm/bin/`.

Install the latest version of Ruby:

    rvm install ruby

Use ruby interpreter `1.9.3`:

    rvm use 1.9.3
    ruby -v

Use ruby named `2.1.1` and make it the default:

    rvm use 2.1.1 --default
    ruby -v

Use the system ruby (disable RVM for current shell):

    rvm use system

View installed interpreter versions, current and default one:

    rvm list

Make the `gem` command install gems for current ruby installation:

    rvm rubygem current

Show the install directory current gems:

    rvm gemdir

Sample output:

    /home/ciro/.rvm/gems/ruby-2.0.0-p247

Gems installed from now on with `gem install <gemname>` will go there,
and be visible only to the given Ruby version.

### @global

### Gemsets

Allow you to install multiple versions of a gem in a single Ruby: <https://rvm.io/gemsets/basics>

Create gemset named `gemsetname` for Ruby 1.9.2:

    rvm 1.9.2
    rvm gemset create gemset_name

Use that gemset;

    rvm 1.9.2@gemset_name

Install a gem for the default gemset:

    rvm 1.9.2
    gem install rails -v 2.3.3

Install another version for the gemset we created;

    rvm 1.9.2@gemset_name
    gem install rails -v 2.3.2

The `@global` gemset is visible whenever a gemset other than the default is used.

List gemsets:

    rvm gemset list

Delete gemset:

    rvm gemset delete gemset_name

## Foreman

Foreman is a tool to facilitate web app deployment.

Foreman configuration is found on a file named `Procfile`.

The `Procfile` is used by the application called `foreman`.

The line:

    web: gunicorn main:app

Simply says that web servers should run the command `gunicorn main:app` (gunicorn is a Python WSGI server).

Sample one web app, one worker and one clock dyno:

    web: gunicorn hello:app
    worker: python worker.py
    clock: python clock.py

To test the project locally you can use:

    foreman start

This will run all the commands in the `procfile`.

To set environment variables for a project only,
foreman adds all environment variables in the `.env` file to the running environment.
This file contains local only information, and should not be uploaded.

## Sources

-   <http://rubylearning.com/satishtalim/tutorial.html>

    Good intro tutorial.
