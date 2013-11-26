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

Bundler can be configured via a `.bundle` directory.

The `config` file in that directory can contain options such as:

- `BUNDLE_PATH: vendor/bundle`: set the path to install gems under.

    The default is a shared directory for the user or system.

    This is useful for example to control exact versions of applications on
    a given project. This is done by default for example by the rails template.

- `BUNDLE_DISABLE_SHARED_GEMS: '1'`

    TODO
