begin

  require 'colored'

  namespace :brakeman do
    desc 'Run Brakeman'
    task :run do
      system 'brakeman -z'
      raise 'Brakeman failed'.red unless $CHILD_STATUS.success?
    end
  end

rescue LoadError
  nil
end
