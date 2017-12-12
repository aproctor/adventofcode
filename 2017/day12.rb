#!/usr/bin/env ruby

puts "Day 12"

class Program
	attr_reader :pid, :pipe_keys, :pipes
	attr_accessor :group

	def initialize(pid, pipe_keys)
		@pid = pid
		@pipe_keys = pipe_keys
		@pipes = {}
		@group = nil
	end

	def connect_pipes(program_map)
		@pipe_keys.each do |key|
			#this assumes all keys exist within the map, but that should be fine
			connect(program_map[key])
		end
	end

	def connect(program)
		if @pipes[program.pid].nil?
			@pipes[program.pid] = program

			#this would be infinitely recursive, but we prevent connecting to the same node over and over
			program.connect(self)
		end
	end

	def path_to(destination, cur_path)
		path = cur_path.dup
		path << @pid

		return path if(destination == @pid)
			
		@pipes.each do |key, program|
			if(!path.include?(key))
				found_path = program.path_to(destination, path)
				return found_path if !found_path.nil?
			end
		end

		return nil
	end
end


program_map = {}
File.open('day12.data').each do |line|
	next if(line.nil?) 

	#eg: 2 <-> 0, 3, 4
	parts = line.strip!.split(" <-> ")

	program_map[parts[0]] = Program.new(parts[0], parts[1].split(', '))
end

#After all programs are intialized, connect pipes via the map
program_map.each do |key, program|
	program.connect_pipes(program_map)
end

connected = 0
program_map.each do |key, program|
	path = program.path_to("0",[])
	#puts path.inspect if !path.nil?
	connected += 1 if !path.nil?
end

puts "Part 1 - total connected #{connected}"

#Part 2 find distinct groups
group_roots = {}
cur_group = 0
group_roots[cur_group] = program_map.keys.first

program_map.each do |key, program|
	group_roots.each do |k,v|
		if(!program.path_to(v,[]).nil?)
			program.group = k
			break
		end
	end
	if(program.group.nil?)
		puts "No group found for #{key}, #{cur_group}"
		#no existing group found, let's define a new one
		cur_group += 1
		program.group = cur_group
		group_roots[cur_group] = program
	end
end

puts "Part 2 - #{group_roots.count} groups found"