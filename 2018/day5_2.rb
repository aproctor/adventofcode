#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/5

require "set"

MAX_ITERATIONS = 1000000 #NASA required saftey on while loops

input = nil
File.open('day5.data').each do |line|
  next if(line.nil?)
  input = line
end

def reacting_chars(c1,c2)
  return !c2.nil? && c1.downcase == c2.downcase && c1 != c2
end

class Node
  attr_accessor :char, :prev, :next

  def initialize(char, prev)
    @char = char
    @prev = prev
    @prev.next = self unless @prev.nil?
  end

  def react!
    if !@next.nil? && reacting_chars(@char, @next.char)
      @next.destruct
      self.destruct
      return true
    elsif !@prev.nil? && reacting_chars(@char, @prev.char)
      @prev.destruct
      self.destruct
      return true
    end

    return false
  end

  def destruct
    # puts "Goodbye: #{@char}"
    @prev.next = @next
    @next.prev = @prev
  end
end

def list_reduce(value, ignore_char)
  root = Node.new("^", nil)
  last_node = root
  value.each_char do |c|
    if(c.strip.length > 0 && c.downcase != ignore_char)
      new_node = Node.new(c, last_node)
      last_node = new_node
    end
  end
  last_node.next = Node.new("$", last_node)

  #iterate over list until no conflicts
  n = root
  loop do
    n.react!

    n = n.next
    break if n == nil
  end

  #count length
  n = root
  count = 0
  loop do
    # puts n.char
    n = n.next
    count += 1
    break if n == nil
  end

  count-2
end

# input = "dabAcCaCBAcCcaDA"
unique_chars = Set.new
input.each_char do |c|
  if(c.strip.length > 0)
    unique_chars << c.downcase
  end
end

shortest = input.length
ignore_char = nil
unique_chars.each do |c|
  length = list_reduce(input, c)
  # puts "Ignoring #{c} = #{length}"
  if(length < shortest)
    shortest = length
    ignore_char = c
  end
end
puts "Shortest length: #{shortest}, Ignoring #{ignore_char}"
