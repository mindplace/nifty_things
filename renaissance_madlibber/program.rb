# Incident the third:
# sentimental mead hall song (chaucer hath a blog)

class Adventure
    attr_reader :user, :gender
    
    def initialize(name)
        @user = name
        @gender = set_gender
    end
    
    def set_gender
       print "Art thou a she, a he, or sommat else? (she, he, else)   "
       answer = gets.chomp
       gender = ["She", "she", "Her", "her"] if answer == "she"
       gender = ["He", "he", "His", "his"] if answer == "he"
       gender = ["Their", "their", "Their", "their"] if answer == "else"
       gender
    end
    
    def singeres
        lines = File.readlines("singeres.txt")
        print "\n[Press enter to go to the next line!]"
        gets
        lines.each do |line|
            print eval(line); gets
        end
    end
    
    def pirates
        puts "\nAhoy, the villain!"
        insult = ["blogger", "nincompoop", "Queen's assassin"].sample
        puts "\nBehold, lads, we have ourselves a #{insult}!"
        print "\n[do you respond to this insulting language?!]   "
        gets
        puts "\nNay, verily thou art a #{insult}! Thou art the v'ry spit of a #{insult}!"
        print "\n[insult back!!]   "
        gets
        puts "\nAh, insult me, wilt thou? Come at me, thou yellow-bellied #{insult}!" 
        puts "I fart in yer general direction!!"
        puts "Yer mother was a #{["hamster", "hedgehog", "goldfish"].sample}, and yer father"
        puts "smelt of #{["elderberries", "coconuts", "pineapples"].sample}!!"
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Art thou lost, wanderer? Ich shall pointe thou in thy correct diurectioun!"
    print "What is thy name?   "
    name = gets.chomp
    puts "\nAh, well come, well come, dear #{name}!"
    print "\nDost thou prefer singeres or pirates? (1, 2, or q)   "
    commands = {"1"=>"singeres", "2"=>"pirates", "q"=>"quit"}
    answer = commands[gets.chomp]
    experience = Adventure.new(name)
    
    while answer != "quit"
        if experience.respond_to?(answer)
            experience.send(answer)
        else puts "\nOch, thou art an all-disliking buggerer! Away with thee!!"
        end
        
        puts "\nOch! What a strange adventurie! Wilst thou hast anothere?"
        puts "Knightes, singeres, pirates, or leave this place? (1, 2, 3, or q)"
        answer = commands[gets.chomp]
    end
    
    puts "\n\n'Tis my deare wishe that thou wast satisfied with thy adventurie :D"
end