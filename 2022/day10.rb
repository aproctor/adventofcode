#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/10

class Machine
  attr_accessor :i, :x, :next_eval, :acc

  def initialize
    @i = 0
    @x = 1
    @next_eval = 40
    @acc = 0
    @line = ""
  end

  def evaluate
    cur_x = @i % 40
    if(cur_x >= @x-1 && cur_x <= @x+1)
      @line << "#"
    else
      @line << " "
    end

    if(@i >= self.next_eval)
      #puts "#{@i} x #{@x} = #{@i*@x}"
      self.next_eval += 40

      @acc += @i*@x

      @line = ""
      print "#{i}:\t#{@line}\n"
    else
      print "#{i}:\t#{@line}\r"
    end
    $stdout.flush
    #sleep(0.01)
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
      end
    end
  end

end

m = Machine.new
m.parse('day10.data')
#puts "Part 1: #{m.acc}"


