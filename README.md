Ruby cheatsheets and mini projects.

For Rails and libraries that are very commonly related to Rails or web dev, see [this](https://github.com/cirosantilli/rails-cheat).

All runnable Ruby files are meant to be run with `bundle exec ruby <filename>`.

#Ruby vs Python

As of 2013, Ruby is almost equivalent to Python:

- main implementations are mostly interpreted (with some on the fly compiling)
- dynamically typed
- large cross platform stdlib

It is a shame that the FOSS community must be divided over trivial differences.

Advantages of Python:

- part of the LSB.

- much more used. Ruby is only used because of RoR.

    Python is more useful in every other application domain.

- Ruby uses many punctuation characters (often based on `sh` or `perl`)
    where using actual names would be saner.

    - `$:` for `require` path
    - `@`  for class instance variables
    - `?`, `!` and `=` allowed as method name suffixes

- many convenience function which are too easily derivable from others.

    This means that programmers have to learn more language primitives:

    - `if` vs `unless`
    - `any?` vs `empty?`
    - `alias` is even a keyword to create more redundancy.
    - `not` vs `!`, only differentiated by precedence.

- requires of requires are also required.

    It becomes very hard to find where a function comes from.

    If you have ever tried to hack a large project, you will know that Python explicit `import`
    make your job *much* easier.

- identifier first letter case matters:

        i = 0
        i = 1
        I = 0
        I = 1 #warning

- `super` without parenthesis is different from `super()` with parenthesis!

Disadvantages of Python:

- confusing global functions in places where methods would be adequate: `len` vs `split`.

- statements that could be functions such as `print` (corrected in Python 3),
    `del`, `in`, etc.

- Ruby built-in types look more like objects than Python's.

- Ruby have some important tools on its stdlib, including:

    - ERB: a ruby/HTML template language, much like PHP.
    - rake: a Makefile system.

    In Python, those tools are lacking a good implementation as of 2013.

#Programs that use ruby

The most notable ones are:

- ruby on rails. Major importance to the Ruby language.

    Powers:

    - GitHub
    - parts of Twitter

- rake

- GRUB2. [This](http://www.amazon.co.uk/Ruby-Grub-Abi-Burlingham/dp/1848120346) is the reason why!

- puppet

- Mac Homebrew.

#Style guides

- <https://github.com/styleguide/ruby>

    Official GitHub style guide.

- <https://github.com/bbatsov/ruby-style-guide>

    Bastov's style guide. 5,500 stars as of 2014-04.

- <https://github.com/thoughtbot/guides/tree/master/style#ruby>

    Thoughbot Inc. styles.

    Short for Ruby, but also includes all tools of the Rails workflow.

    Automatically checked by Hound CI.

#IRB

Interactive REPL interface: `irb`.

To repeat last command: `<left><up>`.

#Version managers

Manage multiple Ruby versions on a single system. Run programs in specific environments.

Programs similar to Python `virtualenv`.

The best way to install Ruby, do that you can manage multiple versions easily.

**Always** use it one of those methods.

##rbenv

<https://github.com/sstephenson/rbenv>

As of 2014-03, has 2x more stars than RVM. It is much more recent than RVM (2 years vs 4 for RVM).

##RVM

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

This seems to generate instructions to the system's package manager to install build dependency programs, such as build tools. Works on a clean Ubuntu 12.04.

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

Gems installed from now on with `gem install <gemname>` will go there, and be visible only to the given Ruby version. 

#Gem

A gem is like a Python package: an interface which allows to install and publish Ruby projects.

It is recommended that you use Bundler instead of gem to install gems, since bundler also takes care of dependency issues.

The de-facto standard web interface for gems is `rubygems.org`, which is open source rails application.

Gem metadata is specified on a `.gemspec` file.

For gem documentation, the most widely used option is <http://rubydoc.info>, which is YARD based.

##gem uninstall

There is no clean built-in way to remove installed dependencies of a gem with it: <http://stackoverflow.com/questions/952836/do-i-have-to-manually-uninstall-all-dependent-gems>

[gem-prune](https://github.com/ddollar/gem-prune/tree/master>) however seems to do the trick, but you have to manually mark which gems you want to keep, it is not done automatically with install. So maybe:

    function gemi{ gem keep "$1" && gem install "$1"; }

#rdoc

stdlib tool to generate documentation from comments.

Does not have many features.

Also consider the more advanced YARD tool.

#Foreman

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

This will run all the commands in the procfile.

To set environment variables for a project only, foreman adds all environment variables in the `.env` file to the running environment. This file contains local only information, and should not be uploaded.

#Sources

- <http://rubylearning.com/satishtalim/tutorial.html>

    Good intro tutorial.
