#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/2

reports = []
File.open('day2.data').each do |line|
  next if(line.nil?)
  reports << line.split(' ').map(&:to_i)
end

def report_unsafe_indices(levels, verbose = false, forced = false)
  all_decreasing = true
  all_increasing = true
  none_greater_than_three = true
  all_greater_than_one = true

  unsafe_indicies = []
  levels.length.times do |i|
    if(i > 0)
      #Check if The levels are either all increasing or all decreasing.
      if(levels[i] >= levels[i-1])
        all_decreasing = false
      end
      if(levels[i] <= levels[i-1])
        all_increasing = false
      end
      if(all_decreasing == false && all_increasing == false)
        #this will treat every index after the first wrong direction as unsafe, will optimize later
        unsafe_indicies << i - 1
        unsafe_indicies << i
        next
      end

      #Any two adjacent levels differ by at least one and at most three.
      delta = (levels[i] - levels[i-1]).abs
      if(delta > 3)
        unsafe_indicies << i
      end
      if(delta < 1)
        unsafe_indicies << i
      end
    end

    if(forced)
      unsafe_indicies << i
    end
  end

  safe = unsafe_indicies.length == 0
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
      output += ": Safe"
    end
    puts output + "\n"
  end

  return unsafe_indicies
end


def check_report_safe?(levels, verbose = false)
  unsafe_indicies = report_unsafe_indices(levels, verbose)
  if(verbose)
    puts "Unsafe Indicies: #{unsafe_indicies.join(',')}\n"
  end

  return unsafe_indicies.length == 0
end

# Part 1
puts "======= Part 1 =======\n"
p1_safe_count = 0
reports.each do |levels|
  safe = check_report_safe?(levels, false)
  if(safe)
    p1_safe_count += 1
  end
end

puts "Safe Count: #{p1_safe_count}\n"


# Part 2
puts "\n======= Part 2 =======\n"
p2_safe_count = 0
verbose = false
reports.each_with_index do |levels, r|
  deep_verbose = r == 7
  unsafe_indicies = report_unsafe_indices(levels, verbose, true)
  safe = unsafe_indicies.length == 0
  if(!safe)
    #Remove one unsafe index at a time and check if the levels are safe
    unsafe_indicies.each do |ui|
      levels_copy = levels.dup
      levels_copy.delete_at(ui)

      safe = check_report_safe?(levels_copy, deep_verbose)
      if(safe)
        if(verbose)
          puts "Fixed unsafe index #{ui} (#{levels[ui]}) by removing it."
        end
        safe = true
        break
      end
    end
  end
  if(safe)
    p2_safe_count += 1
  elsif(r < 20)
    puts "(#{r}) Unsafe: #{levels.join(' ')}\n"
  end
end
puts "Safe Count: #{p2_safe_count}\n"