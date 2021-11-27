#!/usr/bin/env ruby
# Day 11
# See https://adventofcode.com/2015/day/11

MAX_ITERATIONS = 10000000000
A_ORD = "a".ord
I_ORD = "i".ord
L_ORD = "l".ord
O_ORD = "o".ord
ZERO_ORD = "0".ord
NINE_ORD = "9".ord
# ALPHABET = "abcdefghjkmnpqrstuvwxyz".split('')

def password_valid?(pass, mode=:normal)
	# Corporate policy dictates that passwords must be exactly eight lowercase letters 
	# Passwords may not contain the letters i, o, or l
	if(mode == :base26)
		md = pass.match(/^[0-79acdf-p]{8}$/)
	elsif(mode == :base23)
		md = pass.match(/^[0-9a-m]{8}$/)
	else
		md = pass.match(/^[a-hjkmnp-z]{8}$/)
	end	
	return false if(md.nil?)

	# Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
	cur_straight_count = 0
	straights = 0
	prev_char = nil	

	# Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
	pair_count = 0
	streak_count = 0

	pass.each_char.with_index do |c, i|
		#puts "#{i}: #{c}"
		if(i > 0)
			if(c.ord == prev_char.ord)
				streak_count += 1
				pair_count += 1 if(streak_count == 1)
			else
				streak_count = 0
			end

			if(c.ord == prev_char.ord + 1)
				cur_straight_count += 1
				if(cur_straight_count == 2)
					straights += 1
				end
			else
				cur_straight_count = 0
			end
		end		
		prev_char = c
	end

	# puts "Straights: #{straights}"
	# puts "Pairs: #{pair_count}"

	(straights > 0 && pair_count > 1)
end

def next_password(cur_password)
	new_chars = []

	l = cur_password.length
	increment = true
	cur_password.length.times do |i|
		pos = l-i-1
		if(increment)
			if(cur_password[pos] == 'z')
				new_chars[pos] = 'a'
				increment = true # carry over the digit to the next
			else
				new_chars[pos] = (cur_password[pos].ord + 1).chr
				increment = false
			end
		else
			new_chars[pos] = cur_password[pos]
		end
	end

	new_chars.join('')
end

# I'm abandoning this idea.  forcing ruby to work with large base23 numbers is not worth it
def convert_to_base23(password)
	# Passwords may not contain the letters i, o, or l
	# a-z inclusive is 26 numbers, if we omit forbidden letters that's 23 distinct letters	
	#convert the password to base23

	int_val = 0
	password.each_char.with_index do |c, i|
		d = c.ord
		
		# compress out the missing digits
		d -= 1 if(d > O_ORD)
		d -= 1 if(d > L_ORD)
		d -= 1 if(d > I_ORD)

		d = d - A_ORD

		int_val += d * 23 ** (8-i-1)
	end

	puts "int value = #{int_val}"

	int_val.to_s(23)
end

def convert_to_alpha(base23string)
	digits = []
	base23string.each_char do |c|
		d = c.ord

		if(d <= NINE_ORD)
			# digits 0-9 are digits a-j
			d = A_ORD + (d - ZERO_ORD)
		else
			# make room for the first 10 digits
			d = d + 10
		end

		digits << d.chr
	end

	digits.join('')
end

def p1_next_valid_password(original_password)
	puts "original: <#{original_password}>"
	cur_password = original_password

	MAX_ITERATIONS.times do |i|
		puts "Checking <#{cur_password}>" if i % 100000 == 0
		return cur_password if(password_valid?(cur_password, :normal))
		cur_password = next_password(cur_password)
	end

	puts "No Password found"
	return nil
end

# puts "abcdefgh valid? #{password_valid?('abcdefgh')}"
# puts "hijklmmn valid? #{password_valid?('hijklmmn')}"
# puts "abbceffg valid? #{password_valid?('abbceffg')}"
# puts "abbcegjk valid? #{password_valid?('abbcegjk')}"
# puts "abcdefgh valid? #{password_valid?('abcdefgh')}"
# puts "abcdffaa valid? #{password_valid?('abcdffaa')}"
# puts "ghjaabcc valid? #{password_valid?('ghjaabcc')}"
# puts convert_to_base23("abcdefghijklmnopqrstuvwxyz")
# puts convert_to_alpha("0123456789abcdefghijklmnopqrs")
# puts next_password("aaaaaa")
# puts next_password("aaaaaz")
# puts next_password("aaaazz")
# puts p1_next_valid_password("abcdefgh");
# puts p1_next_valid_password("ghijklmn");
puts p1_next_valid_password("hepxcrrq");
puts p1_next_valid_password("hepxxzaa")

