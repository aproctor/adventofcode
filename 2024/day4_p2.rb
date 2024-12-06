#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/4

board = []

DIRECTIONS = {
  'UR' => [-1, 1],
  'UL' => [-1, -1],
  'DR' => [1, 1],
  'DL' => [1, -1]
}

# A valid pattern is an A with the word MAS spelled in both diagonals
# this array shows the valid patterns for letters in the positions [-1, -1], [+1, -1], [+1, +1], [+1, -1] (Top left, Top Right, Bottom Right, Bottom Left)
VALID_PATTERNS = [
  ['M','S','S','M'], # two M's on the left, two S's on the right
  ['S','M','M','S'], # two S's on the left, two M's on the right
  ['M','M','S','S'], # two M's on the top, two S's on the bottom
  ['S','S','M','M'] # two S's on the top, two M's on the bottom
]

File.open('day4.data').each do |line|
  next if(line.nil?)

  board << line.strip.split('')
end


def letter_at(x, y, board)
  return nil if x < 0 || x >= board.length || y < 0 || y >= board[0].length

  return board[y][x]
end

def print_board(board)
  for i in 0..board.length-1
    buffer = ''
    for j in 0..board[i].length-1
      if board[i][j] == 'A'
        buffer += "\e[32m#{board[i][j]}\e[0m"
      else
        buffer += board[i][j]
      end
    end
    puts buffer
  end
end

puts "Part 2"
a_positions = []
for i in 0..board.length-1
  for j in 0..board[i].length-1
    if board[i][j] == 'A'
      a_positions << [j, i]
    end
  end
end
# puts a_positions.inspect
# print_board(board)

total_word_matches = 0
matched_positions = {}
a_positions.each do |x, y|
  VALID_PATTERNS.each do |v|
    expected_values = [
      [v[0], x-1, y-1],
      [v[1], x+1, y-1],
      [v[2], x+1, y+1],
      [v[3], x-1, y-1]
    ]
    found_match = true
    expected_values.each do |l, ex, ey|
      if letter_at(ex, ey, board) == l
        #puts "Found #{l} at #{ex}, #{ey}"
      else
        found_match = false
        #puts "No match for #{l} at #{ex}, #{ey}"
        break
      end
    end
    if found_match
      matched_positions[[x, y]] = 1
      expected_values.each do |l, ex, ey|
        matched_positions[[ex, ey]] = 1
      end

      total_word_matches += 1
    end
  end
end

# Clear board of unmatched positions
for i in 0..board.length-1
  for j in 0..board[i].length-1
    if matched_positions[[j, i]].nil?
      board[i][j] = '.'
    end
  end
end
print_board(board)
puts "Total matches: #{total_word_matches}"

