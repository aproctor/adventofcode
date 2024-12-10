#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/5

class Page
  attr_accessor :val, :weight

  @@page_weights = {}

  def initialize(val)
    @val = val
  end

  # Compare pages based on their weight
  def <=>(other)
    weight_key = Page.weight_key(self.val, other.val)
    if @@page_weights[weight_key].nil?
      return 0
    end

    return @@page_weights[weight_key] * (self.val <=> other.val)
  end

  def self.register_weights(v1, v2)
    # Page weight is positive or negative 1 based on whether the page values would sort normally or inverted conventionally
    inverted = v1 > v2
    weight_key = weight_key(v1, v2)

    if inverted
      @@page_weights[weight_key] = -1
    else
      @@page_weights[weight_key] = 1
    end
  end

  def self.weight_key(v1, v2)
    [v1, v2].sort.join(',')
  end

end


instructions = []
reports = []
done_instructions = false

File.open('day5.data').each do |line|
  next if(line.nil?)

  line.strip!

  if done_instructions == false
    if line == ""
      done_instructions = true
    else
      instructions << line.split("|").map(&:to_i)
    end
  else
    reports << line.split(",").map(&:to_i)
  end
end

#puts "instructions:\n#{instructions.inspect}"
#puts "reports:\n#{reports.inspect}"

def report_valid?(report, instructions)
  instructions.each do |instruction|
    v1index = report.index(instruction[0])
    v2index = report.index(instruction[1])
    next if(v1index.nil? || v2index.nil?)

    return false if v1index > v2index
  end

  return true
end

def sort_report(report, instructions)
  pages = []
  report.each do |val|
    pages << Page.new(val)
  end

  pages.sort.map(&:val)
end

incorrect = []

puts "Part 1"
total = 0
reports.each do |report|
  valid = report_valid?(report, instructions)
  if valid
    #puts report.join(',')
    #increase total by mid value of report
    total += report[report.length / 2] if valid
  else
    incorrect << report
  end
end
puts "Total: #{total}"


puts "Part 2"
# register a dictionary of page weights
instructions.each do |instruction|
  Page.register_weights(instruction[0], instruction[1])
end

total = 0
incorrect.each do |report|
  #puts report.join(',')
  sorted = sort_report(report, instructions)
  #puts sorted.join(',')
  total += sorted[sorted.length / 2]
end
puts "Total: #{total}"

