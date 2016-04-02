namespace :bucket do
  task :cli do
    last_input = ''

    puts "Opening local connection to #bucket... done."
    puts "You are free to start chatting with Bucket."

    bucket = Bucket::Bucket.new

    while last_input != 'exit' && last_input != 'quit'
      print ">> "
      last_input = $stdin.gets.chomp

      message = Message.new(
        user_name: 'CLI',
        text: last_input
      )

      message_response = bucket.process(message)
      puts "<< #{message_response}".yellow if message_response.present?
    end
  end
end

task :bucket => 'bucket:cli'
