#!ruby
# Day 3
# See http://adventofcode.com/day/3

DELIM = "|"
cur_x = 0
cur_y = 0
cur_x2 = 0
cur_y2 = 0

houses = {}
houses["0|0"] = 2

File.open('day3.data').each do |line|
  continue if(line.nil?)
  
   #<>^v
   i = 0
   line.each_char do |c|
    i += 1   
    if(i % 2 == 0)
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
      puts "1"
    else
      if(c == '<')
        cur_x2 -= 1
      elsif(c == '>')
        cur_x2 += 1
      elsif(c == '^')
        cur_y2 += 1
      elsif(c == 'v')
        cur_y2 -= 1
      end
      key = "#{cur_x2}#{DELIM}#{cur_y2}"
      puts "2"
    end
    
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