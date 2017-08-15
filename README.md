# Calculator

[![CircleCI](https://circleci.com/gh/jmosouza/calculator-rails.svg?style=svg&circle-token=c4b689a45e7e13f06f394380e9b1e2a2234ce68d)](https://circleci.com/gh/jmosouza/calculator-rails)

# CODING TEST NOTE

The coding test suggests using Mongo. I decided to go with SQL because I'm more used to it and would face less "surprises" during the test. That said, I'm certainly open to No-SQL.

I generally prefer to use the same database (usually PostgreSQL) in all environments, but I chose SQLite in development to make the evaluator's job easier when reviewing my project, since it requires zero setup.

* Development and test: SQLite
* Production: PostgreSQL

# Setup

Install dependencies and create the database with `bin/setup`.

# Run

Just `rails server`.

# Test

Tests cover the Calculation model and logic and the Calculation endpoint. Run `rails test`.

# Deploy

* Commit to master (or open a pull request)
* Wait for CI to pass
* Done (or accept the pull request)

CircleCI: https://circleci.com/gh/jmosouza/calculator-rails

Heroku: https://dashboard.heroku.com/apps/jmosouza-calculator-rails/deploy

# Additional info

* Models are auto-annotated when migrating the database. https://github.com/ctran/annotate_models
* Some environment variables are mandatory. See `Envfile`. https://github.com/eval/envied
