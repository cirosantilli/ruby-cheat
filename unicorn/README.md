# Unicorn

Rack HTTP server.

Must be run from  directory that contains a `config.ru` file, for example a root of a rails template.

Can be used both for production and tests. The most common setup is to use unicorn only for development, and use it behind nginx server for production.

Run unicorn:

    bundle exec unicorn -p 3000
    firefox localhost:3000
