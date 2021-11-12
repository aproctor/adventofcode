#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/13

class Person
  attr_accessor :given_name, :relations
  @@people = {}

  def self.find_or_create(given_name)
  	if !@@people.key?(given_name)
  		@@people[given_name] = Person.new(given_name)
  	end

  	@@people[given_name]
  end

  def self.maximum_happiness
  	first_name = nil
  	max_happy = 0
  	best_seating = nil

  	@@people.keys.permutation.each do |list|
  		first_name = list[0] if first_name.nil?

  		#skip permutations that are just rotations of the first set of people
  		#i'm being lazy as ruby has as a nice permutation function and i could just build this
  		break if list[0] != first_name

  		total_happiness = 0
  		last_person = nil
  		list.each_with_index do |n, i|
  			cur_person = Person.find_or_create(n)
  			if(i > 0)
  				total_happiness += cur_person.happiness_with(last_person)
  			end
  			last_person = cur_person
  		end
  		# connect last to first person
  		total_happiness += Person.find_or_create(first_name).happiness_with(last_person)

  		# puts "#{list.join(' > ')} = #{total_happiness}"

  		if(total_happiness > max_happy)
  			max_happy = total_happiness
  			best_seating = list
  		end
  	end

  	puts "Maximum seating arrangement is: #{best_seating.join(' > ')}"
  	puts "Happiness: #{max_happy}"

  	max_happy
  end

  def initialize(given_name)
    @given_name = given_name
    @relations = {}
  end

  def relationship(other_name, happiness)
  	#puts "#{@given_name} -> #{other_name} = #{happiness}"
  	@relations[other_name] = happiness
  end

  def happiness_with(other)
  	@relations[other.given_name].to_i + other.relations[self.given_name].to_i
  end
end

File.open('day13.data').each do |line|
  next if(line.nil?)

  # Alice would gain 54 happiness units by sitting next to Bob.
	# Alice would lose 79 happiness units by sitting next to Carol.
  md = line.match(/(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+).\n/)
  if(!md.nil?)
    person = Person.find_or_create(md[1])
    quantity = md[3].to_i
    if(md[2] == "lose")
    	quantity = -quantity
    end
    person.relationship(md[4], quantity)
  else
  	puts "Not recognized <#{line}>"
  end
end

Person::maximum_happiness



