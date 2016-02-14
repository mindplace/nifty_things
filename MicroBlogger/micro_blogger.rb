require 'jumpstart_auth'
require 'klout'

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

  def send_dm(username)
    print "\nMessage:   "
    message = "d #{username} #{gets.chomp}"

    if message.length < 140
      @client.update(message)
      puts "Message sent!"
    else raise "Message too long to send"
    end
  end

  def route_dm
    puts "\nFriends: #{friends.join(", ")}"
    print "\nSend message to:   "
    target = gets.chomp
    if friends.include?(target)
      sending_to_target = MicroBlogger.new
      sending_to_target.send_dm(target)
    else puts "Sorry, can't DM someone who isn't your friend!"
    end
  end

  def friends
    client.followers.map{|person| client.user(person).screen_name}
  end

  def get_all_latest_friends_tweets
    client.followers.each do |friend|
      puts
      puts client.user(friend).screen_name
      puts client.user(friend).status.text
      puts friend_klout_score(client.user(friend).screen_name).round(2)
    end
  end
  
  def friend_klout_score(screenname)
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
    identity = Klout::Identity.find_by_screen_name(screenname)
    user = Klout::User.new(identity.id)
    user.score.score
  end
end

if __FILE__ == $PROGRAM_NAME
  blogger = MicroBlogger.new
  puts "\nWelcome to the JSL Twitter client!"
  puts "Available commands:"
  puts "   q => quit"
  puts "   dm => direct message "
  puts "   t => tweet"
  puts "   g => see all the latest tweets from friends\n\n"
  command = ""
  commands = {"dm" => "route_dm", "t"=>"tweet", "q"=>"quit",
              "g" => "get_all_latest_friends_tweets"}
  while command != "quit"
    print "Enter command:  "
    command = commands[gets.chomp]
    if blogger.respond_to?(command)
      blogger.send(command)
      puts
    elsif command == "quit"
      break
    else puts "Sorry, that command is not set!"
    end
  end
  puts "\nThanks for using the JSL Twitter client!\n\n"
end
