begin
  require 'colored'

  namespace :brakeman do
    desc 'Run Brakeman'
    task run: :environment do
      system 'brakeman --no-pager'
      raise 'Brakeman failed'.red unless $CHILD_STATUS.success?
    end
  end
rescue LoadError
  nil
end
