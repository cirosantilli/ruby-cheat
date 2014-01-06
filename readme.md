Ruby cheatsheets and mini projects.

Interactive REPL interface: `irb`.

#rvm

Ruby version manager.

Similar to Python virtualenv.

The best way to install ruby, do that you can manage mutiple versions easily.

Recognizes Gemfile's `ruby` lines and automatically changes the ruby version to match it.

Manage multiple Ruby versions on a single system.
Run programs in specific environments.

Install rvm:

    curl -L https://get.rvm.io | bash -s stable

This added `~/.rvm/bin` to the `$PATH`.

Next do:

    source /home/ubuntu/.rvm/scripts/rvm

to update your current shell state.

Meet the rvm dependencies:

    rvm requirements

This seems to generate instructions to the system's package manager
to install dependency programs, such as build tools.

Install a specific version of Ruby:

    rvm install 1.9.2

This may download and compile its source, so it may take some time.

The ruby interpreter is installed only for the current user under `~/.rvm/bin/`.

Install the latest version of Ruby:

    rvm install ruby

Use ruby interpreter 1.9.2:

    rvm use 1.9.2
    ruby -v

Use ruby named `ruby` and make it the default:

    rvm use ruby --default
    ruby -v

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

#gem

A gem is like a Python package: an interface which allows to install and publish
Ruby projects.

It is recommended that you use Bundler instead of gem to install gems,
since bundler also takes care of dependency issues.

The de-facto standard web interface for gems is `rubygems.org`,
which is open source rails application.

Gem metadata is specified on a `.gemspec` file.

For gem documentation, the most widely used option is <http://rubydoc.info>,
which is YARD based.

#ruby vs python

As of 2013, Ruby is almost equivalent to Python:

- interpreted
- dynamically typed
- large cross platform stdlib

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
    - `alias` is even a keyword

- `extend` encourages people to add new methods to existing classes just by loading a library.

    It becomes then impossible to find where the method comes from without going through
    every single library you have required.

- identifier first letter case matters:

        i = 0
        i = 1
        I = 0
        I = 1 #warning

Disadvantages of Python:

- confusing global functions in places where methods would be adequate: `len` vs `split`.

- statements that could be functions such as `print` (corrected in Python 3),
    `del`, `in`, etc.

- Ruby built-in types look more like objects than Python's.

- Ruby have some important tools on its stdlib, including:

    - erb: a ruby/HTML template language, much like PHP.
    - rake: a Makefile system.

    In Python, those tools are lacking a good implementation as of 2013.

It is a shame that the FOSS community must be divided yet again.

#programs that use ruby

The most notable ones are:

- ruby on rails. Major importance to the Ruby language.

    Powers:

    - Github
    - parts of Twitter

- rake
- GRUB2. [This](http://www.amazon.co.uk/Ruby-Grub-Abi-Burlingham/dp/1848120346) is the reason why!
- puppet
- Mac homebrew

#rdoc

stdlib tool to generate documentation from comments.

Does not have many features.

Also consider the more advanced YARD tool.

#rack

Standard Ruby SGI interface.

Action to run specified in a `config.ru` file. This is called a *rackup file*.

#unicorn

Rack HTTP server.

Must be run from  directory that contains a `config.ru` file,
for example a root of a rails template.

Can be used both for production and tests.

    unicorn

Run test rails server:

    bundle exec unicorn -p 3000

#foreman

Foreman is a tool to facilitate web app deployment.

foreman configuration is found on a file named `Procfile`.

The `Procfile` is used by the application called `foreman`.

The line:

    web: gunicorn main:app

Simply says that web servers should run the command `gunicorn main:app`
(gunicorn is a Python WSGI server).

Sample one web app, one worker and one clock dyno:

    web: gunicorn hello:app
    worker: python worker.py
    clock: python clock.py

To test the project locally you can use:

    foreman start

This will run all the commands in the procfile.

To set environment variables for a project only, foreman adds all environment
variables in the `.env` file to the running environment.
This file contains local only information, and should not be uploaded.

#sources

- <http://rubylearning.com/satishtalim/tutorial.html>

    Good intro tutorial.
