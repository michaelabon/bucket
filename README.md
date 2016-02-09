# Bucket

*Bucket* is a chatterbot built for Slack using Ruby on Rails. It is a port of 
[Dan Broger][zigdon]'s fine [xkcd-Bucket][]. As such, 
it is licensed under the [GPLv3][].

[zigdon]: https://github.com/zigdon/
[xkcd-Bucket]: https://github.com/zigdon/xkcd-Bucket
[GPLv3]: http://www.gnu.org/copyleft/gpl.html


# CI Status

[![Build Status](https://travis-ci.org/mkenyon/bucket.svg?branch=master)](https://travis-ci.org/mkenyon/bucket)


# Installation

1. Install ruby, using `.ruby-version`
1. Install Postgres 9+ (I'm using 9.4.x right now)
1. Run `bundle install` to install the dependencies.
1. Copy `config/database.example.yml` into `config/database.yml` and set it up to match your database.
1. Run `rake db:setup` to create your database.
1. Run `rake` to test that everything works.
1. Run `rails s` to start the server.


# Slack Setup

Head to [Slack's API][api] page.

You will need an Outgoing Webhook. You will want a URL on which Bucket will
listen, something like `http://bucket.cfapps.io/messages`.

Set the environment variables required in the production section of
`config/secrets.yml`. These will be given to you by Slack.

[api]: https://api.slack.com/


# Backlog

I have a public [Pivotal Tracker project][tracker] where you can see what I
want to change with Bucket.

[tracker]: https://www.pivotaltracker.com/n/projects/1165996
