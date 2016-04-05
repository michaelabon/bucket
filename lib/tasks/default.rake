task(:default).clear.enhance(
  %w(
    brakeman:run
    spec
    rubocop
  )
)
