all:
  bundle exec rake

spec:
  bundle exec rake spec

lint:
  bundle exec rubocop -a


# Run Bucket as a fake CLI
cli:
  bundle exec rake bucket:cli

