begin

  require 'colored'

  namespace :brakeman do
    desc 'Run Brakeman'
    task :run do
      system 'brakeman -z'
      raise "Brakeman failed".red unless $?.success?
    end
  end

rescue LoadError
end
