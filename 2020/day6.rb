#!/usr/bin/env ruby
# See http://adventofcode.com/2020/day/6


class DeclarationForm  

  def initialize()
  	@members = []
  	@yes_vals = {}
  end

  def add_person(claim_string)
  	claim_string.each_char do |c|
  		@yes_vals[c] = 1
  	end
  	@members << claim_string
  end

  def yes_count
  	#puts @members.inspect
  	@yes_vals.keys.length
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
forms.each do |f|
	p1_sum += f.yes_count
end
puts "Part 1: #{p1_sum}"