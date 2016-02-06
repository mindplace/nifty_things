class Quiz
    attr_reader :sets, :results, :export
    
    CS = ["Realistic", "Organized", "Getting to the point", "Practical", "Precise", 
            "Orderly", "Perfectionist", "Hardworking", "Planner", "Memorize", "Wants direction", 
            "Cautious", "Practicing", "Completing work", "Doing"]
    AS = ["Analytical", "Critical", "Debating", "Academic", "Systematic", "Sensible", "Logical", "Intellectual",
            "Reader", "Think-through", "Judger", "Reasoning", "Examining", "Gaining ideas", "Thinking"]
    AR = ["Imaginative", "Adaptable", "Relating", "Personal", "Flexible", "Sharing", "Cooperative", "Sensitive", 
            "People person", "Associate", "Spontaneous", "Communicating", "Caring", "Interpreting", "Feeling"]
    CR = ["Investigative", "Inquisitive", "Creating", "Adventurous", "Inventive", "Independent", "Competitive",
            "Risk-taking", "Problem solver", "Originate", "Changer", "Discovering", "Challenging", 
            "Seeing possibilities", "Experimenting"]
    
    def initialize
        @results = {"CS"=>0, "AS"=>0, "AR"=>0, "CR"=>0}
        @sets = []
        @export = []
        make_sets
    end
    
    def make_sets
        (0..14).each do |num|
            set = []
            set << CS[num]
            set << AS[num]
            set << AR[num]
            set << CR[num]
            @sets << set
        end
    end
    
    def locate_set(item)
        set = "CS" if CS.include?(item)
        set = "AS" if AS.include?(item)
        set = "AR" if AR.include?(item)
        set = "CR" if CR.include?(item)
        set
    end
    
    def update_results(item)
       @results[locate_set(item)] += 1
    end
    
    def print_current_set(set, num)
        to_export = [[set.map{|x| "#{x} => #{locate_set(x)}"}]]
        set = set.shuffle
        a = set[0]; b = set[1]; c = set[2]; d = set[3]
        puts "\nSet #{num + 1}:"
        puts "a. #{a}, b. #{b}, c. #{c}, d. #{d}"
        print "Choices:  "
        answer = gets.chomp.split(",").map(&:strip)
        answer_array = []
        answer.each do |letter|
            letter = a if letter == "a"
            letter = b if letter == "b"
            letter = c if letter == "c"
            letter = d if letter == "d"                 
            update_results(letter)
            answer_array << letter
        end
        to_export << answer_array
        @export << to_export
    end
    
    def send_export
        types = ["Concrete Sequential", "Abstract Sequential", "Abstract Random", "Concrete Random"]
        File.open("quiz_results/#{Time.now.to_s.split[0..1].join("_")}.txt", "w") do |line|
            line.puts Time.now.to_s.split[0..1].join(", ") + "\n\n"
            line.puts "Personal Thinking Style - Quiz results\n\n"
            line.puts "   Results:\n\n"
            results.values.each_index do |i|
                item = results.values[i]
                line.puts "#{types[i]}: #{item}"
            end
            line.puts "\n\n   Word sets and answers:\n\n"
            export.each_index do |i|
                set = export[i]
                set[0] = "[#{set[0].join(", ")}] "
                set[1] = set[1].join(", ")
                line.puts "Set #{i + 1}: #{set[0]}"
                line.puts "     Your choices: #{set[1]}\n\n"
            end
        end
    end
    
    def serve_quiz
        puts "For each set of words, choose the 2 that best describe you."
        puts "Enter 2 choices per set, like so: a,c"
        (0..14).each do |num|
            print_current_set(sets[num], num)
        end
        puts "\n\nQuiz is complete! Here are your scores:\n\n"
        types = ["Concrete Sequential", "Abstract Sequential", "Abstract Random", "Concrete Random"]
        results.values.each_index do |i|
            item = results.values[i]
            puts "#{types[i]}: #{item}"
        end
        send_export
        puts "\n\nYour results are saved in quiz_results folder under the current timestamp."
    end
end 


if __FILE__ == $PROGRAM_NAME
    puts "Personal Thinking Style Quiz\n\n"
    puts "Press enter to begin:"
    gets
    quiz = Quiz.new
    quiz.serve_quiz
end