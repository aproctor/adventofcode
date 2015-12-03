#!ruby
# Day 3
# See http://adventofcode.com/day/3

DELIM = "|"

class Santa
  def initialize
    @cur_x = 0
    @cur_y = 0    
  end

  def deliver(direction, house_map)
    if(direction == '<')
      @cur_x -= 1
    elsif(direction == '>')
      @cur_x += 1
    elsif(direction == '^')
      @cur_y += 1
    elsif(direction == 'v')
      @cur_y -= 1
    end
    key = "#{@cur_x}#{DELIM}#{@cur_y}"

    house_map[key] = house_map[key].to_i + 1
  end
end


# Part1 - 1 santa
# first house starts off with a single present
houses = {}
houses["0|0"] = 1
santa = Santa.new

File.open('day3.data').each do |line|
  continue if(line.nil?)   
   line.each_char do |c|
    santa.deliver(c, houses)
   end
end
puts "Part 1 Num Visited: #{houses.keys.count}"



# Part2 - 2 santas
#both drop off initial presents at the first house
houses = {}
houses["0|0"] = 2
santas = [Santa.new, Santa.new]

File.open('day3.data').each do |line|
  continue if(line.nil?)
   i = 0
   line.each_char do |c|    
    santas[i%2].deliver(c, houses)
    i += 1
   end
end
puts "Part 2 Num Visited: #{houses.keys.count}"
