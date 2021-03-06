class ThoughtCounter
    attr_reader :thoughts
    
    def initialize
        @thoughts = []
    end
    
    def translate_time(seconds)
        return "#{seconds} seconds" if seconds < 60
        
        minutes = seconds / 60
        seconds = seconds % 60
        return "#{minutes} minutes, #{seconds} seconds" if minutes < 60
        
        hours = minutes / 60
        minutes = minutes % 60
        
        "#{hours} hours, #{minutes} minutes, #{seconds} seconds"
    end
        
    def record_thought(length)
        @thoughts << length
    end
    
    def print_data
        total_thoughts = thoughts.length
        puts "Total thoughts over this session: #{total_thoughts}"
        
        inbetween = translate_time(thoughts.inject(:+) / total_thoughts)
        puts "Average time between thoughts:  #{inbetween}"
        
        best_time = translate_time(thoughts.max)
        puts "Longest interval between thoughts: #{best_time}"
    end
    
    def give_instruction
        puts "Welcome to the meditation thought counter."
        puts "\nEvery time you have a thought during your session,"
        puts "press 'enter'."
        puts "\nWhen you're done with your session, type 'done'."
        puts "\nThis mini-app will record the length of your session,"
        puts "and give you some data on how many thoughts you had."
        print "\nPress enter to start:   "
        gets
    end
    
    def begin_session
        give_instruction
        puts "\nSession begins now.\n\n\n"
        start_time = Time.now
        input = ""
        until input == "done"
            start = Time.now
            print "Press enter to record having a thought, or type 'done'...   "
            input = gets.chomp
            interval = (Time.now - start).round
            record_thought(interval)
            p thoughts
        end
        total_time = translate_time(((Time.now - start_time).round))
        puts "\nTotal session length was #{total_time} long."
        
        print_data
    end
end


if __FILE__ == $PROGRAM_NAME
    meditation_session = ThoughtCounter.new
    meditation_session.begin_session
end