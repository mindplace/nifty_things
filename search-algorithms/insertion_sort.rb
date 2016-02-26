
def insertion_sort(array)
    sorted = false
    while sorted == false
        array.each_index do |i|
            next if i == 0
            a = array[i]
            b = array[i - 1]
            
            if a < b 
                sorted = false
                location = array.index(array[0..i].find{|x| a < x}) 
                location = 0 if location.nil?
                array = array - [a]
                array.insert(location, a)
                break
            end
            sorted = true
        end
    end
    p array
end

insertion_sort([4, 6, 3, 11, 9, 2, 3])