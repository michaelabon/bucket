# Bucket

*Bucket* is a chatterbot built for Slack using Ruby on Rails. It is a port of 
[Dan Broger][zigdon]'s fine [xkcd-Bucket][]. As such, 
it is licensed under the [GPLv3][].

[zigdon]: https://github.com/zigdon/
[xkcd-Bucket]: https://github.com/zigdon/xkcd-Bucket
[GPLv3]: http://www.gnu.org/copyleft/gpl.html


[![Build Status](https://travis-ci.org/michaelabon/bucket.svg?branch=master)](https://travis-ci.org/michaelabon/bucket)


# Using Bucket

## Installation

1. Install ruby, using `.ruby-version`
1. Install Postgres 12+ (I'm using 12.1 right now)
1. Run `bundle install` to install the dependencies.
1. Copy `config/database.example.yml` into `config/database.yml` and set it up to match your database.
1. Run `rake db:setup` to create your database.
1. Run `rake` to test that everything works.
1. Run `rails s` to start the server.


## Deploying Bucket

Bucket works great with [Pivotal Web Services][pws] or with [Heroku][heroku].
You will want a database service, such as ElephantSQL.

[pws]: https://run.pivotal.io
[heroku]: https://heroku.com


## Slack Setup

Head to [Slack's API][api] page.

You will need an Outgoing Webhook. You will want a URL on which Bucket will
listen, something like `http://bucket.cfapps.io/messages`. The route will need
to be `/messages`.

Set the environment variables required in the production section of
`config/secrets.yml`. These will be given to you by Slack.

[api]: https://api.slack.com/


# Contributing to Bucket

## What to work on

I have a public [Pivotal Tracker project][tracker] where you can see what I
want to change with Bucket. Do you have other ideas? Open up an Issue on
GitHub! I'm happy to help you throughout ideation and development.

[tracker]: https://www.pivotaltracker.com/n/projects/1165996


## Testing your changes

Run `rake` to test the specs with rspec, style with rubocop, and
vulnerabilities with brakeman.

Changes to Bucket require matching specs. You'll find high-level specs in
`spec/requests` and individual unit specs in their corresponding directories.

Want to try chatting with Bucket without needing to deploy or even setup Slack?
Just run `rake bucket` and pretend it's IRC. Your username is _CLI_.
