# current features:
#   creates file of parsed data
#   creates simple chart of success rate for each standard, with percentages
#   global and average daily percentage rate of success

# upcoming features:
#   lists standards that have low success rates - "Things to work on"
#   success and failure rates over time - "Graphs"

class DataParsing
    attr_reader :username, :data, :file_name
    attr_accessor :all_met, :all_unmet
    
    def initialize(username)
        @username = username
        @data = get_file
        @file_name = ""
        @all_met = []
        @all_unmet = []
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
        
        width = 17
        all_met.each do |key, value|
            key_unmet = all_unmet[key].nil? ? 0 : all_unmet[key]
            met_string = "x" * value
            unmet_string = "_" * key_unmet
            percent = ((value.to_f / (value + key_unmet).to_f) * 100).round(2).to_s + "% | "
            dataline = [(met_string + unmet_string) + " | ", percent, key]
            length = dataline[0..1].join.length
            spaces = " " * (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end

        all_unmet.each do |key, value|
            next if all_met.keys.include?(key)
            unmet_string = ("_" * value) + " | "
            dataline = [unmet_string, "0% | ", key]
            length = dataline[0..1].join.length
            spaces = " " * (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end
        graph
    end
    
    def global_rate
       success = all_met.values.inject(:+)
       failure = all_unmet.values.inject(:+)
       rate = ((success.to_f / (failure.to_f + success.to_f)) * 100).round(2)
       "Overall success rate: #{rate}%"
    end
    
    def daily_rate
        dailies = []
        data.each do |set|
            success = set[1].length
            failure = set[2].length
            dailies << ((success.to_f / (failure.to_f + success.to_f)) * 100).round(2)
        end
        rate = (dailies.inject(:+) / dailies.length).round(2)
        "Average daily success rate: #{rate}%"
    end
            
    
    def global_and_daily_overall_rates
        [["\n\n ~ Averaged success rates:\n\n"], [global_rate], [daily_rate]]
    end
    
    def parse
        count_up_all_met_and_unmet
        create_data_file
        add_to_file(daily_checklists_graph)
        add_to_file(global_and_daily_overall_rates)
        display_data
    end
    
    def display_data
        puts "\n\n" 
        puts File.readlines("lists/data_#{username}.txt")
        puts "\n\n\n"
    end
end
