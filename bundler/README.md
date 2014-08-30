# Bundler

Package installer.

It higher level than `gem`, as it takes care of things such as dealing with dependencies.

Install bundler:

    gem install bundler

Install all gems listed on file `Gemfile` in current directory:

    bundle install

If you have a `Gemfile.lock` only gems that were modified on the `Gemfile` will be reinstalled.

Update all gems to their latest versions allowed by the `Gemfile`, ignoring `Gemfile.lock`:

    bundle update

Show gem install path:

    bundle show $gemname

Remove unused gems:

    bundle clean

## exec

Execute a script that comes with a gem installed with Bundler
in which all packages will be at the version specified by the `Gemfile`:

    bundle exec ruby script.rb
    bundle exec irb

If you run a script / console like this,
all the gems in the `Gemfile` can then be required simply as `require 'gem'`

This also automatically adds the `Bundler` object to Ruby,
which has methods such as `Bundler.require`, that automatically requires all the gems.
It is also possible to require gems by gem group via `Bundler.require(:group)`.

Execute using a Gemfile that is not in the current directory:

    BUNDLE_GEMFILE=/path/to/Gemfile cmd

## Configuration

Bundler can be configured via:

- the local `./.bundle/config` and global `~/.bundle/config` files
- environment variables
- command line options

Each configuration option can be set via those three methods.

The `config` file in that directory can contain options such as:

### PATH

`BUNDLE_PATH vendor/bundle`: set the path to install gems under.

The default is the user local `~/.bundle`,
but you could make it a global shared directory if you have `sudo`.

The most standard per project location is `vendor/bundle`, which is the Rails 4 default.
It is also used on certain `bundler` defaults, such as the `--deployment` option.

If you don't already have a `vendor/bundle` directory,
and don't want to create one, just use the `.bundle` directory itself.

The directory is created if it does not exist.

### DISABLE_SHARED_GEMS

If different from `1`, bundler does not install gems which are already present on the system.

With this option on it thus.

After a `Bundler.setup`, the shared gem will *not* be visible to the program,
so `require 'gem'` will fail. `bundle exec ruby a.rb` automatically does `Bundler.setup`.

Each of the options can be set from the command line:

    bundle install --path=anything

TODO `--disable-shared-gems` cannot be set anymore from the command line on 1.3?

But it is automatically set on the config file if `--path` is used.

If the option is used from the command line the `.bundle/config` file
is automatically modified / created so that the option will have that value.
In this way, the last options are remembered.

## BUNDLE_WITHOUT

Don't install a group.

Example: you support two databases: MySQL and PostgreSQL.

Put all that is specific to each one in a group, and then install with either:

    bundle install --without=mysql
    bundle install --without=pg

## Help

List of subcommands:

    bundle help

Details on a subcommand:

    bundle help install

## Install

Installs gems to the same path as `gem install` would install,
which may require `sudo` privileges.

`bundle help install` says that you should never use `sudo bundle install`,
as some of the steps towards installation do not require `sudo`,
and doing them as sudo may cause you problems later.
If `sudo` is required, Bundler will ask your password and to it for you.
