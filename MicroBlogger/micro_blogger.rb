require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
  attr_reader :client

  def initialize
    @client = JumpstartAuth.twitter
  end

  def shorten_url(message)
    puts "Shortening links..."
    
    urls = Hash.new(0)
    url = message.split.select{|item| item.include?("http") || item.include?("www")}
    text = message.split.select{|item| !url.include?(item)}.join(" ")
    
    url.each do |item|
      url_index = message.split.index(item)
      item = "https://" + item unless item.include?("https://")
      Bitly.use_api_version_3
      bitly = Bitly.new("o_32nseoo04a", "R_e2413eceb5864896acc36846a63b4aa9")
      item = bitly.shorten(item).short_url
      urls[item] = url_index
    end
    
    new_message = text
    urls.each do |item, i|
      new_message = new_message.split.insert(i, item).join(" ")
    end
    
    puts "New tweet: #{new_message}"
    new_message
  end
  
  def tweet
    puts "\nWhat would you like to tweet?"
    print ">  "
    message = gets.chomp
    
    if message.include?("http") || message.include?("www")
      message = shorten_url(message)
    end

    if message.length < 140
      @client.update(message)
      puts "Tweet posted!"
    else puts "Tweet too long to post"
    end
  end

  def send_dm(username)
    print "\nMessage:   "
    message = "d #{username} #{gets.chomp}"

    if message.length < 140
      @client.update(message)
      puts "Message sent!"
    else puts "Message too long to send"
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
    end
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
