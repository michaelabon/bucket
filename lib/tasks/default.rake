begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts 'No rspec available'
end

task(:default).clear.enhance(
  %w[
    brakeman:run
    spec
    rubocop
  ]
)
