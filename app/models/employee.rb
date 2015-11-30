class Employee < ActiveRecord::Base
	has_many :attendances
	



    def full_name
    	"#{first_name} #{name}"
    end
    

    # list of all the outs of today
	def sorties_today
		self.sorties.this_day
	end

	def entrees
		self.attendances.entree		
	end

	def sorties
		self.attendances.sortie
	end	
	
	def last_move_content
		if self.attendances.last.content == "entree"
			"Dernière entrée"
		elsif self.attendances.last.content == "sortie"
			"Dernière sortie"
		end
	end

	def last_move_time
		self.attendances.last.created_at
	end


	def last_move_day
		if self.last_move_time.strftime("%u") == '7'
			"dimanche"
		elsif self.last_move_time.strftime("%u") == '1'
			"lundi"
		elsif self.last_move_time.strftime("%u") == '2'
			"mardi"
		elsif self.last_move_time.strftime("%u") == '3'
			"mercredi"
		elsif self.last_move_time.strftime("%u") == '4'
			"jeudi"
		elsif self.last_move_time.strftime("%u") == '5'
			"vendredi"
		elsif self.last_move_time.strftime("%u") == '6'
			"samedi"
		end
			
	end

	

	def full_name_with_id
    	"##{id} - #{full_name}"
  	end

	# calculation

	# def duration
	# 	# time of one particular sortie - time of previous entree of the employee
	# 	if self.attendances.sortie

	# 	self.attendances.sortie.last.created_at - self.attendances.entree.where("created_at < ?", self.attendances.sortie.created_at).last.created_at
	# end

	def duration(attendance)
		if attendance.sortie
			(attendance.created_at - previous_entree(attendance).created_at).floor
		end
	end

	def previous_entree(attendance)
		if attendance.sortie
			self.attendances.entree.where("created_at < ?", attendance.created_at).last
		end
	end

	def duration_in_minutes(attendance)
		(duration(attendance) / 60).floor
	end

	def duration_in_hours(attendance)
		(duration_in_minutes(attendance) / 60).floor
	end

	def display_duration_minutes(attendance)
		duration_in_minutes(attendance) - (duration_in_hours(attendance))*60
	end

	def display_duration_seconds(attendance)
		duration(attendance) - (duration_in_minutes(attendance)*60)	
	end

	def display_duration(attendance)
		"#{duration_in_hours(attendance)}h#{display_duration_minutes(attendance)}m#{display_duration_seconds(attendance)}s"
	end
	
	def total_duration
		# From zero, sum up each duration for an employee
		
	    total_duration = 0
	    attendances.sortie.each do |sortie|
	      total_duration += duration(sortie)
	    end
	    total_duration
  	end

	def total_duration_in_minutes
		(total_duration / 60).floor
	end

	def total_duration_in_hours
		(total_duration_in_minutes / 60).floor
	end

	def display_total_duration_minutes
		total_duration_in_minutes - total_duration_in_hours*60
	end

	def display_total_duration_seconds
		total_duration - total_duration_in_minutes*60
	end

	def display_total_duration
		"#{total_duration_in_hours}h#{display_total_duration_minutes}m#{display_total_duration_seconds}s"
	end

	def total_duration_this_day
		total_duration_this_day = 0
		attendances.sortie.this_day.each do |sortie|
			total_duration_this_day += duration(sortie)
		end
		total_duration_this_day		
	end

	def total_duration_this_day_in_minutes
		(total_duration_this_day / 60).floor
	end

	def total_duration_this_day_in_hours
		(total_duration_this_day_in_minutes / 60).floor
	end

	def display_total_duration_this_day_minutes
		total_duration_this_day_in_minutes - total_duration_this_day_in_hours*60
	end

	def display_total_duration_this_day_seconds
		total_duration_this_day - total_duration_this_day_in_minutes*60
	end

	def display_total_duration_this_day
		"#{total_duration_this_day_in_hours}h#{display_total_duration_this_day_minutes}m#{display_total_duration_this_day_seconds}s"
	end

	def total_duration_one_day_before
		total_duration_one_day_before = 0
		attendances.sortie.one_day_before.each do |sortie|
			total_duration_one_day_before += duration(sortie)
		end
		total_duration_one_day_before		
	end

	def total_duration_one_day_before_in_minutes
		(total_duration_one_day_before / 60).floor
	end

	def total_duration_one_day_before_in_hours
		(total_duration_one_day_before_in_minutes / 60).floor
	end

	def display_total_duration_one_day_before_minutes
		total_duration_one_day_before_in_minutes - total_duration_one_day_before_in_hours*60
	end

	def display_total_duration_one_day_before_seconds
		total_duration_one_day_before - total_duration_one_day_before_in_minutes*60
	end

	def display_total_duration_one_day_before
		"#{total_duration_one_day_before_in_hours}h#{display_total_duration_one_day_before_minutes}m#{display_total_duration_one_day_before_seconds}s"
	end

	def total_duration_two_days_before
		total_duration_two_days_before = 0
		attendances.sortie.two_days_before.each do |sortie|
			total_duration_two_days_before += duration(sortie)
		end
		total_duration_two_days_before		
	end

	def total_duration_two_days_before_in_minutes
		(total_duration_two_days_before / 60).floor
	end

	def total_duration_two_days_before_in_hours
		(total_duration_two_days_before_in_minutes / 60).floor
	end

	def display_total_duration_two_days_before_minutes
		total_duration_two_days_before_in_minutes - total_duration_two_days_before_in_hours*60
	end

	def display_total_duration_two_days_before_seconds
		total_duration_two_days_before - total_duration_two_days_before_in_minutes*60
	end

	def display_total_duration_two_days_before
		"#{total_duration_two_days_before_in_hours}h#{display_total_duration_two_days_before_minutes}m#{display_total_duration_two_days_before_seconds}s"
	end

	def total_duration_three_days_before
		total_duration_three_days_before = 0
		attendances.sortie.three_days_before.each do |sortie|
			total_duration_three_days_before += duration(sortie)
		end
		total_duration_three_days_before		
	end

	def total_duration_three_days_before_in_minutes
		(total_duration_three_days_before / 60).floor
	end

	def total_duration_three_days_before_in_hours
		(total_duration_three_days_before_in_minutes / 60).floor
	end

	def display_total_duration_three_days_before_minutes
		total_duration_three_days_before_in_minutes - total_duration_three_days_before_in_hours*60
	end

	def display_total_duration_three_days_before_seconds
		total_duration_three_days_before - total_duration_three_days_before_in_minutes*60
	end

	def display_total_duration_three_days_before
		"#{total_duration_three_days_before_in_hours}h#{display_total_duration_three_days_before_minutes}m#{display_total_duration_three_days_before_seconds}s"
	end

	def total_duration_four_days_before
		total_duration_four_days_before = 0
		attendances.sortie.four_days_before.each do |sortie|
			total_duration_four_days_before += duration(sortie)
		end
		total_duration_four_days_before		
	end

	def total_duration_four_days_before_in_minutes
		(total_duration_four_days_before / 60).floor
	end

	def total_duration_four_days_before_in_hours
		(total_duration_four_days_before_in_minutes / 60).floor
	end

	def display_total_duration_four_days_before_minutes
		total_duration_four_days_before_in_minutes - total_duration_four_days_before_in_hours*60
	end

	def display_total_duration_four_days_before_seconds
		total_duration_four_days_before - total_duration_four_days_before_in_minutes*60
	end

	def display_total_duration_four_days_before
		"#{total_duration_four_days_before_in_hours}h#{display_total_duration_four_days_before_minutes}m#{display_total_duration_four_days_before_seconds}s"
	end

	def total_duration_five_days_before
		total_duration_five_days_before = 0
		attendances.sortie.five_days_before.each do |sortie|
			total_duration_five_days_before += duration(sortie)
		end
		total_duration_five_days_before		
	end

	def total_duration_five_days_before_in_minutes
		(total_duration_five_days_before / 60).floor
	end

	def total_duration_five_days_before_in_hours
		(total_duration_five_days_before_in_minutes / 60).floor
	end

	def display_total_duration_five_days_before_minutes
		total_duration_five_days_before_in_minutes - total_duration_five_days_before_in_hours*60
	end

	def display_total_duration_five_days_before_seconds
		total_duration_five_days_before - total_duration_five_days_before_in_minutes*60
	end

	def display_total_duration_five_days_before
		"#{total_duration_five_days_before_in_hours}h#{display_total_duration_five_days_before_minutes}m#{display_total_duration_five_days_before_seconds}s"
	end

	def total_duration_six_days_before
		total_duration_six_days_before = 0
		attendances.sortie.six_days_before.each do |sortie|
			total_duration_six_days_before += duration(sortie)
		end
		total_duration_six_days_before		
	end

	def total_duration_six_days_before_in_minutes
		(total_duration_six_days_before / 60).floor
	end

	def total_duration_six_days_before_in_hours
		(total_duration_six_days_before_in_minutes / 60).floor
	end

	def display_total_duration_six_days_before_minutes
		total_duration_six_days_before_in_minutes - total_duration_six_days_before_in_hours*60
	end

	def display_total_duration_six_days_before_seconds
		total_duration_six_days_before - total_duration_six_days_before_in_minutes*60
	end

	def display_total_duration_six_days_before
		"#{total_duration_six_days_before_in_hours}h#{display_total_duration_six_days_before_minutes}m#{display_total_duration_six_days_before_seconds}s"
	end

	def total_duration_seven_days_before
		total_duration_seven_days_before = 0
		attendances.sortie.seven_days_before.each do |sortie|
			total_duration_seven_days_before += duration(sortie)
		end
		total_duration_seven_days_before		
	end

	def total_duration_seven_days_before_in_minutes
		(total_duration_seven_days_before / 60).floor
	end

	def total_duration_seven_days_before_in_hours
		(total_duration_seven_days_before_in_minutes / 60).floor
	end

	def display_total_duration_seven_days_before_minutes
		total_duration_seven_days_before_in_minutes - total_duration_seven_days_before_in_hours*60
	end

	def display_total_duration_seven_days_before_seconds
		total_duration_seven_days_before - total_duration_seven_days_before_in_minutes*60
	end

	def display_total_duration_seven_days_before
		"#{total_duration_seven_days_before_in_hours}h#{display_total_duration_seven_days_before_minutes}m#{display_total_duration_seven_days_before_seconds}s"
	end

	def total_duration_eight_days_before
		total_duration_eight_days_before = 0
		attendances.sortie.eight_days_before.each do |sortie|
			total_duration_eight_days_before += duration(sortie)
		end
		total_duration_eight_days_before		
	end

	def total_duration_eight_days_before_in_minutes
		(total_duration_eight_days_before / 60).floor
	end

	def total_duration_eight_days_before_in_hours
		(total_duration_eight_days_before_in_minutes / 60).floor
	end

	def display_total_duration_eight_days_before_minutes
		total_duration_eight_days_before_in_minutes - total_duration_eight_days_before_in_hours*60
	end

	def display_total_duration_eight_days_before_seconds
		total_duration_eight_days_before - total_duration_eight_days_before_in_minutes*60
	end

	def display_total_duration_eight_days_before
		"#{total_duration_eight_days_before_in_hours}h#{display_total_duration_eight_days_before_minutes}m#{display_total_duration_eight_days_before_seconds}s"
	end

	def total_duration_nine_days_before
		total_duration_nine_days_before = 0
		attendances.sortie.nine_days_before.each do |sortie|
			total_duration_nine_days_before += duration(sortie)
		end
		total_duration_nine_days_before		
	end

	def total_duration_nine_days_before_in_minutes
		(total_duration_nine_days_before / 60).floor
	end

	def total_duration_nine_days_before_in_hours
		(total_duration_nine_days_before_in_minutes / 60).floor
	end

	def display_total_duration_nine_days_before_minutes
		total_duration_nine_days_before_in_minutes - total_duration_nine_days_before_in_hours*60
	end

	def display_total_duration_nine_days_before_seconds
		total_duration_nine_days_before - total_duration_nine_days_before_in_minutes*60
	end

	def display_total_duration_nine_days_before
		"#{total_duration_nine_days_before_in_hours}h#{display_total_duration_nine_days_before_minutes}m#{display_total_duration_nine_days_before_seconds}s"
	end

	def total_duration_ten_days_before
		total_duration_ten_days_before = 0
		attendances.sortie.ten_days_before.each do |sortie|
			total_duration_ten_days_before += duration(sortie)
		end
		total_duration_ten_days_before		
	end

	def total_duration_ten_days_before_in_minutes
		(total_duration_ten_days_before / 60).floor
	end

	def total_duration_ten_days_before_in_hours
		(total_duration_ten_days_before_in_minutes / 60).floor
	end

	def display_total_duration_ten_days_before_minutes
		total_duration_ten_days_before_in_minutes - total_duration_ten_days_before_in_hours*60
	end

	def display_total_duration_ten_days_before_seconds
		total_duration_ten_days_before - total_duration_ten_days_before_in_minutes*60
	end

	def display_total_duration_ten_days_before
		"#{total_duration_ten_days_before_in_hours}h#{display_total_duration_ten_days_before_minutes}m#{display_total_duration_ten_days_before_seconds}s"
	end

	def total_duration_eleven_days_before
		total_duration_eleven_days_before = 0
		attendances.sortie.eleven_days_before.each do |sortie|
			total_duration_eleven_days_before += duration(sortie)
		end
		total_duration_eleven_days_before		
	end

	def total_duration_eleven_days_before_in_minutes
		(total_duration_eleven_days_before / 60).floor
	end

	def total_duration_eleven_days_before_in_hours
		(total_duration_eleven_days_before_in_minutes / 60).floor
	end

	def display_total_duration_eleven_days_before_minutes
		total_duration_eleven_days_before_in_minutes - total_duration_eleven_days_before_in_hours*60
	end

	def display_total_duration_eleven_days_before_seconds
		total_duration_eleven_days_before - total_duration_eleven_days_before_in_minutes*60
	end

	def display_total_duration_eleven_days_before
		"#{total_duration_eleven_days_before_in_hours}h#{display_total_duration_eleven_days_before_minutes}m#{display_total_duration_eleven_days_before_seconds}s"
	end

	def total_duration_twelve_days_before
		total_duration_twelve_days_before = 0
		attendances.sortie.twelve_days_before.each do |sortie|
			total_duration_twelve_days_before += duration(sortie)
		end
		total_duration_twelve_days_before		
	end

	def total_duration_twelve_days_before_in_minutes
		(total_duration_twelve_days_before / 60).floor
	end

	def total_duration_twelve_days_before_in_hours
		(total_duration_twelve_days_before_in_minutes / 60).floor
	end

	def display_total_duration_twelve_days_before_minutes
		total_duration_twelve_days_before_in_minutes - total_duration_twelve_days_before_in_hours*60
	end

	def display_total_duration_twelve_days_before_seconds
		total_duration_twelve_days_before - total_duration_twelve_days_before_in_minutes*60
	end

	def display_total_duration_twelve_days_before
		"#{total_duration_twelve_days_before_in_hours}h#{display_total_duration_twelve_days_before_minutes}m#{display_total_duration_twelve_days_before_seconds}s"
	end

	def total_duration_thirteen_days_before
		total_duration_thirteen_days_before = 0
		attendances.sortie.thirteen_days_before.each do |sortie|
			total_duration_thirteen_days_before += duration(sortie)
		end
		total_duration_thirteen_days_before		
	end

	def total_duration_thirteen_days_before_in_minutes
		(total_duration_thirteen_days_before / 60).floor
	end

	def total_duration_thirteen_days_before_in_hours
		(total_duration_thirteen_days_before_in_minutes / 60).floor
	end

	def display_total_duration_thirteen_days_before_minutes
		total_duration_thirteen_days_before_in_minutes - total_duration_thirteen_days_before_in_hours*60
	end

	def display_total_duration_thirteen_days_before_seconds
		total_duration_thirteen_days_before - total_duration_thirteen_days_before_in_minutes*60
	end

	def display_total_duration_thirteen_days_before
		"#{total_duration_thirteen_days_before_in_hours}h#{display_total_duration_thirteen_days_before_minutes}m#{display_total_duration_thirteen_days_before_seconds}s"
	end

	def total_duration_fourteen_days_before
		total_duration_fourteen_days_before = 0
		attendances.sortie.fourteen_days_before.each do |sortie|
			total_duration_fourteen_days_before += duration(sortie)
		end
		total_duration_fourteen_days_before		
	end

	def total_duration_fourteen_days_before_in_minutes
		(total_duration_fourteen_days_before / 60).floor
	end

	def total_duration_fourteen_days_before_in_hours
		(total_duration_fourteen_days_before_in_minutes / 60).floor
	end

	def display_total_duration_fourteen_days_before_minutes
		total_duration_fourteen_days_before_in_minutes - total_duration_fourteen_days_before_in_hours*60
	end

	def display_total_duration_fourteen_days_before_seconds
		total_duration_fourteen_days_before - total_duration_fourteen_days_before_in_minutes*60
	end

	def display_total_duration_fourteen_days_before
		"#{total_duration_fourteen_days_before_in_hours}h#{display_total_duration_fourteen_days_before_minutes}m#{display_total_duration_fourteen_days_before_seconds}s"
	end

end
