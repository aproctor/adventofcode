#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/11

NUM_ROUNDS = 20

OPERATORS = {
  "*" => :mul,
  "%" => :div,
  "+" => :add,
  "-" => :sub
}

OP_LANG = {
  :mul => "is multiplied by",
  :div => "is divided by",
  :add => "increases by",
  :sub => "decreases by"
}

class Monkey
  attr_accessor :index, :items, :operator, :curry, :test_val, :yes_target, :no_target, :total

  def initialize(i)
    @index = i
    @ref_self = false
    @verbose = false
    @total = 0
  end

  def operation(op, value)
    @operator = OPERATORS[op]
    if(value == "old")
      @ref_self = true
    else
      @curry = value.to_i
    end
  end

  def turn
    throws = []
    puts "Monkey #{@index}:" if @verbose

    @items.each do |ival|
      puts "  Monkey inspects an item with a worry level of #{ival}." if @verbose

      op_input = @ref_self ? ival : @curry
      trans_input = @ref_self ? "itself" : op_input  # just for translation
      result = inspect_value(ival, op_input)

      @total += 1

      puts "    Worry level #{OP_LANG[@operator]} #{trans_input} to #{result}." if @verbose

      result = (result / 3).floor
      puts "    Monkey gets bored with item. Worry level is divided by 3 to #{result}." if @verbose

      t = nil
      if result % @test_val == 0
        t = [result, @yes_target]
        puts "    Current worry level is divisible by #{@test_val}." if @verbose
      else
        t = [result, @no_target]
        puts "    Current worry level is not divisible by #{@test_val}." if @verbose
      end

      puts "    Item with worry level #{t[0]} is thrown to monkey #{t[1]}." if @verbose
      throws << t
    end

    # all items are gone
    @items = []

    # return thrown items to be caught by after round
    throws
  end

  def to_s
    if @verbose
      "Monkey #{index} [#{@operator}, #{@curry}, #{@ref_self}] (mod #{test_val} ? #{yes_target} : #{no_target}), #{items}"
    else
      "Monkey #{index}: #{items.join(', ')}"
    end
  end

  private

  def inspect_value(val1, val2)
    # puts "#{val1} #{@operator} #{val2}"
    return val1 * val2 if @operator == :mul
    return val1 / val2 if @operator == :div
    return val1 + val2 if @operator == :add
    return val1 - val2 if @operator == :sub
  end
end


###
# Make Monkeys
##
monkeys = {}
cur_monkey = nil
File.open('day11.data').each do |line|
  next if(line.nil?)

  #puts "line: #{line.strip}"
  md = line.match(/Monkey ([0-9]+):/)
  if(!md.nil?)
    # New Monkey
    index = md[1].to_i
    cur_monkey = Monkey.new(index)
    monkeys[index] = cur_monkey
    next
  end

  md = line.match(/Starting items: ([0-9, ]+)/)
  if(!md.nil?)
    # Set starting items
    cur_monkey.items = md[1].split(", ").map(&:to_i).to_a
    next
  end

  md = line.match(/Operation: new = old ([\+\-\*]) ([0-9]+|old)/)
  if(!md.nil?)
    cur_monkey.operation(md[1], md[2])
    next
  end

  md = line.match(/Test: divisible by ([0-9]+)/)
  if(!md.nil?)
    cur_monkey.test_val = md[1].to_i
    next
  end

  md = line.match(/If true: throw to monkey ([0-9]+)/)
  if(!md.nil?)
    cur_monkey.yes_target = md[1].to_i
    next
  end

  md = line.match(/If false: throw to monkey ([0-9]+)/)
  if(!md.nil?)
    cur_monkey.no_target = md[1].to_i
    next
  end

  if(line.strip.empty?)
    next
  end

  raise "unknown line! \"#{line.strip}\""
end

puts "Initial monkeys"
puts monkeys.values

NUM_ROUNDS.times do |r|

  monkeys.values.each do |m|
    throws = m.turn

      # Catch thrown items
    throws.each do |t|
      monkeys[t[1]].items << t[0]
    end
  end



  puts "After round #{r+1}, the monkey sare holding items with these worry levels:"
  puts monkeys.values
end

totals = []
monkeys.values.each do|m|
  puts "Monkey #{m.index} inspected items #{m.total} times"
  totals << m.total
end
totals.sort!

puts "Part 1"
puts totals[-1] * totals[-2]
