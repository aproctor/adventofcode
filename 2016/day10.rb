#!/usr/bin/env ruby
# Day 10 2016
# See http://adventofcode.com/2016/day/10

puts "Advent of Code 2016 day 10"


#Part 1 - 
class Factory
  attr_reader :bots

  def initialize()
    @bots = {}    
    @outputs = []
  end

  def find_bot(bot_num)
    @bots[bot_num] = Bot.new(self, bot_num) if(!@bots.key?(bot_num))

    return @bots[bot_num]
  end

  def take_output(index, val)
    outputs[index] = val
  end
end

class Bot  
  MAX_CHIPS = 2

  def initialize(parent, num)
    @chips = []
    @instruction = nil
    @factory = parent
    @number = num
  end

  def instruction=(val)
    @instruction = val
    try_instruction()
  end

  def try_instruction()
    if(!@instruction.nil? && @chips.length == MAX_CHIPS)      
      puts "comparing #{@chips}"
    end
  end

  def take_chip(chip)
    @chips << chip
    @chips = @chips.sort

    try_instruction()    
  end
end

factory = Factory.new
answer = 0
File.open('day10.data').each do |line|
  continue if(line.nil?)

  #puts "#{line}"

  assignment = /value (\d+) goes to bot (\d+)/.match(line)
  if(!assignment.nil?)    
    bot_num = assignment[2].to_i    
    bot = factory.find_bot(bot_num)    
    bot.take_chip(assignment[1].to_i)
  end

  delivery = /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/.match(line)
  if(!delivery.nil?)    
    source_bot = factory.find_bot(delivery[1].to_i)
    source_bot.instruction = [delivery[2].to_sym,delivery[3].to_i,delivery[4].to_sym,delivery[5].to_i]
  end
  

end

puts "part 1 - #{answer}"

