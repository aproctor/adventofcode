#!/usr/bin/env ruby
# Day 1 2015
# See http://adventofcode.com/2015/day/7

puts "Advent of Code 2015 day 7"


# Input example
#
# 123 -> x
# 456 -> y
# x AND y -> d
# x OR y -> e
# x LSHIFT 2 -> f
# y RSHIFT 2 -> g
# NOT x -> h
# NOT y -> i

class Node
  attr_accessor :output_key, :input
  @output_val = nil
  @@node_map = {}

  def initialize(input, out)
    @output_key = out
    @input = input

    @@node_map[out] = self
  end

  def self.find(out)
    (@@node_map.key?(out)) ? @@node_map[out] : nil
  end

  def self.value_of(val)
    return @@node_map[val].output if(@@node_map.key?(val))

    #Not a known node, assume an integer.  Hacky but whatever, will be 0 for unknowns
    val.to_i
  end

  def self.not_16bit(val)
    #Ruby doens't have 16-bit integers so we can't just use the ~ operator
    bit_string = val.to_s(2).rjust(16,"0")
    return_value = 0

    #puts "Value: #{val}"
    #puts "Bits: #{bit_string}"

    # Flipping the bits
    bit_string.each_char.with_index do |c, i|
      if c == '0'
        return_value += 2 ** (15 - i)
      end
    end

    #puts "Rval: #{return_value.to_s(2).rjust(16,'0')}"

    return_value
  end

  def self.print_nodes
    @@node_map.each do |k,v|
      puts "#{k}: #{v.input}"
    end
  end

  def self.print_values
    @@node_map.each do |k,v|
      puts "#{k}: #{v.output}"
    end
  end


  def output
    #memoize the value to avoid expensive reruns on wires
    return @output_val unless @output_val.nil?

    #puts input.inspect

    if @input.length == 1
      # 123
      # x
      @output_val = Node::value_of(@input[0])
    elsif @input.length == 2
      # NOT x
      @output_val = Node::not_16bit(Node::value_of(@input[1]))
    elsif @input.length == 3
      # x AND y
      # x OR y
      # x LSHIFT 2
      # y RSHIFT 2
      if(@input[1] == "AND")
        @output_val = Node::value_of(@input[0]) & Node::value_of(@input[2])
      elsif(@input[1] == "OR")
        @output_val = Node::value_of(@input[0]) | Node::value_of(@input[2])
      elsif(@input[1] == "LSHIFT")
        @output_val = Node::value_of(@input[0]) << @input[2].to_i
      elsif(@input[1] == "RSHIFT")
        @output_val = Node::value_of(@input[0]) >> @input[2].to_i
      end    
    end 

    @output_val
  end
end

File.open('day7.data').each do |line|
  next if(line.nil?)

  #overly complex regex for validation
  md = line.strip.match(/^((NOT )?([a-z]*[0-9]*)|([a-z]*[01]*) AND ([a-z]*[01]*)|([a-z]*[01]*) OR ([a-z]*[01]*)|([a-z]+) ([LR]SHIFT) ([0-9]+)) -> ([a-z]+)$/)
  valid = true
  if(md.nil?)
    puts "no - #{line}"
    valid = false
  end  
  exit -1 if !valid

  command = line.strip.split(" -> ")
  output = command[1]
  input = command[0].split(" ")
  Node.new(input, output)
end

# Node::print_nodes
# Node::print_values
# puts Node.find("x").output

a_node = Node.find('a')
p1_value = a_node.output
puts "Part 1: #{p1_value}"
