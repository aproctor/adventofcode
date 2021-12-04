#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/4

BOARD_SIZE = 5

class BingoCard
  attr_accessor :rows

  def initialize()
    @rows = []
    @hits = {}
  end

  def add_row(row_string)
  	md = row_string.match(/(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/)
  	if md.nil?
  		raise "OH NO BAD MATCH <#{row_string}>"  	
  	end
  	@rows << md[1,BOARD_SIZE].map { |str| str.to_i }
  end

  # returns whether a hit was registered
  def daub(num)  	
  	@rows.each_with_index do |r, i|
  		r.each_with_index do |n, j|
  			if n == num
  				@hits["#{i},#{j}"] = 1
  				return true
  			end
  		end
  	end

  	false
  end

  def valid?
  	@rows.length == BOARD_SIZE
  end

  def bingo?
  	# check all rows
  	BOARD_SIZE.times do |i|
  		hit_count = 0
  		BOARD_SIZE.times do |j|
  			k = "#{i},#{j}"
  			hit_count += 1 if @hits.key?(k)
  		end

  		return true if hit_count == BOARD_SIZE
  	end

  	# check all cols
  	BOARD_SIZE.times do |i|
  		hit_count = 0
  		BOARD_SIZE.times do |j|
  			k = "#{j},#{i}"
  			hit_count += 1 if @hits.key?(k)
  		end

  		return true if hit_count == BOARD_SIZE
  	end

  	false
  end

  def score(last_call)
  	unmarked_count = 0
  	rows.each_with_index do |r, i|
  		r.each_with_index do |n, j|
  			k = "#{i},#{j}"
  			unmarked_count += n unless @hits.key?(k)
  		end
  	end

  	unmarked_count * last_call
  end
end


def p1_play_bingo(cards, calls)
	calls.each do |n|
		# puts "Calling #{n}"
		cards.each_with_index do |card, i|
			if card.daub(n)
				# puts "Hit on card #{i}"
				if card.bingo?
					puts "Bingo on card #{i}"
					return card.score(n)
				end
			end
		end
	end

	puts "no winners"
	0
end



line_count = 0
calls = nil
bingo_cards = []
cur_card = nil
File.open('day4.data').each.with_index do |line, line_count|
  if line_count == 0
  	calls = line.split(',').map { |str| str.to_i }
  	next
  end

  line.strip!

  # start a new card on blank lines
  if line.length == 0
  	bingo_cards << cur_card unless cur_card.nil?

  	cur_card = BingoCard.new
  else
  	cur_card.add_row(line)
  end 
end
bingo_cards << cur_card if cur_card.valid?

puts "Part 1:"
puts "Score #{p1_play_bingo(bingo_cards, calls)}"


