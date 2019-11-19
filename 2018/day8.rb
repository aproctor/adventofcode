#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/8

class TreeNode
  @@data = nil
  @@all_nodes = []
  @@cur_index = 0

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
    root = TreeNode.new
  end
  def self.print_tree
    puts @@data.inspect
    @@all_nodes.each_with_index do |n, i|
      a = ("A".ord + i).chr
      puts "#{a}: #{n}"
    end
    puts "Checksum: #{@@checksum}"
  end
end

# Initialize Data
input = []
File.open('day8.data').each do |line|
  next if(line.nil?)
  input += line.split(" ").map { |str| str.to_i}
end
TreeNode.build(input)


TreeNode.print_tree



