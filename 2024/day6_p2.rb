#!/usr/bin/env ruby
# See http://adventofcode.com/2024/day/6

DIRECTIONS = {
  :up => { :x => 0, :y => -1, :sym => '^' },
  :down => { :x => 0, :y => 1, :sym => 'v' },
  :left => { :x => -1, :y => 0, :sym => '<' },
  :right => { :x => 1, :y => 0, :sym => '>' }
}

class Guard
  attr_accessor :x, :y, :dir, :visited_points

  def initialize(x, y, dir)
    @x = x
    @y = y
    @dir = dir
    @visited_points = {}
    visit(x, y)
  end

  def visit(x, y)
    key = "#{x},#{y}"
    @visited_points[key] = true
  end

  def visited?(x, y)
    key = "#{x},#{y}"
    return @visited_points[key] || false
  end

  def pos
    return [@x, @y, @dir]
  end

  def next_dir()
    case @dir
    when :up
      return :right
    when :right
      return :down
    when :down
      return :left
    when :left
      return :up
    end
  end
end

class Board
  attr_accessor :obstructions, :guard, :visited_points, :new_objstruction

  def initialize()
    @obstructions = []
    @height = 0
    @width = 0
    @guard = nil
    @new_objstruction = nil
    @initial_guard_pos = nil
    @visited_points = nil
  end

  def add_row(line)
    y = @height
    line.each_char.with_index do |c, i|
      if(c == '#')
        @obstructions.push({ :x => i, :y => y})
      end
      if(c == '^')
        @guard = Guard.new(i, y, :up)
        @initial_guard_pos = @guard.pos
      end
    end
    @height += 1

    @width = line.length if line.length > @width
  end

  def out_of_bounds?(x, y)
    return x < 0 || y < 0 || x >= @width || y >= @height
  end

  def step(store_visited_points)
    return if(@guard.nil?)

    new_x = @guard.x + DIRECTIONS[@guard.dir][:x]
    new_y = @guard.y + DIRECTIONS[@guard.dir][:y]

    if(out_of_bounds?(new_x, new_y))
      self.print
      puts "Guard out of bounds, total visited spaces = #{guard.visited_points.length}"
      if store_visited_points
        # First pass iteration, store the original visited points for future exploration
        @visited_points = @guard.visited_points
      end
      @guard = nil
      return
    end

    if(@obstructions.any? { |o| o[:x] == new_x && o[:y] == new_y })
      @guard.dir = @guard.next_dir
      return
    end

    @guard.x = new_x
    @guard.y = new_y
    @guard.visit(new_x, new_y)
  end

  def reset()
    @guard = Guard.new(@initial_guard_pos[0], @initial_guard_pos[1], @initial_guard_pos[2])
  end

  def print
    @height.times do |y|
      row = ''
      @width.times do |x|
        if(@obstructions.any? { |o| o[:x] == x && o[:y] == y })
          row += '#'
        elsif(@guard && @guard.x == x && @guard.y == y)
          row += "\e[32m"
          row += DIRECTIONS[@guard.dir][:sym]
          row += "\e[0m"
        elsif(@new_objstruction && @new_objstruction == "#{x},#{y}")
          row += "\e[33mO\e[0m"
        elsif(@guard && @guard.visited?(x, y))
          row += "\e[31mX\e[0m"
        else
          row += '.'
        end
      end
      puts row
    end
  end
end


board = Board.new
File.open('day6.data').each do |line|
  next if(line.nil?)
  board.add_row(line.strip)
end

board.print


# Find the first path
ITERATIONS = 10000
STEPS_PER_ITERATION = 10000

ITERATIONS.times do
  puts "\n"
  # wait for input
  command = gets
  break if command.nil? || command.strip == 'q' || board.guard.nil?

  puts "\e[H\e[2J" #clear screen

  STEPS_PER_ITERATION.times do
    board.step(true)
  end
  board.print unless board.guard.nil?
end

# Find all possible obsticles
board.visited_points.each do |key, value|
  board.reset
  board.new_objstruction = key

  board.print

  puts "\n"
  # wait for input
  command = gets
  break if command.nil? || command.strip == 'q' || board.guard.nil?

  #puts "\e[H\e[2J" #clear screen
end
