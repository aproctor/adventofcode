#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/8

class TreeNode
  @@data = nil
  @@all_nodes = []
  @@cur_index = 0
  @@root = nil

  @@checksum = 0

  attr_accessor :nodes, :meta_data

  def initialize()
    @nodes = []
    @meta_data = []
    @start = @@cur_index+=1
    node_count = @@data[@start]
    meta_data_count = @@data[@@cur_index+=1]
    #puts "nc: #{node_count}, mdc: #{meta_data_count}"

    @@all_nodes << self

    #Build children
    node_count.times do
      @nodes << TreeNode.new
    end
    meta_data_count.times do
      md = @@data[@@cur_index+=1]
      @meta_data << md
      @@checksum += md
    end
    @end = @@cur_index -1
  end

  def to_s
    " #{@start}-#{@end},#{@nodes.count},#{@meta_data.count}"
  end

  def self.build(d)
    @@data = d
    @@cur_index = -1
    @@checksum = 0
    @@root = TreeNode.new

    return @@root
  end

  def p2_value
    if @nodes.count == 0
      #If no children, then sum of metadata
      return @meta_data.inject(0){|sum,x| sum + x }
    end

    #Otherwise, value is sum of child[x-1] p2_value
    #Where x = value of each meta data
    child_sum = 0
    @meta_data.each do |md|
      idx = md-1
      child_sum += @nodes[md-1].p2_value if idx >= 0 && idx < @nodes.count
    end
    return child_sum
  end

  def self.print_tree
    #puts @@data.inspect
    @@all_nodes.each_with_index do |n, i|
      #note this causes an error with too many nodes, need some sort of modulo
      #a = ("A".ord + i).chr
      #puts "#{a}: #{n}"
    end
    puts "Checksum: #{@@checksum}"
    puts "P2 Value: #{@@root.p2_value}"
  end
end

# Initialize Data
input = []
File.open('day8.data').each do |line|
  next if(line.nil?)
  input += line.split(" ").map { |str| str.to_i}
end
root = TreeNode.build(input)
TreeNode.print_tree



