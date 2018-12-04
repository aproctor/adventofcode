#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/4

MAX_ITERATIONS = 100000 #NASA required saftey on while loops

puts "Part 2 - sleepiest minute"

active_guard = nil
sleep_hour = 0
sleep_minute = 0
guard_sleep_schedule = {}
sleeping = false
File.open('day4.data').each do |line|
  next if(line.nil? || line.strip.length == 0)

  #[1518-11-01 00:00] Guard #10 begins shift
  #[1518-11-01 00:05] falls asleep
  #[1518-11-01 00:25] wakes up
	md = line.match(/\[\d+-\d+-\d+ (\d+):(\d+)\]/)
	if(md)
		hour = md[1].to_i
		minute = md[2].to_i

		if line.match(/falls asleep/)
			# puts "#{active_guard} sleeps"
			if(!sleeping && active_guard != nil)
				sleep_hour = hour
				sleep_minute = minute
				sleeping = true
			end
		elsif line.match(/wakes up/)
			# puts "#{active_guard} wakes"
			if(sleeping && active_guard != nil)
				sleep_schedule = guard_sleep_schedule[active_guard]
				if sleep_schedule.nil?
					sleep_schedule = {
						id: active_guard,
						sleeps: []
					}
				end

	      sleep_schedule[:sleeps] << {start_hour: sleep_hour, start_min: sleep_minute, end_hour: hour, end_min: minute}

	      guard_sleep_schedule[active_guard] = sleep_schedule

	      sleeping = false
	    end
		else
			active_guard = line.match(/Guard #(\d+)/)[1].to_i
			# puts "#{active_guard} active"
		end
	else
		puts "Unrecognized string: <#{line}>"
	end
end

sleepiest_info = nil
max_freq = 0
guard_sleep_schedule.each do |k, guard|
	minutes = Array.new(60,0) #start each minute with 0 minutes slept

	guard[:sleeps].each do |sleep|
		#you could ignore whole hours of overlap but let's keep the algorithm simple until part 2 is revealed
		cur_minute = sleep[:start_min]
		cur_hour = sleep[:start_hour]
		MAX_ITERATIONS.times do
			minutes[cur_minute] = minutes[cur_minute] + 1
			cur_minute += 1
			if(cur_minute == 60)
				cur_hour += 1
				cur_minute = 0
			end
			break if cur_minute == sleep[:end_min] && cur_hour == sleep[:end_hour]
		end
	end

	new_record_index = nil
	minutes.each_with_index do |val, i|
		if(val > max_freq)
			new_record_index = i
			max_freq = val
		end
	end
	if(new_record_index)
		sleepiest_info = {id: guard[:id], minute: new_record_index, freq: max_freq}
	end
end
puts "sleepiest info: #{sleepiest_info.inspect}"
puts "Part 2 value: #{sleepiest_info[:id] * sleepiest_info[:minute]}"
