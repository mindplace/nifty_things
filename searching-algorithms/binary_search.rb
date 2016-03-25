def binary_search(array, item)
  index = nil
  found = false

  slice = array
  mid_point = (slice.length - 1) / 2
  before = 0
  after = 0

  while found == false
    if slice[mid_point] > item
      p slice
      after += slice[mid_point..-1].length
      mid_point -= after
      slice = slice[0..mid_point]
    elsif slice[mid_point] < item
      p slice
      before += slice[0..mid_point].length
      mid_point -= before
      slice = slice[mid_point..-1]
    elsif slice.length < 2 || slice[mid_point] == item
      if slice[0] == item
        index = before + 1
        found = true
      elsif slice[mid_point] == item
        index = mid_point
        found = true
      end
    end
  end
  puts "#{item} has been found, index is: #{index}"
end

binary_search([1, 2, 3, 4, 5], 2)
