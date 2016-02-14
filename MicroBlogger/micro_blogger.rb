require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    @client = JumpstartAuth.twitter
  end

  def tweet
    puts "\nWhat would you like to tweet?"
    print ">  "
    message = gets.chomp

    if message.length < 140
      @client.update(message)
      puts "Tweet posted!"
    else raise "Tweet too long to post"
    end
  end

  def direct_message
    puts "stuff"
  end
end

if __FILE__ == $PROGRAM_NAME
  blogger = MicroBlogger.new
  puts "\nWelcome to the JSL Twitter client!"
  puts "Available commands:"
  puts "   q => quit"
  puts "   dm => direct message "
  puts "   t => tweet\n\n"
  command = ""
  commands = {"dm" => "direct_message", "t"=>"tweet", "q"=>"quit"}
  while command != "quit"
    print "Enter command:  "
    command = commands[gets.chomp]
    if blogger.respond_to?(command)
      blogger.send(command)
      puts
    elsif command == "quit"
      break
    else
      puts "Sorry, that command is not set!"
    end
  end
  puts "\nThanks for using the JSL Twitter client!\n\n"
end
