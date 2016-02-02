require_relative 'checklist'
require_relative 'create_list'
require_relative 'data_parsing'

def show_data(username)
    data = DataParsing.new(username)
    data.parse
    puts "Your data is available in the folder 'lists',"
    puts "titled 'data_#{username}.txt'."
    puts "\nHave a great evening :)"
end

def daily_review
    puts "Accountability checklist"
    puts "\nPress enter to start review, or type 'n' to make a new list:"
    answer = gets.chomp
    if answer.include?("n")
        list = CreateList.new
        username = list.create_list
        checklist = list.list
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

#username = daily_review
puts "Would you like to look at your to-date accountability data?\n\n"
answer = gets.chomp
show_data("mindplace") if answer.include?("y")