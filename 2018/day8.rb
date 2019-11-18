#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/8

class TreeNode
  @@data = nil
  @@all_nodes = []
  @@cur_index = 0

  attr_accessor :nodes, :meta_data

  def initialize(start_index)
    @nodes = []
    @meta_data = []
    @start = start_index
    @node_count = @@data[start_index]
    @meta_data_count = @@data[start_index+1]

    @@all_nodes << self

    #TODO Build children
    # cur_index = start + 2
    # for each node, recurse
    # for each meta data, append

    # @end = cur_index -1
  end

  def to_s
    " #{@start},#{@node_count},#{@meta_data_count}"
  end

  def self.build(d)
    @@data = d
    @@cur_index = 0
    root = TreeNode.new(0)
  end
  def self.print_tree
    puts @@data.inspect
    @@all_nodes.each_with_index do |n, i|
      a = ("A".ord + i).chr
      puts "#{a}: #{n}"
    end
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



