#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/9

#10 players; last marble is worth 1618 points: high score is 8317
#13 players; last marble is worth 7999 points: high score is 146373
#17 players; last marble is worth 1104 points: high score is 2764
#21 players; last marble is worth 6111 points: high score is 54718
#30 players; last marble is worth 5807 points: high score is 37305

NEXT_MARBLE_OFFSET = 7

class Marble
	attr_accessor :val, :next, :prev

	def initialize(val)
		@val = val
		@next = nil
		@prev = nil
	end

	def insert(other)
		other.next = @next
		other.prev = self

		@next.prev = other
		@next = other		
	end

	def remove
		@next.prev = @prev
		@prev.next = @next
	end
end

class MarbleCircle
	def initialize(player_count, marble_count)
		@marble_count = marble_count
		@player_count = player_count

		@marbles = []

		marble_count.times do |i|
			m = Marble.new(i)
			if(i == 0)
				#Initialize first marble as cur_marble
				@cur_marble = m
				m.next = m
				m.prev = m
				@root = m
			else
				@marbles << m
			end
		end	

		@player_scores = []
		player_count.times do |i|
			@player_scores << 0
		end
	end

	def print_high_score
		player = 0

		i = 0

		while @marbles.count > 0 do
			m = @marbles.shift

			# if the marble that is about to be placed has a number which is a multiple of 23
			if m.val % 23 == 0
				#First, the current player keeps the marble they would have placed adding it to their score.
				@player_scores[player] += m.val
				
				#In addition, the marble 7 marbles counter-clockwise from the current marble is removed from the circle and also added to the current player's score.
				NEXT_MARBLE_OFFSET.times do 
					@cur_marble = @cur_marble.prev
				end
				m2 = @cur_marble
				@player_scores[player] += m2.val

				#The marble located immediately clockwise of the marble that was removed becomes the new current marble.
				@cur_marble = m2.next	
				m2.remove				
			else
				#insert new marble				
				@cur_marble = @cur_marble.next
				@cur_marble.insert(m)
				@cur_marble = m	
			end			

			#puts "[#{player+1}]  #{debug_marble_str(i+2)}"

			#next player
			player = (player + 1) % @player_count
			i += 1
		end

		#puts "#{@player_scores.inspect}"
		high_score = @player_scores.max
		
		puts "#{@player_count} players; last marble is worth #{@marble_count} points: high score is #{high_score}"
	end

	def debug_marble_str(length)
		output = []
		m = @root
		length.times do
			#puts "ok"
			if m.val == @cur_marble.val
				output << "(#{m.val})"
			else
				output << m.val.to_s
			end

			m = m.next
			#break if m.val != @root.val
		end
		
		output.join("  ")
	end
end

inputs = [
	"9 players; last marble is worth 25 points",
	"10 players; last marble is worth 1618 points",
	"13 players; last marble is worth 7999 points",
	"17 players; last marble is worth 1104 points",
	"21 players; last marble is worth 6111 points",
	"30 players; last marble is worth 5807 points",
	"424 players; last marble is worth 71482 points"
]

inputs.each do |input|
  md = input.match(/([0-9]+) players; last marble is worth ([0-9]+) points/)	
  if(!md.nil?)
  	circle = MarbleCircle.new(md[1].to_i,md[2].to_i)
  	circle.print_high_score
  end
end