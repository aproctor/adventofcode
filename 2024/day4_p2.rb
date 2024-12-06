#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/4

board = []

DIRECTIONS = {
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
  return '' if x < 0 || x >= board.length || y < 0 || y >= board[0].length

  return board[y][x]
end

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
  backslash_word = [letter_at(x-1, y-1, board), letter_at(x+1, y+1, board)].sort.join('')
  slash_word = [letter_at(x+1, y-1, board),letter_at(x-1, y+1, board)].sort.join('')

  if slash_word == "MS" && backslash_word == "MS"
    total_word_matches += 1
    matched_positions[[x, y]] = true
    matched_positions[[x-1, y-1]] = true
    matched_positions[[x+1, y+1]] = true
    matched_positions[[x+1, y-1]] = true
    matched_positions[[x-1, y+1]] = true
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

