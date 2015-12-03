#!ruby
# Day 3
# See http://adventofcode.com/day/3

DELIM = "|"
cur_x = 0
cur_y = 0
houses = {}

houses["0|0"] = 1

File.open('day3.data').each do |line|
  continue if(line.nil?)
  
   #<>^v
   line.each_char do |c|

    if(c == '<')
      cur_x -= 1
    elsif(c == '>')
      cur_x += 1
    elsif(c == '^')
      cur_y += 1
    elsif(c == 'v')
      cur_y -= 1
    end

    key = "#{cur_x}#{DELIM}#{cur_y}"
    houses[key] = houses[key].to_i + 1
   end
end

total_doubled = 0
num_visited = 0
houses.each do |k, v|
  if(v > 1)
    total_doubled += 1
  end
  num_visited += 1
end

puts "Num Visited: #{num_visited}"
puts "Doubled: #{total_doubled}"