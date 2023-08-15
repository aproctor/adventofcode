#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/10

class Machine
  attr_accessor :i, :x, :next_eval, :acc

  def initialize
    @i = 1
    @x = 1
    @next_eval = 20
    @acc = 0
  end

  def evaluate
    if(@i >= self.next_eval)
      puts "#{@i} x #{@x} = #{@i*@x}"
      self.next_eval += 40

      @acc += @i*@x
    end
  end

  def parse(path)
    File.open(path).each do |line|
      next if(line.nil?)
      md = line.match(/(addx|noop) ?(-?[0-9]+)?/)
      if(!md.nil?)
        command = md[1].to_sym

        #process command
        @i += 1
        self.evaluate


        #process add command
        if command == :addx
          value = md[2].to_i
          @x += value

          @i += 1
          self.evaluate
        end

        #puts "#{i}: #{command} #{value} | #{x}"

        self.evaluate
      end
    end
  end

end

m = Machine.new
m.parse('day10.data')
puts "Part 1: #{m.acc}"


