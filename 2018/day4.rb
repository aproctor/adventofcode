#!/usr/bin/env ruby
# See http://adventofcode.com/2018/day/4

MAX_ITERATIONS = 100000 #NASA required saftey on while loops

puts "Part 1 - sleepiest guard"

active_guard = nil
sleep_hour = 0
sleep_minute = 0
guard_sleep_schedule = {}
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
			sleep_hour = hour
			sleep_minute = minute
		elsif line.match(/wakes up/)
			# puts "#{active_guard} wakes"
			sleep_schedule = guard_sleep_schedule[active_guard]
			if sleep_schedule.nil?
				sleep_schedule = {
					id: active_guard,
					total_slept: 0,
					sleeps: []
				}
			end

      slept_mins = (hour - sleep_hour) * 60 + (minute - sleep_minute)
      sleep_schedule[:total_slept] = sleep_schedule[:total_slept] + slept_mins

      sleep_schedule[:sleeps] << {start_hour: sleep_hour, start_min: sleep_minute, end_hour: hour, end_min: minute}

      guard_sleep_schedule[active_guard] = sleep_schedule
		else
			active_guard = line.match(/Guard #(\d+)/)[1].to_i
			# puts "#{active_guard} active"
		end
	else
		puts "Unrecognized string: <#{line}>"
	end
end

sleepiest_guard = nil
guard_sleep_schedule.each do |k, guard|
	puts "Guard ##{k} slept #{guard[:total_slept]} minutes"
	if sleepiest_guard.nil? || guard[:total_slept] > sleepiest_guard[:total_slept]
		sleepiest_guard = guard
	end
end
puts "Guard ##{sleepiest_guard[:id]} is the sleepiest"

minutes = Array.new(60,0) #start each minute with 0 minutes slept
sleepiest_guard[:sleeps].each do |sleep|
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
max_value = minutes[0]
max_index = 0
minutes.each_with_index do |val, i|
	if(val > max_value)
		max_index = i
		max_value = val
	end
end
puts "minute #{max_index} is the most likely time he's asleep"
puts "Part 1 value: #{max_index * sleepiest_guard[:id]}"
