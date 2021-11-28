#!/usr/bin/env ruby
# See http://adventofcode.com/2015/day/21

MAX_LOOPS = 10000

class Gear
  attr_accessor :slot, :label, :cost, :damage, :armor

  def initialize(slot, label, cost, damage, armor)
    @slot = slot
    @label = label
    @cost = cost
    @damage = damage
    @armor = armor
  end

  def to_s
  	"#{slot},#{label},#{cost},#{damage},#{armor}"
  end
end

class Character
	attr_accessor :title, :max_hp, :cur_hp, :armor, :damage

	def initialize(title, max_hp, damage, armor)
		@title = title
		@cur_hp = @max_hp = max_hp		
		@damage = damage
		@armor = armor
	end

	def equip(gear)
		@armor += gear.armor
		@damage += gear.damage
	end

	def alive?
		@cur_hp > 0
	end

	def take_hit(damage)
		hit = [1, damage-@armor].max
		@cur_hp = [0, @cur_hp-hit].max

		# attacker = @title == "player" ? "enemy" : "player";
		# puts "The #{attacker} deals #{damage}-#{@armor} = #{hit} damage; the #{@title} goes down to #{@cur_hp} hit points."

		hit
	end

	def fight(enemy)
		MAX_LOOPS.times do
			enemy.take_hit(self.damage)
			return true if(!enemy.alive?)

			self.take_hit(enemy.damage)	
			return false if(!self.alive?)
		end

		puts "Max fight length exceded, it's a loss to the attack"
		false
	end
end

def test_fight
	player = Character.new("player", 8, 5, 5)
	boss = Character.new("boss", 12, 7, 2)

	if player.fight(boss)
		puts "Victory"
	else
		puts "Defeat"
	end
end
#test_fight()

# Weapons
# You must buy exactly one weapon; no dual-wielding
weapons = []
weapons << Gear.new("weapon", "Dagger", 8, 4, 0)
weapons << Gear.new("weapon", "Shortsword", 10, 5, 0)
weapons << Gear.new("weapon", "Warhammer", 25, 6, 0)
weapons << Gear.new("weapon", "Longsword", 40, 7, 0)
weapons << Gear.new("weapon", "Greataxe", 74, 8, 0)


# Armor
# Armor is optional, but you can't use more than one
armor = []
armor << Gear.new("armor", "None", 0, 0 , 0) # cheeky to avoid logic for 0 armor bought
armor << Gear.new("armor", "Leather", 13, 0, 1)
armor << Gear.new("armor", "Chainmail", 31, 0, 2)
armor << Gear.new("armor", "Splintmail", 53, 0, 3)
armor << Gear.new("armor", "Bandedmail", 75, 0, 4)
armor << Gear.new("armor", "Platemail", 102, 0, 5)

# Rings
# You can buy 0-2 rings
rings = []
rings << Gear.new("ring", "None", 0, 0 , 0) # no ring 1
rings << Gear.new("ring", "None", 0, 0 , 0) # no ring 2
rings << Gear.new("ring", "Damage +1", 25, 1, 0)
rings << Gear.new("ring", "Damage +2", 50, 2, 0)
rings << Gear.new("ring", "Damage +3", 100, 3, 0)
rings << Gear.new("ring", "Defense +1", 20, 0, 1)
rings << Gear.new("ring", "Defense +2", 40, 0, 2)
rings << Gear.new("ring", "Defense +3", 80, 0, 3)



def part1(weapons, armor, rings)	
	tested_loadouts = {}

	(0..400).each do |budget|
		# puts "Shopping with a budget of #{budget} gold"
		
		loadouts = []
		weapons.each do |w|			
			next if w.cost > budget

			armor.each do |a|
				next if a.cost + w.cost > budget

				rings.each_with_index do |r1, i|
					next if r1.cost + a.cost + w.cost > budget

					rings.each_with_index do |r2, j|
						# The shop only has one of each item, so you can't buy, for example, two rings of Damage +3
						next if i == j # || i > j  #we'll also skip any index for r2 < r1 as it's redundant

						total_cost = w.cost + a.cost + r1.cost + r2.cost
						if(total_cost <= budget)
							k = "#{w.label},#{a.label},#{r1.label},#{r2.label}"
							if(!tested_loadouts.key?(k))
								# puts "new loadout: #{k}"
								loadouts << [w, a, r1, r2]
								tested_loadouts[k] = 1
							end
						end
					end
				end
			end
		end

		# BiS Loadout test
		# loadouts = [[weapons[-1], armor[-1], rings[-1], rings[-2]]]

		#puts "All possible loadouts for a budget of #{budget}: "
		#puts loadouts.inspect
		if loadouts.length == 0
			# puts "\tno new loadouts"
			next 
		end
				
		loadouts.each do |l|
			# puts "Fighting with a budget of #{budget}"
			player = Character.new("player", 100, 0, 0)
			boss = Character.new("boss", 109, 8, 2)	

			l.each do |gear|
				player.equip(gear)
			end
			# puts "Player: #{player.damage}, #{player.armor}"
			# puts "Boss: #{boss.damage}, #{boss.armor}"

			if player.fight(boss)
				puts "Victory with a budget of #{budget}g"
				l.each do |gear|
					puts "\t#{gear.to_s}"				
				end
				return true
			else
				# puts "Defeat"
			end
		end
	end

	puts "No winnning loadouts found even with 400g budget"

	#no winning strategy was found
	false
end

def part2(weapons, armor, rings)	
		
	loadouts = []
	weapons.each do |w|			
		armor.each do |a|
			rings.each_with_index do |r1, i|
				rings.each_with_index do |r2, j|
					# The shop only has one of each item, so you can't buy, for example, two rings of Damage +3
					next if i == j # || i > j  #we'll also skip any index for r2 < r1 as it's redundant

					total_cost = w.cost + a.cost + r1.cost + r2.cost
					k = "#{w.label},#{a.label},#{r1.label},#{r2.label}"
					loadouts << {key: k, cost: total_cost, gear: [w, a, r1, r2]}
				end
			end
		end
	end


	loadouts.sort! { |l1, l2| l2[:cost] - l1[:cost] }

	loadouts.each do |l|
		# puts "Fighting with a budget of #{budget}"
		player = Character.new("player", 100, 0, 0)
		boss = Character.new("boss", 109, 8, 2)	

		l[:gear].each do |gear|
			player.equip(gear)
		end
		# puts "Player: #{player.damage}, #{player.armor}"
		# puts "Boss: #{boss.damage}, #{boss.armor}"

		if !player.fight(boss)
			puts "Defeat with a budget of #{l[:cost]}g.\nEquipment: #{l[:key]}"
			return true
		else
			# puts "Victory :("
		end
	end
	

	puts "No losing loadouts found even with 1g budget"

	#no winning strategy was found
	false
end

puts "Part 1:"
part1(weapons, armor, rings)

puts "\n\nPart 2:"
part2(weapons, armor, rings)



