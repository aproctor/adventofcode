#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/3


##########
# Part 1 #
##########

def part1_multiply_all_matches(multiples, verbose = false)
  total = 0
  buffer = []

  multiples.each do |m|
    total += m[0].to_i * m[1].to_i
    buffer << "#{m[0]}*#{m[1]}"
  end

  puts buffer.join(" + ") + " = #{total}" if verbose

  total
end

multiples = []
File.open('day3.data').each do |line|
  next if(line.nil?)
  md = line.scan(/mul\(([0-9]{1,3}),([0-9]{1,3})\)/)
  if(!md.nil?)
    multiples.concat md
  end
end

puts "Part 1"
p1_total = part1_multiply_all_matches(multiples, false)
puts p1_total


##########
# Part 2 #
##########

puts "Part 2"

multiples = []
accept_multiples = true
File.open('day3.data').each do |line|
  next if(line.nil?)

  line.each_char.with_index do |c, i|
    if(c == ')')
      #command is the substring of at most 12 characters before the closing parenthesis
      start = [0, i-12].max
      command_buffer = line[start..i]
      #puts "#{i}: " + command_buffer
      if command_buffer.end_with?("do()")
        #puts "do command at character #{c},#{i}  #{command_buffer}"
        accept_multiples = true
      elsif command_buffer.end_with?("don't()")
        #puts "don't command at character #{c},#{i}  #{command_buffer}"
        accept_multiples = false
      elsif accept_multiples
        mul_command = command_buffer.match(/mul\(([0-9]{1,3}),([0-9]{1,3})\)$/)
        #puts mul_command.inspect
        if(!mul_command.nil?)
          multiples << [mul_command[1], mul_command[2]]
        end
      end
    end
  end
end

#puts multiples.inspect
p2_total = part1_multiply_all_matches(multiples, false)
puts p2_total
