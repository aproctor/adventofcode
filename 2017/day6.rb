#!/usr/bin/env ruby
# Day 6 2017
# See http://adventofcode.com/2017/day/6

MAX_ITERATIONS = 1000000


def part1(row)
  banks = []
  row.gsub(/\s+/m, ' ').strip.split(" ").each do |val|
    banks << val.to_i
  end
  
  seen_patterns = {}
  MAX_ITERATIONS.times do |i|
    key = banks.join(',')
    puts "#{i}: #{key}"
    return i if(seen_patterns[key])
    seen_patterns[key] = 1

    max_val = banks.max
    #Replace max value amongst array
    banks.length.times do |j|
      if(banks[j] == max_val)
        #redistribute value amongst all cells
        banks[j] = 0

        (j+1..j+max_val).each do |k|
          banks[k%banks.length] += 1
        end

        break
      end
    end

  end

  return 0
end

#puts part1("0 2 7 0")
# puts part1("4 10  4 1 8 4 9 14  5 1 14  15  0 15  3 5")


#Find length till duplicate
def part2(row)
  banks = []
  row.gsub(/\s+/m, ' ').strip.split(" ").each do |val|
    banks << val.to_i
  end
  
  seen_patterns = {}
  MAX_ITERATIONS.times do |i|
    key = banks.join(',')
    puts "#{i}: #{key}"
    return i - seen_patterns[key] if(seen_patterns[key])
    seen_patterns[key] = i

    max_val = banks.max
    #Replace max value amongst array
    banks.length.times do |j|
      if(banks[j] == max_val)
        #redistribute value amongst all cells
        banks[j] = 0

        (j+1..j+max_val).each do |k|
          banks[k%banks.length] += 1
        end

        break
      end
    end

  end

  return 0
end

# puts part2("0 2 7 0")
puts part2("4 10  4 1 8 4 9 14  5 1 14  15  0 15  3 5")
