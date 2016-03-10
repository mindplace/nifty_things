# current features:
#   creates file of parsed data
#   creates simple chart of success rate for each standard, with percentages
#   average daily percentage rate of success
#   lists standards that have low success rates
#   provides graph of daily success rates over time

class DataParsing
    attr_reader :username, :data, :file_name
    attr_accessor :all_met, :all_unmet, :low_rate, :dailies
    
    def initialize(username)
        @username = username
        @data = get_file
        @file_name = ""
        @all_met = []
        @all_unmet = []
        @low_rate = []
        @dailies = []
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
    
    def count_up_all_met_and_unmet
        data.each do |set|
            @all_met << set[1] unless set[1].empty?
            @all_unmet << set[2] unless set[2].empty?
        end
        
        met_hash = Hash.new(0)
        @all_met.flatten.each{|key| met_hash[key] += 1}
        @all_met = met_hash
        
        unmet_hash = Hash.new(0)
        @all_unmet.flatten.each{|key| unmet_hash[key] += 1}
        @all_unmet = unmet_hash
    end
    
    def get_date
        date = Time.now.to_s.split[0].split("-").reverse
        date[0], date[1] = date[1], date[0]
        date.join("/")
    end
    
    def create_data_file
        @file_name = "lists/data_#{username}.txt"
        File.open(file_name, "w") do |f| 
            f.puts get_date
            f.puts "Data date range: #{data.first[0]} - #{data.last[0]}\n\n"
            f.puts " ~ Accountability standards:\n\n"
            f.puts File.readlines("lists/#{username}.txt")
            f.puts "\n\n"
        end
    end
    
    def add_to_file(item)
        item.each do |line|
            File.open(file_name, "a") do |file_line|
                file_line.puts line
            end
        end
    end

    def daily_checklists_graph
        graph = [[" ~ Review of daily checklists by item:\n\n"]]
        
        width = all_met.values.max * 3
        all_met.each do |key, value|
            key_unmet = all_unmet[key].nil? ? 0 : all_unmet[key]
            met_string = "x" * value
            unmet_string = "_" * key_unmet
            percent = ((value.to_f / (value + key_unmet).to_f) * 100).round(2)
            @low_rate << key if percent < 40
            percent = percent.to_s + "% | "
            dataline = [(met_string + unmet_string) + " | ", percent, key]
            length = dataline[0..1].join.length
            spaces = " " * (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end

        all_unmet.each do |key, value|
            next if all_met.keys.include?(key)
            @low_rate << key 
            unmet_string = ("_" * value) + " | "
            dataline = [unmet_string, "0% | ", key]
            length = dataline[0..1].join.length
            spaces = " " + (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end
        @low_rate << "Nothing here. Great work :)" if low_rate.empty?
        graph
    end
    
    def global_rate
       success = all_met.values.inject(:+)
       failure = all_unmet.values.inject(:+)
       rate = ((success.to_f / (failure.to_f + success.to_f)) * 100).round(2)
       ["\n\n ~ Average daily success rate: #{rate}%"]
    end
    
    def generate_dailies
        data.each do |set|
            success = set[1].length
            failure = set[2].length
            @dailies << ((success.to_f / (failure.to_f + success.to_f)) * 100).round(2)
        end
    end
    
    def low_success_rate_standards
        [["\n\n ~ Standards with success rates below 40%:\n\n"], low_rate]
    end
    
    def dailies_graph_locations
        dailies_locations = []
        dailies.each_with_index do |item, i|
            item = (item.round / 10).round
            dailies_locations << [(11 - item), i + 1]
        end
        dailies_locations
    end
    
    def graphed_success_over_time
        dailies_graph = Graph.new(dailies_graph_locations, dailies.length)
        dailies_graph.graph
    end
    
    def parse
        count_up_all_met_and_unmet
        generate_dailies
        create_data_file
        add_to_file(daily_checklists_graph)
        add_to_file(global_rate)
        add_to_file(low_success_rate_standards)
        add_to_file(graphed_success_over_time)
        display_data
    end
    
    def display_data
        puts "\n\n" 
        puts File.readlines("lists/data_#{username}.txt")
        puts "\n\n\n"
    end
end

class Graph < Array
    attr_accessor :graph, :locations
    def initialize(locations, size)
        @locations = locations
        @graph = new_graph(size)
        populate_locations
    end
    
    def new_graph(size)
        array = Array.new(12) {Array.new(size + 1)}
        array[-1] = (0..size).to_a.map(&:to_s).join(" ").gsub("0", "   ")
        array.dup.each_index do |row_index|
            next if row_index == array.length - 1
            array[row_index][0] = array.length - (row_index + 2)
        end
        array
    end
    
    def populate_locations
        locations.each do |set|
            @graph[set[0]][set[1]] = "*"
        end
        
        graph.each_with_index do |row, i|
            break if i == graph.length - 1
            row.each_with_index do |pos, j|
                graph[i][j].nil? ? @graph[i][j] = " " : @graph[i][j]
            end
            @graph[i] = @graph[i].insert(1, " ").join(" ")
        end
        ending = ["\ny-axis: success percentage in tens", "x-axis: days"]
        @graph = ["\n\n ~ Success rates over time:\n\n"] + graph + ending
    end
end