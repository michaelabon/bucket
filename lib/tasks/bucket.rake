# Interactive CLI for testing Bucket without Slack
module BucketCli
  class << self
    def run
      puts 'Opening local connection to #bucket... done.'
      puts 'You are free to start chatting with Bucket.'

      loop do
        output_response(process_input(read_input))
      end
    end

    private

    def bucket
      @bucket ||= Bucket::Bucket.new
    end

    def read_input
      print '>> '
      $stdin.gets.chomp
    end

    def process_input(input)
      exit if exit_command?(input)

      message = Message.new(
        user_name: 'CLI',
        text: input,
      )

      bucket.process(message)
    end

    def output_response(message_response)
      puts "<< #{message_response}".yellow if message_response.present?
    end

    def exit_command?(input)
      %w[exit quit].include?(input)
    end
  end
end

namespace :bucket do
  desc 'Run Bucket as a fake CLI'
  task cli: :environment do
    BucketCli.run
  end
end

desc 'Alias for bucket:cli'
task bucket: 'bucket:cli'
