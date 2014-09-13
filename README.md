# Bucket

*Bucket* is a chatterbot built for Slack using Ruby on Rails. It is a port of 
[Dan Broger][zigdon]'s fine [xkcd-Bucket][]. As such, 
it is licensed under the [GPLv3][].

[zigdon]: https://github.com/zigdon/
[xkcd-Bucket]: https://github.com/zigdon/xkcd-Bucket
[GPLv3]: http://www.gnu.org/copyleft/gpl.html


# Installation

1. Install ruby 2.1.2
2. Install Postgres 9.3
3. Run `bundle install` to install the dependencies.
4. Copy `config/database.example.yml` into `config/database.yml` and set it up to match your database.
5. Run `rake` to test that everything works.
6. Run `rails s` to start the server.


# Slack Setup

Head to [Slack's API][api] page.

You will need an Outgoing Webhook. You will want a URL on which Bucket will
listen, something like `http://bucket.herokuapp.com/messages`.

Set the environment variables required in the production section of
`config/secrets.yml`.

[api]: https://api.slack.com/


# Backlog

I have a public [Pivotal Tracker project][tracker] where you can see what I
want to change with Bucket.

[tracker]: https://www.pivotaltracker.com/n/projects/1165996
