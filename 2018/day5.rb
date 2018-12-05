#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/5

MAX_ITERATIONS = 1000000 #NASA required saftey on while loops

input = nil
File.open('day5.data').each do |line|
  next if(line.nil?)
  input = line
end

def reacting_chars(c1,c2)
  return !c2.nil? && c1.downcase == c2.downcase && c1 != c2
end

def reduce(value)

  MAX_ITERATIONS.times do |depth|
    puts depth if depth % 1000 == 0

    # puts "v: #{value}"

    reaction = false
    prev_char = nil

    if depth > MAX_ITERATIONS
      puts "We dug to deep! panic!"
      return nil
    end

    buffer = []
    value.each_char.with_index do |c,i|
      if reacting_chars(c, prev_char)
        reaction = true
        #splice out these chars
        buffer << value[0..i-2] if(i > 2)
        buffer << value[i+1..-1] if(i < value.length - 1)
        break
      end
      prev_char = c
    end
    if reaction
      # start again
      value = buffer.join('')
    else
      puts "#{value}"
      puts "min value found: #{value.length}"

      return value
    end
  end

  puts "Nothing found after #{depth} iterations"
  return nil
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

def list_reduce(value)
  root = Node.new("^", nil)
  last_node = root
  value.each_char do |c|
    new_node = Node.new(c, last_node)
    last_node = new_node
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
  puts "count: #{count-2}"
end

# input = "dabAcCaCBAcCcaDA"
# reduce(input)
list_reduce(input)
