#!/usr/bin/env ruby
# Day 11 2016
# See http://adventofcode.com/2016/day/11

puts "Advent of Code 2016 day 1"

#Input State:
#The first floor contains a promethium generator and a promethium-compatible microchip.
#The second floor contains a cobalt generator, a curium generator, a ruthenium generator, and a plutonium generator.
#The third floor contains a cobalt-compatible microchip, a curium-compatible microchip, a ruthenium-compatible microchip, and a plutonium-compatible microchip.
#The fourth floor contains nothing relevant.
ELEMENTS = [:promethium, :cobalt, :curium, :ruthenium, :plutonium]

#Let's swap those to index at 0, and track each tech's position in an array of floor numbers
#     0    1    2    3    4    5    6    7    8    9    10
#F3   .    .    .    .    .    .    .    .    .    .    .
#F2   .    .    .    .    CoM  .    CuM  .    RuM  .    PlM
#F1   .    .    .    CoG  .    CuG  .    RuG  .    PlG  .
#F0   E    PrG  PrM  .    .    .    .    .    .    .    .
INITIAL_STATE = [0,
  0,0,
  1,2,
  1,2,
  1,2,
  1,2]

# search all the moves, reject failure branches, reject longer than min distance paths

# of items on floor
# - take between 0-3 items
# - move up or down 1 floor
# - repeat



class FactoryState
  NUM_FLOORS = 4

  #I know a solution exists with around 13 moves, let's reject anything above 20 moves
  @@minimum_path = 20

  def initialize(moves, factory_state)
    @moves = 0

    #Factory descriptor is an array defining the positions of all tech    
    @state = factory_state
  end

  def solved?()
    #if everything is on the max floor, then we're solved
    @state.each do |i|
      return false if(i != NUM_FLOORS - 1)
    end

    return true
  end

  def valid?()
    #did Elevator move a bad direction?
    return false if(@state[0] < 0 || @state[0] >= NUM_FLOORS)

    #have we searched longer than a known solution?

    #for each microchip, is it's generator on the floor, or any other generators
    #starting at i = 2, check i-1 is on floor, or no even inded value = this floor
    ELEMENTS.length.times do |i|
      chip_index = (i+1)*2
      generator_index = chip_index - 1

      #puts "#{i} #{ELEMENTS[i]} - #{@state[generator_index]}, #{@state[chip_index]}"
      microchip_floor = @state[chip_index]
      generator_floor = @state[generator_index]
      if(microchip_floor != generator_floor)
        #check each generator position
        ELEMENTS.length.times do |j|
          if(@state[j*2+1] == microchip_floor)
            #puts "INVALID #{ELEMENTS[i]} microchip with #{ELEMENTS[j]} generator on #{microchip_floor} floor"
            return false 
          end
        end
      end
    end

    return true
  end  

  def print_layout
    puts "Factory state: #{@state}"
    #puts "Valid?: #{valid?()}, Solved?:#{solved?()}"
  end

  def shortest_solution()
    if(solved?())
      @@minimum_path = @moves
      return @moves
    else
      #No solution found, try all child moves until a shorter value is found

    end
  end

end

init_factory = FactoryState.new(0, INITIAL_STATE)
init_factory.shortest_solution()
