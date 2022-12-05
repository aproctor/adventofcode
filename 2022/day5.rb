#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/5

num_cols = 0
columns = {}
instructions = []

def print_columns(cols)
  width = cols.keys.length
  max_height = 0
  cols.each do |k,v|
    max_height = v.length if v.length > max_height
  end

  max_height.times do |r|
    y = max_height - r
    
    buffer = []
    width.times do |c|
      column = cols[c+1]
      offset = max_height - column.length
      if offset > r
        buffer << "   "
      else
        buffer << "[#{column[r-offset]}]"
      end
    end

    puts buffer.join(" ")
  end
end

File.open('day5.data').each.with_index do |line, i|
  next if(line.nil?)

  # Initialize columns based on length of first line
  if i == 0
    # This is just a quirk of the input, could wait for container line later for more robute solution
    num_cols = line.length / 4

    # Initialize all columns to empty
    num_cols.times do |c|
      columns[c+1] = []
    end
  end
  
  # Container lines
  md = line.match(/\[/)
  if(!md.nil?)
    #container line
    num_cols.times do |x|
      targetChar = line[x*4 + 1]
      if targetChar != " "
        columns[x+1] << targetChar
      end
    end    
  end 

  # Instruction lines
  md = line.match(/move (\d+) from (\d+) to (\d+)/)
  if(!md.nil?)
    instructions << [md[1].to_i,md[2].to_i, md[3].to_i]
  end
end

puts "Initial layout:"
print_columns(columns)

instructions.each.with_index do |ins, i|
  columns[ins[1]].shift(ins[0]).each do |c|
    columns[ins[2]].unshift c
  end

  puts "After Step #{i+1}:"
  print_columns(columns)
end

# Part 1 - top of each stack
p1_result = []
num_cols.times do |i|
  p1_result << columns[i+1][0]
end
puts "Part 1: #{p1_result.join('')}"

