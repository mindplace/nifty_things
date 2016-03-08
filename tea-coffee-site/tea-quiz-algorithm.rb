require 'table_flipper'

def quiz
    teas = {"earl_grey"=>["blue", "1", "sheep"], 
            "green"=>["green", "2", "dog"], 
            "herbal"=>["red", "3", "cat"]}
    
    answers = File.readlines("tea-answers.txt")[0]
    answers = eval(answers)
    
    score = {"earl_grey"=>0, "green"=>0, "herbal"=>0}
    
    answers.each do |key, value|
        teas.each do |tea, array|
            score[tea] += 1 if array.include?(value)
        end
    end
    p score
    
    result = score.sort_by{|key, value| value}.last[0]
    puts "Your best tea match is #{result} tea!"
    
end

    
quiz

