# Version managers

Manage multiple Ruby versions on a single system. Run programs in specific environments.

Programs similar to Python `virtualenv`.

The best way to install Ruby, do that you can manage multiple versions easily.

**Always** use it one of those methods.

## rbenv

<https://github.com/sstephenson/rbenv>

As of 2014-03, has 2x more stars than RVM. It is much more recent than RVM (2 years vs 4 for RVM).

## RVM

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

## @global

## Gemsets

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

