namespace :bucket do
  desc 'Run Bucket as a fake CLI'
  task :cli do
    puts 'Opening local connection to #bucket... done.'
    puts 'You are free to start chatting with Bucket.'

    def bucket
      @bucket ||= Bucket::Bucket.new
    end

    def read_input
      print '>> '
      $stdin.gets.chomp
    end

    def process_input(input)
      exit if exit?(input)

      message = Message.new(
        user_name: 'CLI',
        text: input
      )

      bucket.process(message)
    end

    def output_response(message_response)
      puts "<< #{message_response}".yellow if message_response.present?
    end

    def exit?(input)
      %w[exit quit].include?(input)
    end

    loop do
      output_response(process_input(read_input))
    end
  end
end

task bucket: 'bucket:cli'
