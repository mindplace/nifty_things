require_relative 'checklist'
require_relative 'create_list'
require_relative 'data_parsing'

def show_data(username)
    puts "\nWould you like to review your current accountability data?(y/n)"
    answer = gets.chomp
    if answer.include?("y")
        data = DataParsing.new(username)
        data.parse
    end
    puts "\nYour data is in the folder 'lists', titled 'data_#{username}.txt'."
    puts "Have a great evening :)"
end

def daily_review
    puts "Accountability checklist"
    puts "\nPress enter to start review, or type 'n' to make a new list:"
    answer = gets.chomp
    if answer.include?("n")
        list = CreateList.new
        username = list.create_list
        checklist = list.list
        today = Checklist.new(username, checklist)
    else
        puts "Username?"
        username = gets.chomp
        today = Checklist.new(username)
    end
    today.daily_review
    show_data(username)
end

#daily_review
show_data("mindplace")