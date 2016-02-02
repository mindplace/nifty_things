class CreateList 
    attr_reader :list
    
    def initialize
        @list = []
    end

    def get_the_items
        puts "\nOk, let's make your accountability list.\n\n"
        puts "Enter each item. When you've put in your last item,"
        puts "press enter on an empty line to finish.\n\n"
        puts "Please enter a personal daily standard:\n\n"
        standard = gets.chomp
        while true
            break if standard.empty?
            @list << standard
            puts "\nEnter another:\n\n"
            standard = gets.chomp
        end
    end

    def push_to_file(username)
        file_name = "lists/#{username}.txt"
        File.open(file_name, "w") do |line|
            line.puts list
        end
    end

    def create_list
        get_the_items
        puts "\nYour list has been recorded."
        puts "\nYou can use this list as your checklist every day,"
        puts "or create a new one whenever you wish.\n\n"
        puts "To access your list, let's set your username."
        puts "Enter a username:"
        username = gets.chomp
        puts "Username is #{username}.\n\n"
        push_to_file(username)
        puts "\nYour list has been saved."
        username
    end
end
