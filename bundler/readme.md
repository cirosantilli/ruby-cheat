Package installer.

It higher level than `gem`, as it takes care of things such as dealing with dependencies.

Install all gems listed on file `Gemfile` in current directory:

    bundle install

If you have a `Gemfile.lock` only gems that were modified on the Gemfile will be reinstalled.
after the `Gemfile.lock` was created will be reinstalled.

Update all gems to their latest versions allowed by the `Gemfile`, ignoring `Gemfile.lock`:

    bundle update

Execute a script that comes with a gem installed with Bundler
in which all packages will be at the version specified by the `Gemfile`:

    bundle exec

Bundler can be configured via:

- the local `./.bundle/config` and global `~/.bundle/config` files
- environment variables
- command line options

Each configuration option can be set via those three methods.

The `config` file in that directory can contain options such as:

- `BUNDLE_PATH: vendor/bundle`: set the path to install gems under.

    The default is the user local `~/.bundle`, but you could make it a global
    shared directory if you have sudo.

    The directory is created if it does not exist.

- `BUNDLE_DISABLE_SHARED_GEMS: '1'`

    If a gem is present on the system, install it anyways.

    By default, bundler does not install gems which are already present on the system.

Each of the options can be set from the command line:

    bundle install --path=asdf --disable-shared-gems

If the option is used from the command line the `.bundle/config` file is automatically
modified / created so that the option will have that value.
In this way, the last options are remembered.
