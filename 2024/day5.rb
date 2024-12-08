#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/5

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

puts "Part 1"
total = 0
reports.each do |report|
  valid = report_valid?(report, instructions)
  if valid
    puts report.join(',')
    #increase total by mid value of report
    total += report[report.length / 2] if valid
  end
end
puts "Total: #{total}"