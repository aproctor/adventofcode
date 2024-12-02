#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/2

reports = []
File.open('day2.data').each do |line|
  next if(line.nil?)
  reports << line.split(' ').map(&:to_i)
end


p1_safe_count = 0
reports.each do |levels|
  safe = true
  all_decreasing = true
  all_increasing = true
  none_greater_than_three = true
  all_greater_than_one = true

  levels.length.times do |i|
    if(i > 0)
      #Check if The levels are either all increasing or all decreasing.
      if(levels[i] >= levels[i-1])
        all_decreasing = false
      end
      if(levels[i] <= levels[i-1])
        all_increasing = false
      end

      #Any two adjacent levels differ by at least one and at most three.
      delta = (levels[i] - levels[i-1]).abs
      if(delta > 3)
        none_greater_than_three = false
      end
      if(delta < 1)
        all_greater_than_one = false
      end
    end
  end

  safe = none_greater_than_three && all_greater_than_one && (all_decreasing || all_increasing)
  if(safe)
    p1_safe_count += 1
  end

  verbose = false
  if(verbose && !safe)
    #Build output string
    #eg: "1 2 7 8 9: Unsafe because 2 7 is an increase of 5."
    output = levels.join(' ')
    if(!safe)
      if(!none_greater_than_three)
        output += ": Unsafe because there is a difference greater than 3."
      elsif(!all_greater_than_one)
        output += ": Unsafe because there is a difference less than 1."
      elsif(!all_decreasing && !all_increasing)
        output += ": Unsafe because the levels are neither all increasing nor all decreasing."
      end
    else
      #output += ": Safe"
    end
    puts output + "\n"
  end
end

puts "Part 1 Safe Count: #{p1_safe_count}"
