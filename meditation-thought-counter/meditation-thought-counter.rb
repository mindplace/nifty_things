
class ThoughtCounter
    attr_reader :thoughts
    
    def initialize
        @thoughts = {}
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
        @thoughts[length] = translate_time(length)
    end
    
    def print_data
        p thoughts
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
        start_time = Time.now
        input = ""
        until input == "done"
            start = Time.now
            print "Press enter, or type 'done'...   "
            input = gets.chomp
            interval = (Time.now - start).round
            record_thought(interval)
        end
        total_time = translate_time(((Time.now - start_time).round))
        puts "Total session length was #{total_time} long."
        
        print_data
    end
end


if __FILE__ == $PROGRAM_NAME
    meditation_session = ThoughtCounter.new
    meditation_session.begin_session
end