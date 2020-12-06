#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/6


class DeclarationForm  

  def initialize()
  	@members = []
  	@yes_vals = {}
  end

  def add_person(claim_string)
  	claim_string.each_char do |c|
  		if @yes_vals.key?(c)
  			@yes_vals[c] += 1
  		else
	  		@yes_vals[c] = 1
	  	end
  	end
  	@members << claim_string
  end

  def yes_count
  	#puts @yes_vals.inspect
  	@yes_vals.keys.length
  end

  def all_yes_count
  	total = 0
  	all_count = @members.length
  	@yes_vals.each do |k,v|
  		total += 1 if v == all_count
  	end

  	total
  end
end


forms = []
form = DeclarationForm.new
File.open('day6.data').each do |line|
  next if(line.nil?)
  
  if(line == "\n")
  	forms << form
  	form = DeclarationForm.new
  else
  	form.add_person(line.strip)
  end
end
#Add last form
forms << form

p1_sum = 0
p2_sum = 0
forms.each do |f|
	p1_sum += f.yes_count
	p2_sum += f.all_yes_count
end
puts "Part 1: #{p1_sum}"
puts "Part 2: #{p2_sum}"