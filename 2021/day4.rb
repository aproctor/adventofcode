#!/usr/bin/env ruby
# See http://adventofcode.com/2021/day/4

BOARD_SIZE = 5

class BingoCard
  attr_accessor :rows

  def initialize()
    @rows = []
    @hits = {}
    @won = false
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

  def active?
  	@won == false
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

  		if hit_count == BOARD_SIZE
  			@won = true
  		end
  	end

  	# check all cols, even if we know we won on a row, BOARD_SIZE is small whatever
  	BOARD_SIZE.times do |i|
  		hit_count = 0
  		BOARD_SIZE.times do |j|
  			k = "#{j},#{i}"
  			hit_count += 1 if @hits.key?(k)
  		end

  		if hit_count == BOARD_SIZE
  			@won = true
  		end
  	end

  	@won
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


def play_bingo(cards, calls)
	winners = []
	calls.each do |n|
		# puts "Calling #{n}"
		cards.each_with_index do |card, i|
			next unless card.active?

			if card.daub(n)
				# puts "Hit on card #{i}"
				if card.bingo?
					puts "Bingo on card #{i}"
					puts "Score #{card.score(n)}"
					winners << i
				end
			end
		end
	end

	# puts "Winners #{winners.inspect}"
	puts "Part 2: Last winner = #{winners[-1]}"
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

play_bingo(bingo_cards, calls)


