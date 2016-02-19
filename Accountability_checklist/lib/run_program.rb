require_relative 'checklist'
require_relative 'create_list'
require_relative 'data_parsing'
require_relative '../../MicroBlogger/micro_blogger'

def show_data(username)
    data = DataParsing.new(username)
    data.parse
    puts "Your data is available in the folder 'lists',"
    puts "titled 'data_#{username}.txt'."
end

def daily_review
    puts "Accountability checklist"
    puts "\nPress enter to start review, or type 'n' to make a new list:"
    answer = gets.chomp
    if answer.include?("n")
        list = CreateList.new
        username = list.create_list
        list.list
        puts "Now let's do your daily review."
    else
        puts "Username?"
        username = gets.chomp
    end
    today = Checklist.new(username)
    today.daily_review
    puts "Daily review is complete.\n\n"
    username
end

def send_tweet
    todays_tweet = MicroBlogger.new
    todays_tweet.tweet 
end
    
username = "mindplace"
puts "Would you like to look at your to-date accountability data?\n\n"
answer = gets.chomp
show_data(username) if answer.include?("y")

puts "\n\nWould you like to tweet about your successes?"
answer = gets.chomp
send_tweet if answer.include?("y")