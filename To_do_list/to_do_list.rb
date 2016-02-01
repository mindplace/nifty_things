# To do list
# 
# This program prompts the user to enter each of the
# things they have to do today. Then it offers to save 
# the list for them in a new .txt file.
class ToDoList
    attr_reader :list
    
    def initialize
        @list = []
    end

    def get_the_items
        puts "Your to-do list!"
        puts "Enter each item. When you've put in your last item,"
        puts "press enter on an empty line to finish."
        puts "Press enter to get started."
        gets
        while true
            puts "Please enter a task."
            task = gets.chomp
            break if task.empty?
            @list << task
            puts "Got it."
        end
    end

    def put_list
        puts "Ok! Here is your list:"
        list.each do |item|
	       puts "#{(list.index(item)).to_i + 1}. #{item}"
        end
    end

    def heading
    date = Time.now.to_s.split[0]
    "#{date}\n
Today's to-do list:\n\n"
    end

    def push_to_file
        puts "Sure! What should the filename be?"
        name = gets.chomp
        file_name = name + ".txt"
        
        exported_list = File.new(file_name, "w")
        exported_list << heading
        list.each_with_index do |item, i|
            exported_list << "#{i + 1}. #{item}\n"
        end
        puts "Your to-do list is now in #{file_name}." 
    end

    def create_to_do_list
        get_the_items
        puts "Would you like to save your list in a file, yes or no?"
        answer = gets.chomp.downcase
        if answer.include?("y")
            push_to_file
        else
            put_list
        end
        puts "Have a great day :)"
    end
end

if __FILE__ == $PROGRAM_NAME
    list = ToDoList.new
    list.create_to_do_list
end
