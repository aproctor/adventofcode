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

#given an array of at least size 2, find all unique combinations
def unique_pairs(array)
  valid_pairs = {}
  array.each do |i|
    array.each do |j|
      if(i != j)
        tuple = [i,j].sort
        valid_pairs["#{tuple.join(',')}"] = tuple
      end
    end
  end

  return valid_pairs.values
end

class FactoryState
  NUM_FLOORS = 4

  def initialize(factory_state)
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

  def key_string
    return @state.join(',')
  end

  def print_layout
    puts "Factory state: #{@state}"
    #puts "Valid?: #{valid?()}, Solved?:#{solved?()}"
  end

  #BFS search for possible valid moves after this one
  def possible_moves
    valid_moves = []

    #Elevator can be up or down
    2.times do |e|
      direction = (e == 1) ? -1 : 1
      target_floor = @state[0] + direction      

      #only evaluate values with valid target floors to save memory
      #(even though it's bounds protected in valid?()
      if(target_floor >= 0 && target_floor < NUM_FLOORS)
        #create a reference array updating the position of the elevator
        elevator_state = Array.new(@state)
        elevator_state[0] = target_floor

        #permutate through possible options to take in the current floor
        tech_on_floor = []
        (1..@state.length).each do |i|
          tech_on_floor << i if(@state[i] == @state[0])
        end

        if(tech_on_floor.length >= 2)
          #choose every combination of 2 items in the tech
          unique_pairs(tech_on_floor).each do |pair|
            s = Array.new(elevator_state)
            s[pair[0]] = target_floor
            s[pair[1]] = target_floor
            fs = FactoryState.new(s)
            valid_moves << fs if(fs.valid?)
          end
        end
        if(tech_on_floor.length >= 1)
          #choose every combination of 1 item in the tech
          tech_on_floor.each do |i|
            s = Array.new(elevator_state)
            s[i] = target_floor
            fs = FactoryState.new(s)    

            valid_moves << fs if(fs.valid?)
          end
        end
      end

    end

    return valid_moves
  end
end

#I know a solution exists with around 13 moves, let's reject anything above 20 moves
MAXIMUM_MOVES = 200
moves = 0
solved = false

init_factory = FactoryState.new(INITIAL_STATE)
possible_states = [init_factory]

checked_states = {}
MAXIMUM_MOVES.times do |moves|  
  break if(possible_states.empty? || solved)
  
  possible_states.each do |fs|
    #fs.print_layout()
    
    if(fs.solved?)      
      puts "Solved after #{moves} moves"
      fs.print_layout
      solved = true
      break      
    elsif(!fs.valid?)
      puts "WTF invalid GTFO"
      break
    end

    checked_states[fs.key_string] = true
  end

  #no solution found
  new_states = {}
  possible_states.each do |fs|
    fs.possible_moves.each do |ns|  
      if(!checked_states.key?(ns.key_string))    
        new_states[ns.key_string] = ns
      end
    end
  end
  possible_states = new_states.values

  puts "#{moves} - #{possible_states.size}\n"
end

if(!solved)  
  puts "unable to solve after #{MAXIMUM_MOVES} moves, increase maximum"
end