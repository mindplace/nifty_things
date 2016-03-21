module ExtraArrayMethods
  def average(*nums)
    nums.dup.inject(:+) / nums.length
  end

  def median(*nums)
    nums = nums.uniq.sort

    if nums.length < 4
      return nums[0] if nums.length == 1
      if nums.length == 2
        med = nums.dup.inject(:+).to_f / nums.length
        if med == med.round
          return med.round
        else return med
        end
      end
      return nums[1]
    end

    median(*nums[1..-2])
  end

  def mode(*nums)
    frequencies = Hash.new(0)
    nums.sort.each{|num| frequencies[num] += 1}
    modes = frequencies.select{|k, v| v == frequencies.values.max}
    modes.keys.length == 1 ? modes.keys[0] : modes.keys
  end
end

class Calculator
  extend ExtraArrayMethods
  
  def self.method_missing(method, *nums)
    operators = {add: :+, subtract: :-, multiply: :*, divide: :/}
    if operators.keys.include?(method) 
      nums.inject(operators[method])
    else
      "Sorry, '#{method.to_s}' method not available!"
    end
  end
end

p Calculator.add(6, 5, 9) # => 20
p Calculator.multiply(2, 4) # => 8
p Calculator.tester(2, 3, 4) # => "Sorry, 'tester' method not avilable!"
p Calculator.median(1, 2, 3, 4) # => 2.5
p Calculator.median(1, 2, 3, 4, 5) # => 3
p Calculator.mode(2, 2, 2, 6, 5, 8, 8, 8, 8, 5) # => 8
p Calculator.mode(2, 2, 2, 2, 6, 5, 8, 8, 8, 8, 5) # => [2, 8]
