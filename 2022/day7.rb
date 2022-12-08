#!/usr/bin/env ruby
# See http://adventofcode.com/2022/day/7

class TreeNode
  attr_accessor :children, :fname, :parent, :fsize, :ftype
  @@path_map = {}
  @@collected_folders = []
  @@smallest_folder = nil

  def initialize(fname, ftype, parent)
    @fname = fname

    @parent = parent
    @ftype = ftype
    @fsize = 0
    @children = []

    if @parent.nil?
      #root?
      @@path_map["/"] = self
    else
      @@path_map[self.path] = self
    end
  end

  def path
    return "" if parent.nil?

    "#{parent.path}/#{fname}"
  end

  def size
    return @cached_size if !@cached_size.nil?

    total_size = @fsize

    @children.each do |c|
      total_size += c.size
    end

    @cached_size = total_size
  end

  def self.find_or_mkdir(full_path)
    if !@@path_map.key?(full_path)
      # I'm assuming root already exists, because I know it does and I don't want to complicate this too much while on part1
      raise "Unhandled root mapping" if full_path == "/"
      
      last_slash = full_path.rindex('/')
      if last_slash == 0
        parent_path = "/"
      else
        parent_path = full_path[0..last_slash-1]
      end
      fname = full_path[last_slash+1..-1]

      parent = TreeNode.find_or_mkdir(parent_path) #a little recursion here should handle cases where totally unknown paths are passed in
      new_dir = TreeNode.new(fname, :dir, parent)
      parent.children << new_dir

      @@path_map[full_path] = new_dir
    end

    @@path_map[full_path]
  end

  def collect_folders(max_size)    
    if self.ftype == :dir
      if(self.size < max_size)
        @@collected_folders << self
      end
      
      @children.each do |c|
        c.collect_folders(max_size)
      end      
    end
  end

  def sum_folders_gt(max_size)
    collect_folders(max_size)

    total = 0

    @@collected_folders.each do |d|
      #puts "#{d.path} is #{d.size}"
      total += d.size
    end

    total
  end

  def find_smallest_folder_gte(target_size)
    @@smallest_folder = self if @@smallest_folder.nil?

    if self.size >= target_size && @ftype == :dir
      @@smallest_folder = self if self.size < @@smallest_folder.size
      
      @children.each do |c|
        c.find_smallest_folder_gte(target_size)
      end
    end

    @@smallest_folder
  end

  def debug_print_contents(depth = 0, max_depth = 15)   
    return if depth > max_depth

    #puts @@path_map.keys.inspect if depth == 0
    
    if parent.nil?
      puts "- / (dir)"
    else
      buffer = []
      depth.times do 
        buffer << "  "
      end
      buffer << "- #{fname} (#{@ftype}"
      if @fsize == 0
        buffer << ")"
      else
        buffer << ", size=#{@fsize})"
      end
      puts buffer.join()
    end
    
    @children.each do |c|
      c.debug_print_contents(depth+1, max_depth)
    end
  end
end

class ConsoleCommand
  attr_accessor :cmd, :results, :command_type, :arg

  def initialize(cmd)
    @cmd = cmd
    @arg = nil
    @results = []

    if cmd.start_with?("cd ")
      @command_type = :change_dir
      @arg = cmd[3..-1]
    elsif cmd.start_with?("ls")
      @command_type = :list
    else
      puts "Unknown command <#{cmd}>"
      @command_type = :unknown
    end
  end
end

def change_directory(path, current, root)
  # simple root support
  if path == "/"
    current = root
    return current
  end

  # simple cd .. support
  if path == ".."
    raise "Invalid path #{path}" if current.parent.nil?
    current = current.parent

    return current
  end

  full_path = "#{current.path}/#{path}"
  current = TreeNode.find_or_mkdir(full_path)

  return current
  
  # I don't think we need to support absolute paths, so removing for now
  #
  # if path.start_with?("/")
  #   current = root
  #   path = path[1..-1]
  # end

  # I put this in assuming it needed to be supported, but it looks like we only support single folder changes and not complex paths
  #
  # path.split("/").each do |sub_path|
  #   sub_found = false
    
  #   if sub_path == "."
  #     next
  #   elsif sub_path == ".."
  #     raise "Invalid path #{path}" if current.parent.nil?
  #     current = current.parent
  #   end

  #   current.children.each do |c|
  #     if c.fname == sub_path
  #       current = c
  #       sub_found = true
  #       break
  #     end
  #   end

  #   if sub_found == false
  #     raise "Invalid path #{path}"
  #   end
  # end
end

commands = []
last_cmd = nil
File.open('day7.data').each do |line|
  next if(line.nil?)
  line = line.strip

  if line[0] == "$"
    if !last_cmd.nil?
      commands << last_cmd
    end
    last_cmd = ConsoleCommand.new(line[2..-1])    
  else
    last_cmd.results << line
  end
end
commands << last_cmd


root = TreeNode.new("", :dir, nil)
current_node = root

commands.each do |c|
  cwd = current_node.path
  #puts "#{cwd}>#{c.cmd}"
  if c.command_type == :change_dir
    current_node = change_directory(c.arg, current_node, root)
  elsif c.command_type == :list
    c.results.each do |f|
      file_info = f.split(" ")
      #puts file_info.inspect
      if file_info[0] == "dir"
        new_file = TreeNode.new(file_info[1], :dir, current_node)
      else
        new_file = TreeNode.new(file_info[1], :file, current_node)
        new_file.fsize = file_info[0].to_i
      end

      current_node.children << new_file
    end
  else
    puts "unsupported"
  end

  #puts "  #{c.results.inspect}" if c.results.length > 0
end

#root.debug_print_contents
puts "Part 1:"
puts root.sum_folders_gt(100000)


puts "\nPart 2:"
total_disk_size = 70000000
required_free_space = 30000000
free_space = total_disk_size - root.size
if required_free_space > free_space
  target_free_space = required_free_space - free_space

  puts "We need to free up #{target_free_space} to run the update"

  smallest = root.find_smallest_folder_gte(target_free_space)
  puts "Target folder is [#{smallest.path}] with size #{smallest.size}"
end