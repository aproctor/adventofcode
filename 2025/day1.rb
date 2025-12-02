#!/usr/bin/env ruby
# See http://adventofcode.com/2025/day/1

# Part 1

position = 50
STEPS = 100
p1_count = 0
p2_count = 0
p2_position = position

def int_to_word(number)
  case number
  when 1
    "once"
  when 2
    "twice"
  else
    "#{number} times" # Fallback for any other integer
  end
end

puts "The dial starts by pointing at #{position}."
File.open('day1.data').each do |line|
  next if(line.nil?)
  md = line.match(/([LR])([0-9]+)/)

  if(!md.nil?)
    previous_position = position

    dir = md[1]
    steps = md[2].to_i

    if(dir == 'L')
      position -= steps
    elsif(dir == 'R')
      position += steps
    end

    position = position % STEPS

    # Calculate how many times we passed 0 during this move
    clicks = 0
    delta = (dir == 'L' ? -1 : 1)
    steps.times do |step|
      p2_position += delta
      p2_position = 0 if(p2_position == STEPS)

      if(p2_position == 0)
        p2_count += 1
        clicks += 1
      elsif(p2_position < 0)
        p2_position = STEPS - 1
      elsif(p2_position >= STEPS)
        p2_position = 0
      end
    end



    print "The dial is rotated #{dir}#{steps} to point at #{position}"
    print "; during this rotation, it points at 0 #{int_to_word(clicks)}" if clicks > 0
    puts "."
    p1_count += 1 if position == 0
  end
end

puts "Part 1: The dial pointed at 0 a total of #{p1_count} times."
puts "Part 2: The dial passed by 0 a total of #{p2_count} times."

