#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/8


class Display
  attr_accessor :slot, :sequences

  def initialize(slot, sequences)
  	@slot = slot
    @sequences = sequences
  end

  def add_readout(readout)
  	@sequences << readout
  end
end


readouts = []
displays = []
digit = 0
File.open('day8.data').each do |line|
  next if(line.nil?)
  parts = line.split(' | ')
  displays << Display.new(digit, parts[0].split(' '))

  readout = parts[1].split(' ')  
  readouts << readout

  digit += 1
end

# TODO maybe add in etra info from the readouts to the digits to better decrypt?

puts "Part 1"
one_four_seven_eight_count = 0
readouts.each do |r|
	r.each do |digit_signals|
		l = digit_signals.length

		if l == 2 || l == 4 || l == 3 || l == 7
			one_four_seven_eight_count += 1
		end
	end
end
puts "Total 1, 4, 7 or 8 characters in readouts: #{one_four_seven_eight_count}"

