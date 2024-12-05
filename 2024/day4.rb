#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/4

board = []

DIRECTIONS = {
  'U' => [-1, 0],
  'D' => [1, 0],
  'L' => [0, -1],
  'R' => [0, 1],
  'UR' => [-1, 1],
  'UL' => [-1, -1],
  'DR' => [1, 1],
  'DL' => [1, -1]
}

File.open('day4.data').each do |line|
  next if(line.nil?)

  board << line.strip.split('')
end


def letter_at(x, y, board)
  return nil if x < 0 || x >= board.length || y < 0 || y >= board[0].length

  return board[x][y]
end

# def connects_to_letter?(x, y, l, direction, board)
#   return false if x < 0 || x >= board.length || y < 0 || y >= board[0].length || board[x][y] == l
#
#   return letter_at(x + DIRECTIONS[direction][0], y + DIRECTIONS[direction][1], board) == l
# end

def print_board(board)
  for i in 0..board.length-1
    buffer = ''
    for j in 0..board[i].length-1
      if board[i][j] != '.'
        buffer += "\e[32m#{board[i][j]}\e[0m"
      else
        buffer += board[i][j]
      end
    end
    puts buffer
  end
end

puts "Part 1"
x_positions = []
for i in 0..board.length-1
  for j in 0..board[i].length-1
    if board[i][j] == 'X'
      x_positions << [i, j]
    end
  end
end
#puts x_positions.inspect

total_word_matches = 0
matched_positions = {}
x_positions.each do |x, y|
  DIRECTIONS.each do |k, v|
    #Expected values for XMAS
    expected_values = [
      ["M", x+v[0], y+v[1]],
      ["A", x+v[0]*2, y+v[1]*2],
      ["S", x+v[0]*3, y+v[1]*3]
    ]
    found_match = true
    expected_values.each do |l, ex, ey|
      if letter_at(ex, ey, board) == l
       # puts "Found #{l} at #{ex}, #{ey}"
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
    if matched_positions[[i, j]].nil?
      board[i][j] = '.'
    end
  end
end
print_board(board)
puts "Total matches: #{total_word_matches}"

