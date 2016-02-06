class Quiz
    attr_reader :sets, :results
    
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
        make_sets
    end
    
    def update_results(item)
       grade = ""
       grade = "CS" if CS.include?(item)
       grade = "AR" if AR.include?(item)
       grade = "AS" if AS.include?(item)
       grade = "CR" if CR.include?(item)
       @results[grade] += 1
    end
    
    def make_sets
        (0..14).to_a.each do |num|
            set = []
            set << CS[num]
            set << AS[num]
            set << AR[num]
            set << CR[num]
            @sets << set
        end
    end
    
    def serve_quiz
        puts "For each set of words, choose the 2 that best describe you."
        puts "For example, given a. thoughtful, b. spontaneous, c. considerate, if you choose"
        puts "thoughtful and spontaneous, write a,b."
        (0..14).to_a.each do |num|
            set = sets[num]
            a = set[0]; b = set[1]; c = set[2]; d = set[3]
            puts "\nSet #{num + 1}:"
            puts "a. #{a}, b. #{b}, c. #{c}, d. #{d}"
            answer = gets.chomp.split(",")
            answer.each do |letter|
                letter = a if letter == "a"
                letter = b if letter == "b"
                letter = c if letter == "c"
                letter = d if letter == "d" 
                update_results(letter)
            end
        end
        puts "\n\nQuiz is complete! Here are your scores:\n\n"
        types = ["Concrete Sequential", "Abstract Sequential", "Abstract Random", "Concrete Random"]
        results.values.each_index do |i|
            item = results.values[i]
            puts "#{types[i]}: #{item}"
        end
    end
end 


if __FILE__ == $PROGRAM_NAME
    puts "Personal Thinking Style Quiz\n\n"
    puts "Press enter to begin:"
    gets
    quiz = Quiz.new
    quiz.serve_quiz
end