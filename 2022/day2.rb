#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/2

points = {
  "A" => 1,
  "B" => 2,
  "C" => 3
}

p1_map = {
  "X" => "A",
  "Y" => "B",
  "Z" => "C"
}

p2_map = {
  "X" => :lose,
  "Y" => :tie,
  "Z" => :win
}

rounds = []

WIN_SCORE = 6
LOSS_SCORE = 0
TIE_SCORE = 3

def win_score(move, opp)
  return TIE_SCORE if move == opp 
  
  # It's too late to think of a quick trick for this, let's see what part 2 is first
  if move == "A"
    return (opp == "B") ? LOSS_SCORE : WIN_SCORE
  elsif move == "B"
    return (opp == "C") ? LOSS_SCORE : WIN_SCORE
  elsif move == "C"
    return (opp == "A") ? LOSS_SCORE : WIN_SCORE
  end
end

def player_move_for_result(opp, result)
  return opp if result == :tie

  if opp == "A"
    return (result == :win) ? "B" : "C"
  elsif opp == "B"
    return (result == :win) ? "C" : "A"
  elsif opp == "C"
    return (result == :win) ? "A" : "B"
  end
end

File.open('day2.data').each do |line|
  next if(line.nil?)
  md = line.split(' ')
  if(!md.nil? && md.length == 2)
    rounds << md
  end
end

# P1
# total_score = 0
# rounds.each do |r|
#   opp_move = r[0]
  
#   player_move = p1_map[r[1]]
#   score = points[player_move] + win_score(player_move, opp_move)
  
#   total_score += score

#   puts "#{opp_move} vs #{player_move} = #{score}"
# end
# puts "Total Score: #{total_score}"

# P2 
total_score = 0
rounds.each do |r|
  opp_move = r[0]
  result = p2_map[r[1]]
  player_move = player_move_for_result(opp_move, result)
  score = points[player_move] + win_score(player_move, opp_move)
  
  total_score += score

  puts "#{opp_move} vs #{player_move} = #{score}"
end
puts "Total Score: #{total_score}"