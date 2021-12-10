#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/8


#     0:      1:      2:      3:      4:
#    aaaa    ....    aaaa    aaaa    ....
#   b    c  .    c  .    c  .    c  b    c
#   b    c  .    c  .    c  .    c  b    c
#    ....    ....    dddd    dddd    dddd
#   e    f  .    f  e    .  .    f  .    f
#   e    f  .    f  e    .  .    f  .    f
#    gggg    ....    gggg    gggg    ....
#
#     5:      6:      7:      8:      9:
#    aaaa    aaaa    aaaa    aaaa    aaaa
#   b    .  b    .  .    c  b    c  b    c
#   b    .  b    .  .    c  b    c  b    c
#    dddd    dddd    ....    dddd    dddd
#   .    f  e    f  .    f  e    f  .    f
#   .    f  e    f  .    f  e    f  .    f
#    gggg    gggg    ....    gggg    gggg

class Display
  attr_accessor :slot, :sequences, :mappings, :readout, :cypher

  def initialize(slot, sequences, readout)
  	@slot = slot
    @sequences = []
    sequences.each do |s|
    	@sequences << s.chars.sort.join
    end
    @readout = []
    readout.each do |r|
    	@readout << r.chars.sort.join
    end
    @mappings = {}
    @cypher = {}
    @decrypted_val = nil
  end

  def decrypt		
		fives = []
		sixes = []

		#I know ruby doesn't need these declared outside the scope, but i still would like to for clarity
		one_seq = nil
		seven_seq = nil
		four_seq = nil

		@sequences.each do |s|			
			if s.length == 2
				# 1 = "cf"      		# length: 2
				@mappings[s] = 1
				one_seq = s
			elsif s.length == 3
				# 7 = "acf"     		# length: 3
				@mappings[s] = 7
				seven_seq = s
			elsif s.length == 4
				# 4 = "bcdf"    		# length: 4
				@mappings[s] = 4
				four_seq = s
			elsif s.length == 7
				# 8 = "abcdefg" 		# length: 7
				@mappings[s] = 8
			elsif s.length == 5
				# 2 = "acdeg"   		# length: 5
				# 3 = "acdfg"   		# length: 5
				# 5 = "abdfg"   		# length: 5
				fives << s
			elsif s.length == 6
				# 6 = "abdefg"  		# length: 6
				# 0 = "abcefg"  		# length: 6
				# 9 = "abcdfg"  		# length: 6
				sixes << s
			else
				raise "Unexpected sequence length for <#{s}>"
			end	
		end

		# puts "Mappings so far: #{@mappings.inspect}.  Ready? #{self.ready?}"
		# puts "Cypher: #{@cypher}"

		###
		# Expand cypher from known mappings
		##

		# 1 = cf
		# 7 = 1 + a
		seven_seq.each_char do |c|
			if !one_seq.include?(c)
				@cypher["a"] = c
			end
		end

		# 4 = 1 + bd
		bd_string = ""
		four_seq.each_char do |c|
			if !one_seq.include?(c)
				bd_string << c
			end
		end

		# fives: 2,3,5
		# all contain a,d,g
		# 2,3 contain c
		# only 5 contains b
		# only 2 contains e
		# 3,5 contains f
		five_counts = {}
		fives.each do |f|
			f.each_char do |c|
				if five_counts.key?(c)
					five_counts[c] += 1
				else
					five_counts[c] = 1
				end
			end
		end
		adg_string = ""
		five_counts.each do |k, v|
			if v == 1
				# either b, or e
				if bd_string.include?(k)
					# this is b
					@cypher["b"] = k
					@cypher["d"] = bd_string.sub(k, "")
				else
					# this is e
					@cypher["e"] = k
				end
			end
		end

		# we know 5 since finding "b"
		# we know 2 since finding "e"
		fives.each do |f|
			if f.include?(@cypher["b"])
				@mappings[f] = 5
			elsif f.include?(@cypher["e"])
				@mappings[f] = 2
			else
				@mappings[f] = 3
			end
		end

		# puts "Fives solved."
		# puts "Cypher: #{@cypher}"
		# puts "Mappings: #{@mappings}"


		# sixes: 6, 0, 9
		# "abdefg", "abcefg", "abcdfg" (respectively)
		# all contain a,b,f,g
		# 0,6 contain e
		# 0,9 contain c
		# 6,9 contain d
		six_counts = {}
		sixes.each do |s|
			s.each_char do |c|
				if six_counts.key?(c)
					six_counts[c] += 1
				else
					six_counts[c] = 1
				end
			end
		end

		six_counts.each do |k,v|
			if v == 3
				# 0,9 contain c
				# 1 = cf
				if one_seq.include?(k)
					# from the one_seq we shoud be able to find c
					@cypher["c"] = k
					@cypher["f"] = one_seq.sub(k, "")
				end
			end
		end

		# now we know c and previously d, we can crack the sixes
		sixes.each do |s|
			if s.include?(@cypher["c"])
				if s.include?(@cypher["d"])
					@mappings[s] = 9
				else
					@mappings[s] = 0
				end
			else
				@mappings[s] = 6
			end
		end

		# puts "Sixes cracked"
		# puts "Mappings: #{@mappings}"
		# puts "Cypher: #{@cypher}"

		digits = []
		@readout.each do |r|
			digits << @mappings[r]
		end

		@decrypted_val = digits.join('').to_i

		puts "#{@readout} = #{@decrypted_val}"

		@decrypted_val
  end

  # TODO DELETE?
  # Helper function to look up inverse mappings for decryption
  def demap(num)
  	@mappings.each do |k,v|
  		return k if v == num
  	end

  	nil
  end

  def ready?
  	@readout.each do |r|
  		return false unless @mappings.key?(r)
  	end

  	true
  end

  def value
  	if @decrypted_val.nil?
  		#attempt decryption again
  		self.decrypt
  	end

  	@decrypted_val
  end

  def print
  	puts "Slot #{@slot} #{@readout} with #{@sequences.length} sequences:"
  	puts "\t#{@sequences.join(', ')}"
  end
end


readouts = []
displays = []
digit = 0
File.open('day8.data').each do |line|
  next if(line.nil?)
  parts = line.split(' | ')  

  readout = parts[1].split(' ')  
  readouts << readout

  displays << Display.new(digit, parts[0].split(' '), readout)

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


puts "\nPart 2"
total_sum = 0
displays.each do |d|
	# d.print
	total_sum += d.decrypt
end
puts "Total sum: #{total_sum}"
