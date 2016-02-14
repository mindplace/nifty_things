require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length < 140
      @client.update(message)
      puts "Tweet posted!"
    else raise "Tweet too long to post"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  blogger = MicroBlogger.new
  puts "What would you like to tweet?"
  print ">  "
  message = gets.chomp
  blogger.tweet(message)
end
