#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/15

class Ingredient
  attr_accessor :label, :attributes

  def initialize(input)
  	# Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
		# Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    args = input.split(": ")
    if(args.length < 2)
    	raise "invalid input <#{input}>"
    end
    @label = args[0]
    @attributes = {}

    args[1].split(", ").each do |s|
    	vals = s.split(" ")
    	@attributes[vals[0].to_sym] = vals[1].to_i
    end    
  end
end

class Recipe
	@ingredients = []

	def initialize()
		@ingredients = []
	end

	def add_ingredient(i)
		@ingredients << i
	end

	def total_score(quantities)
		capacity_score = 0
		durability_score = 0
		flavor_score = 0
		texture_score = 0

		@ingredients.each_with_index do |ingredient, i|
			capacity_score += ingredient.attributes[:capacity] * quantities[i]
			durability_score += ingredient.attributes[:durability] * quantities[i]
			flavor_score += ingredient.attributes[:flavor] * quantities[i]
			texture_score += ingredient.attributes[:texture] * quantities[i]
		end

		#Clamp out negative values to 0
		capacity_score = [capacity_score, 0].max
		durability_score = [durability_score, 0].max
		flavor_score = [flavor_score, 0].max
		texture_score = [texture_score, 0].max

		total_score = capacity_score * durability_score * flavor_score * texture_score

		puts "#{quantities.join(', ')} = #{total_score}"

		total_score
	end

	def optimize
		puts "Optimizing recipe with #{@ingredients.length} ingredients"

		max_score = 0
		max_quantities = nil

		101.times do |x|
			101.times do |y|
				101.times do |z|
					quantities = [x, y, z, 100-x-y-z]
					score = self.total_score(quantities)
					if(score > max_score)
						max_score = score
						max_quantities = quantities
					end
				end
			end
		end

		puts "Maximum score is #{max_score} using #{max_quantities.join(', ')}"
		

		# quantities = [44,56]

	end
end

recipe = Recipe.new()
File.open('day15.data').each do |line|
  next if(line.nil?)
  
  recipe.add_ingredient(Ingredient.new(line.strip))
end

recipe.optimize


