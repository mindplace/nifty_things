require 'date'

def deadline_date_counter(year, month, day)
    end_date = Date.parse("#{year}-#{month}-#{day}")
    puts "You have #{(end_date - Date.today).to_i} days left!"
end

#deadline_date_counter(2016, 03, 22) # prints: "You have 20 days left!"

def deadline_hour_counter(year, month, day, hour)
    puts "(FYI, this counter uses the 24 hr clock.)"
    end_date = Time.new(year, month, day, hour)
    minutes_left = (end_date - Time.now).to_i / 60
    
    if minutes_left > 59
        hours_left = minutes_left / 60
        minutes_left -= (hours_left * 60)
        if hours_left > 23
            days_left = hours_left / 24
            hours_left -= (days_left * 24)
        end 
    end
    if days_left
        puts "#{days_left} days, #{hours_left} hours, #{minutes_left} minutes remaining!"
    elsif hours_left
        puts "#{hours_left} hours, #{minutes_left} minutes remaining!"
    else
        puts "#{minutes_left} minutes remaining!"
    end
end

def military(hour, period)
   if period == "am"
       hour = 12 if hour == 0
   elsif period == "pm"
       hour += 12 if hour != 12
   end 
   hour
end

#hour = military(3, "pm")
#deadline_hour_counter(2016, 03, 04, hour) # prints: "2 days, 0 hours, 25 minutes remaining!"

hour = military(10, "pm")
deadline_hour_counter(2016, 03, 05, hour) # prints: "3 days, 7 hours, 22 minutes remaining!"