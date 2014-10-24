# Foreman

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
