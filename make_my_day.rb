#!/usr/bin/env ruby
# Advent Day generator

def make_my_day(day, year)
  script = File.open("day#{day}.rb",'w')
  script.puts """#!/usr/bin/env ruby
# See http://adventofcode.com/#{year}/day/#{day}

File.open('day#{day}.data').each do |line|
  next if(line.nil?)
  md = line.match(/day ([0-9]+)/)
  if(!md.nil?)
    puts md[1]
  end
end

# class Node
#   attr_accessor :val

#   def initialize(val)
#     @val = val
#   end
# end
"""
  script.close

  data = File.open("day#{day}.data",'w')
  data.puts "day #{day}"
  data.close

  system("chmod a+x day#{day}.rb")
end

def make_my_year(year)
  system "mkdir #{year}"
  system "cd #{year}"

  25.times do |i|
    make_my_day(i+1,year)
  end

  system "cd .."
end

make_my_year('2025')


