class DataParsing
    attr_reader :username, :data, :file_name
    
    def initialize(username)
        @username = username
        @data = get_file
        @file_name = ""
        p data
    end
    
    def get_file
        file_name = "lists/" + username + "_tracker.txt"
        data = []
        lines = File.readlines(file_name).map(&:chomp)
        lines.each do |line|
            data << eval(line)
        end
        data
    end
    
    def create_data_file
        date = Time.now.to_s.split[0].split("-").reverse.join("/")
        @file_name = "lists/data_#{username}.txt"
        p file_name
        File.new(file_name, "w")
    end
    
    def add_to_file(item)
        item.each do |line|
            File.open(file_name, "a") do |file_line|
                file_line.puts line
            end
        end
    end
    
    def daily_checklists_graph
    end
    
    def parse
        create_data_file
        #add_to_file(daily_checklists_graph)
        #other data features here
        #File.close(file_name)
    end
end