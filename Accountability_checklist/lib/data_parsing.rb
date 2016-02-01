class DataParsing
    attr_reader :username, :data, :file_name
    
    def initialize(username)
        @username = username
        @data = get_file
        @file_name = ""
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
        date = Time.now.to_s.split[0].split("-").reverse.join("-") + "\n\n"
        @file_name = "lists/data_#{username}.txt"
        File.open(file_name, "w") do |f| 
            f.puts date
            f.puts "Data date range: #{data.first[0]} - #{data.last[0]}\n\n"
            f.puts "Accountability standards:"
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
        graph = [["Review of daily checklists by item:\n\n"]]
        all_met = []
        all_unmet = []
        data.each do |set|
            all_met << set[1] unless set[1].empty?
            all_unmet << set[2] unless set[2].empty?
        end
        all_met = all_met.flatten.group_by(&:itself)
        all_unmet = all_unmet.flatten.group_by(&:itself)
        width = 17
        all_met.each do |key, value|
            key_met = value.length
            key_unmet = all_unmet[key].nil? ? 0 : all_unmet[key].length
            met_string = "x" * key_met
            unmet_string = "_" * key_unmet
            percent = ((key_met.to_f / (key_met + key_unmet).to_f) * 100).round(2).to_s + "% | "
            dataline = [(met_string + unmet_string) + " | ", percent, key]
            length = dataline[0..1].join.length
            spaces = " " * (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end

        all_unmet.each do |key, value|
            next if all_met.keys.include?(key)
            key_unmet = value.length
            unmet_string = ("_" * key_unmet) + " | "
            dataline = [unmet_string, "0% | ", key]
            length = dataline[0..1].join.length
            spaces = " " * (width - length)
            dataline[0..1] = dataline[0..1].join(spaces)
            graph << dataline.join
        end
        graph
    end
    
    def parse
        create_data_file
        add_to_file(daily_checklists_graph)
        file_name = "lists/" + username + "_tracker.txt"
        File.close(file_name)
    end
end

# current features:
#   creates file of parsed data
#   creates simple chart of success rate for each standard, with percentages
# 
# upcoming features:
#   lists standards that have low success rates - "Things to work on"
#   success and failure rates over time - "Graphs"
#   global percentage rate of success and failure - "Global stats"