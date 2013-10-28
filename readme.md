Ruby cheatsheets and mini projects.

Interactive REPL interface: `irb`.

# ruby vs python

As of 2013, Ruby is almost equivalent to Python:

- interpreted
- dynamically typed

Advantages of Python:

- part of the LSB
- much more used. Probably the main reason why Ruby is used is RoR.
- no single punctuation character variables:

    - `$:` for require path

- no .each do

Disadvantages of Python:

- confusing global functions: `len` vs `split`.

It is a shame that the FOSS community must be divided yet again.

# rvm

Ruby version manager.

Similar to Python virtualenv.

Manage multiple Ruby versions on a single system.
Run programs in specific environments.

Install rvm:

    curl -L https://get.rvm.io | bash -s stable

This added `~/.rvm/bin` to the `$PATH`.

Meet the rvm dependencies:

    rvm requirements

This seems to generate instructions to the system's package manager
to install dependencies.

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
