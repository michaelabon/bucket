all:
  op run --env-file .env.test.env -- bundle exec rake

spec:
  op run --env-file .env.test.env -- bundle exec rake spec

lint:
  bundle exec rubocop -a

# Edit the encrypted credentials files
credentials env:
  op run --env-file .env.{{env}}.env -- bin/rails credentials:edit --environment {{env}}


# Run Bucket as a fake CLI
cli:
  op run --env-file .env.development.env -- bundle exec rake bucket:cli

