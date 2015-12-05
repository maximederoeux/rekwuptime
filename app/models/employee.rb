class Employee < ActiveRecord::Base
	has_many :attendances
	



    def full_name
    	"#{first_name} #{name}"
    end

    def full_name_with_id
    	"##{id} - #{full_name}"
  	end
   
	def entrees
		self.attendances.entree.order('created_at DESC')		
	end

	def sorties
		self.attendances.sortie
	end	

	def last_move_content
		if self.attendances.last
			if self.attendances.last.content == "entree"
				"Dernière entrée"
			elsif self.attendances.last.content == "sortie"
				"Dernière sortie"
			end
		else
		"blabla"
		end
	end

	def last_move_time
		if self.attendances.last
			self.attendances.last.created_at
		else
		"blabla"
		end
	end

	def last_move_day
		if self.attendances.last
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
		else
		"blibli"
		end
			
	end

	
# NEXT 500 LINES FOR CALCULATION OF DURATIONS

	def previous_entree(attendance)
		# entree of an employee before a sortie used for calculation of duration

		if attendance.sortie
			self.attendances.entree.where("created_at < ?", attendance.created_at).last
		end
	end

	def next_sortie(attendance)
		# sortie of an employee after an entree used for calculation of duration based on the entree

		if attendance.entree
			self.attendances.sortie.where("created_at > ?", attendance.created_at).first
		end
	end


# CALCULATION AND DISPLAY OF DURATION FOR ONE MOVE OF AN EMPLOYEE BASED ON SORTIES

	def duration(attendance)
		# duration between two moves based on the sortie

		if attendance.sortie
			(attendance.created_at - previous_entree(attendance).created_at).floor
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

	def duration_entree_this_day 
  		duration_entree_this_day = 0
		attendances.entree.this_day.each do |entree|
			if next_sortie(entree)
			duration_entree_this_day += duration_entree(entree)
			end
		end
		duration_entree_this_day	
  	end

	def duration_entree_this_day_in_minutes
		(duration_entree_this_day / 60).floor
	end

	def duration_entree_this_day_in_hours
		(duration_entree_this_day_in_minutes / 60).floor
	end


	def display_duration_entree_this_day_minutes		
		duration_entree_this_day_in_minutes - duration_entree_this_day_in_hours*60		
	end

	def display_duration_entree_this_day_seconds
		duration_entree_this_day - duration_entree_this_day_in_minutes*60
	end

	def display_duration_entree_this_day # OK
		"#{duration_entree_this_day_in_hours}h#{display_duration_entree_this_day_minutes}m#{display_duration_entree_this_day_seconds}s"
	end
		

# CALCULATION AND DISPLAY OF TOTAL DURATION FOR ALL MOVES OF AN EMPLOYEE BASED ON SORTIES

	def total_duration
		# total duration of attendance for an employee based on the entrees
		
	    total_duration = 0
	    attendances.sortie.each do |sortie|
	      total_duration += duration(sortie)
	    end
	    total_duration  	def duration_entree_this_day 
  		duration_entree_this_day = 0
		attendances.entree.this_day.each do |entree|
			if next_sortie(entree)
			duration_entree_this_day += duration_entree(entree)
			end
		end
		duration_entree_this_day	
  	end

	def duration_entree_this_day_in_minutes
		(duration_entree_this_day / 60).floor
	end

	def duration_entree_this_day_in_hours
		(duration_entree_this_day_in_minutes / 60).floor
	end


	def display_duration_entree_this_day_minutes		
		duration_entree_this_day_in_minutes - duration_entree_this_day_in_hours*60		
	end

	def display_duration_entree_this_day_seconds
		duration_entree_this_day - duration_entree_this_day_in_minutes*60
	end

	def display_duration_entree_this_day # OK
		"#{duration_entree_this_day_in_hours}h#{display_duration_entree_this_day_minutes}m#{display_duration_entree_this_day_seconds}s"
	end
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

# CALCULATION AND DISPLAY OF DURATION FOR ONE MOVE OF AN EMPLOYEE BASED ON SORTIES


	def duration_entree(attendance)
		# duration between two moves based on the entree

		if next_sortie(attendance)
			(next_sortie(attendance).created_at - attendance.created_at).floor
		end		
	end

	def duration_entree_in_minutes(attendance)
		if next_sortie(attendance)
			(duration_entree(attendance) / 60).floor
		end
	end

	def duration_entree_in_hours(attendance)
		if next_sortie(attendance)
		(duration_entree_in_minutes(attendance) / 60).floor
		end
	end

	def display_duration_entree_minutes(attendance)
		if next_sortie(attendance)
		duration_entree_in_minutes(attendance) - duration_entree_in_hours(attendance)*60
		end
	end

	def display_duration_entree_seconds(attendance)(attendance)
		if next_sortie(attendance)
		duration_entree(attendance) - duration_entree_in_minutes(attendance)*60
		end
	end

	def display_duration_entree(attendance)
		if next_sortie(attendance)
		"#{duration_entree_in_hours(attendance)}h#{display_duration_entree_minutes(attendance)}m#{display_duration_entree_seconds(attendance)}s"
		end
	end

	def display_duration_entree_nice(attendance) # OK
		if duration_entree_in_hours(attendance) < 10 && display_duration_entree_minutes(attendance) < 10 && display_duration_entree_seconds(attendance) < 10
			"0#{duration_entree_in_hours(attendance)}h0#{display_duration_entree_minutes(attendance)}m0#{display_duration_entree_seconds(attendance)}"
		elsif duration_entree_in_hours(attendance) < 10 && display_duration_entree_minutes(attendance) < 10 && display_duration_entree_seconds(attendance) > 9
			"0#{duration_entree_in_hours(attendance)}h0#{display_duration_entree_minutes(attendance)}m#{display_duration_entree_seconds(attendance)}"
		elsif duration_entree_in_hours(attendance) < 10 && display_duration_entree_minutes(attendance) > 9 && display_duration_entree_seconds(attendance) < 10
			"0#{duration_entree_in_hours(attendance)}h#{display_duration_entree_minutes(attendance)}m0#{display_duration_entree_seconds(attendance)}"
		elsif duration_entree_in_hours(attendance) < 10 && display_duration_entree_minutes(attendance) > 9 && display_duration_entree_seconds(attendance) >	9
			"0#{duration_entree_in_hours(attendance)}h#{display_duration_entree_minutes(attendance)}m#{display_duration_entree_seconds(attendance)}"	
		elsif duration_entree_in_hours(attendance) > 9 && display_duration_entree_minutes(attendance) < 10 && display_duration_entree_seconds(attendance) < 10
			"#{duration_entree_in_hours(attendance)}h0#{display_duration_entree_minutes(attendance)}m0#{display_duration_entree_seconds(attendance)}"
		elsif duration_entree_in_hours(attendance) > 9 && display_duration_entree_minutes(attendance) < 10 && display_duration_entree_seconds(attendance) > 9
			"#{duration_entree_in_hours(attendance)}h0#{display_duration_entree_minutes(attendance)}m#{display_duration_entree_seconds(attendance)}"	
		elsif duration_entree_in_hours(attendance) > 9 && display_duration_entree_minutes(attendance) > 9 && display_duration_entree_seconds(attendance) < 10
			"#{duration_entree_in_hours(attendance)}h#{display_duration_entree_minutes(attendance)}m0#{display_duration_entree_seconds(attendance)}"
		elsif duration_entree_in_hours(attendance) > 9 && display_duration_entree_minutes(attendance) > 9 && display_duration_entree_seconds(attendance) > 9
			"#{duration_entree_in_hours(attendance)}h#{display_duration_entree_minutes(attendance)}m#{display_duration_entree_seconds(attendance)}"	
		end
	end



	def total_duration_entree
		# total duration of attendance for an employee based on the entrees

	    total_duration_entree = 0
	    attendances.entree.each do |entree|
	    total_duration_entree += duration_entree(entree)
	    end
	    total_duration_entree
  	end

# CALCULATION OF DURATION PER DAY FROM TODAY TILL TWO WEEKS AGO

  	def duration_entree_this_day 
  		duration_entree_this_day = 0
		attendances.entree.this_day.each do |entree|
			if next_sortie(entree)
			duration_entree_this_day += duration_entree(entree)
			end
		end
		duration_entree_this_day	
  	end

	def duration_entree_this_day_in_minutes
		(duration_entree_this_day / 60).floor
	end

	def duration_entree_this_day_in_hours
		(duration_entree_this_day_in_minutes / 60).floor
	end

	def display_duration_entree_this_day_minutes		
		duration_entree_this_day_in_minutes - duration_entree_this_day_in_hours*60		
	end

	def display_duration_entree_this_day_seconds
		duration_entree_this_day - duration_entree_this_day_in_minutes*60
	end

	def display_duration_entree_this_day # OK
		if duration_entree_this_day_in_hours < 10 && display_duration_entree_this_day_minutes < 10
			"0#{duration_entree_this_day_in_hours}h0#{display_duration_entree_this_day_minutes}m"
		elsif duration_entree_this_day_in_hours < 10 && display_duration_entree_this_day_minutes > 9
			"0#{duration_entree_this_day_in_hours}h#{display_duration_entree_this_day_minutes}m"
		elsif duration_entree_this_day_in_hours > 9 && display_duration_entree_this_day_minutes < 10
			"#{duration_entree_this_day_in_hours}h0#{display_duration_entree_this_day_minutes}m"
		elsif duration_entree_this_day_in_hours > 9 && display_duration_entree_this_day_minutes > 9
			"#{duration_entree_this_day_in_hours}h#{display_duration_entree_this_day_minutes}m"	
		end
	end

  	def duration_entree_one_day_before 
  		duration_entree_one_day_before = 0
		attendances.entree.one_day_before.each do |entree|
			if next_sortie(entree)
			duration_entree_one_day_before += duration_entree(entree)
			end
		end
		duration_entree_one_day_before	
  	end

	def duration_entree_one_day_before_in_minutes
		(duration_entree_one_day_before / 60).floor
	end

	def duration_entree_one_day_before_in_hours
		(duration_entree_one_day_before_in_minutes / 60).floor
	end

	def display_duration_entree_one_day_before_minutes		
		duration_entree_one_day_before_in_minutes - duration_entree_one_day_before_in_hours*60		
	end

	def display_duration_entree_one_day_before_seconds
		duration_entree_one_day_before - duration_entree_one_day_before_in_minutes*60
	end

	def display_duration_entree_one_day_before # OK
		if duration_entree_one_day_before_in_hours < 10 && display_duration_entree_one_day_before_minutes < 10
			"0#{duration_entree_one_day_before_in_hours}h0#{display_duration_entree_one_day_before_minutes}m"
		elsif duration_entree_one_day_before_in_hours < 10 && display_duration_entree_one_day_before_minutes > 9
			"0#{duration_entree_one_day_before_in_hours}h#{display_duration_entree_one_day_before_minutes}m"
		elsif duration_entree_one_day_before_in_hours > 9 && display_duration_entree_one_day_before_minutes < 10
			"#{duration_entree_one_day_before_in_hours}h0#{display_duration_entree_one_day_before_minutes}m"
		elsif duration_entree_one_day_before_in_hours > 9 && display_duration_entree_one_day_before_minutes > 9
			"#{duration_entree_one_day_before_in_hours}h#{display_duration_entree_one_day_before_minutes}m"	
		end
	end

  	def duration_entree_two_days_before 
  		duration_entree_two_days_before = 0
		attendances.entree.two_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_two_days_before += duration_entree(entree)
			end
		end
		duration_entree_two_days_before	
  	end

	def duration_entree_two_days_before_in_minutes
		(duration_entree_two_days_before / 60).floor
	end

	def duration_entree_two_days_before_in_hours
		(duration_entree_two_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_two_days_before_minutes		
		duration_entree_two_days_before_in_minutes - duration_entree_two_days_before_in_hours*60		
	end

	def display_duration_entree_two_days_before_seconds
		duration_entree_two_days_before - duration_entree_two_days_before_in_minutes*60
	end

	def display_duration_entree_two_days_before # OK
		if duration_entree_two_days_before_in_hours < 10 && display_duration_entree_two_days_before_minutes < 10
			"0#{duration_entree_two_days_before_in_hours}h0#{display_duration_entree_two_days_before_minutes}m"
		elsif duration_entree_two_days_before_in_hours < 10 && display_duration_entree_two_days_before_minutes > 9
			"0#{duration_entree_two_days_before_in_hours}h#{display_duration_entree_two_days_before_minutes}m"
		elsif duration_entree_two_days_before_in_hours > 9 && display_duration_entree_two_days_before_minutes < 10
			"#{duration_entree_two_days_before_in_hours}h0#{display_duration_entree_two_days_before_minutes}m"
		elsif duration_entree_two_days_before_in_hours > 9 && display_duration_entree_two_days_before_minutes > 9
			"#{duration_entree_two_days_before_in_hours}h#{display_duration_entree_two_days_before_minutes}m"	
		end
	end

  	def duration_entree_three_days_before 
  		duration_entree_three_days_before = 0
		attendances.entree.three_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_three_days_before += duration_entree(entree)
			end
		end
		duration_entree_three_days_before	
  	end

	def duration_entree_three_days_before_in_minutes
		(duration_entree_three_days_before / 60).floor
	end

	def duration_entree_three_days_before_in_hours
		(duration_entree_three_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_three_days_before_minutes		
		duration_entree_three_days_before_in_minutes - duration_entree_three_days_before_in_hours*60		
	end

	def display_duration_entree_three_days_before_seconds
		duration_entree_three_days_before - duration_entree_three_days_before_in_minutes*60
	end

	def display_duration_entree_three_days_before # OK
		if duration_entree_three_days_before_in_hours < 10 && display_duration_entree_three_days_before_minutes < 10
			"0#{duration_entree_three_days_before_in_hours}h0#{display_duration_entree_three_days_before_minutes}m"
		elsif duration_entree_three_days_before_in_hours < 10 && display_duration_entree_three_days_before_minutes > 9
			"0#{duration_entree_three_days_before_in_hours}h#{display_duration_entree_three_days_before_minutes}m"
		elsif duration_entree_three_days_before_in_hours > 9 && display_duration_entree_three_days_before_minutes < 10
			"#{duration_entree_three_days_before_in_hours}h0#{display_duration_entree_three_days_before_minutes}m"
		elsif duration_entree_three_days_before_in_hours > 9 && display_duration_entree_three_days_before_minutes > 9
			"#{duration_entree_three_days_before_in_hours}h#{display_duration_entree_three_days_before_minutes}m"	
		end
	end

  	def duration_entree_four_days_before 
  		duration_entree_four_days_before = 0
		attendances.entree.four_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_four_days_before += duration_entree(entree)
			end
		end
		duration_entree_four_days_before	
  	end

	def duration_entree_four_days_before_in_minutes
		(duration_entree_four_days_before / 60).floor
	end

	def duration_entree_four_days_before_in_hours
		(duration_entree_four_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_four_days_before_minutes		
		duration_entree_four_days_before_in_minutes - duration_entree_four_days_before_in_hours*60		
	end

	def display_duration_entree_four_days_before_seconds
		duration_entree_four_days_before - duration_entree_four_days_before_in_minutes*60
	end

	def display_duration_entree_four_days_before # OK
		if duration_entree_four_days_before_in_hours < 10 && display_duration_entree_four_days_before_minutes < 10
			"0#{duration_entree_four_days_before_in_hours}h0#{display_duration_entree_four_days_before_minutes}m"
		elsif duration_entree_four_days_before_in_hours < 10 && display_duration_entree_four_days_before_minutes > 9
			"0#{duration_entree_four_days_before_in_hours}h#{display_duration_entree_four_days_before_minutes}m"
		elsif duration_entree_four_days_before_in_hours > 9 && display_duration_entree_four_days_before_minutes < 10
			"#{duration_entree_four_days_before_in_hours}h0#{display_duration_entree_four_days_before_minutes}m"
		elsif duration_entree_four_days_before_in_hours > 9 && display_duration_entree_four_days_before_minutes > 9
			"#{duration_entree_four_days_before_in_hours}h#{display_duration_entree_four_days_before_minutes}m"	
		end
	end

  	def duration_entree_five_days_before 
  		duration_entree_five_days_before = 0
		attendances.entree.five_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_five_days_before += duration_entree(entree)
			end
		end
		duration_entree_five_days_before	
  	end

	def duration_entree_five_days_before_in_minutes
		(duration_entree_five_days_before / 60).floor
	end

	def duration_entree_five_days_before_in_hours
		(duration_entree_five_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_five_days_before_minutes		
		duration_entree_five_days_before_in_minutes - duration_entree_five_days_before_in_hours*60		
	end

	def display_duration_entree_five_days_before_seconds
		duration_entree_five_days_before - duration_entree_five_days_before_in_minutes*60
	end

	def display_duration_entree_five_days_before # OK
		if duration_entree_five_days_before_in_hours < 10 && display_duration_entree_five_days_before_minutes < 10
			"0#{duration_entree_five_days_before_in_hours}h0#{display_duration_entree_five_days_before_minutes}m"
		elsif duration_entree_five_days_before_in_hours < 10 && display_duration_entree_five_days_before_minutes > 9
			"0#{duration_entree_five_days_before_in_hours}h#{display_duration_entree_five_days_before_minutes}m"
		elsif duration_entree_five_days_before_in_hours > 9 && display_duration_entree_five_days_before_minutes < 10
			"#{duration_entree_five_days_before_in_hours}h0#{display_duration_entree_five_days_before_minutes}m"
		elsif duration_entree_five_days_before_in_hours > 9 && display_duration_entree_five_days_before_minutes > 9
			"#{duration_entree_five_days_before_in_hours}h#{display_duration_entree_five_days_before_minutes}m"	
		end
	end

  	def duration_entree_six_days_before 
  		duration_entree_six_days_before = 0
		attendances.entree.six_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_six_days_before += duration_entree(entree)
			end
		end
		duration_entree_six_days_before	
  	end

	def duration_entree_six_days_before_in_minutes
		(duration_entree_six_days_before / 60).floor
	end

	def duration_entree_six_days_before_in_hours
		(duration_entree_six_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_six_days_before_minutes		
		duration_entree_six_days_before_in_minutes - duration_entree_six_days_before_in_hours*60		
	end

	def display_duration_entree_six_days_before_seconds
		duration_entree_six_days_before - duration_entree_six_days_before_in_minutes*60
	end

	def display_duration_entree_six_days_before # OK
		if duration_entree_six_days_before_in_hours < 10 && display_duration_entree_six_days_before_minutes < 10
			"0#{duration_entree_six_days_before_in_hours}h0#{display_duration_entree_six_days_before_minutes}m"
		elsif duration_entree_six_days_before_in_hours < 10 && display_duration_entree_six_days_before_minutes > 9
			"0#{duration_entree_six_days_before_in_hours}h#{display_duration_entree_six_days_before_minutes}m"
		elsif duration_entree_six_days_before_in_hours > 9 && display_duration_entree_six_days_before_minutes < 10
			"#{duration_entree_six_days_before_in_hours}h0#{display_duration_entree_six_days_before_minutes}m"
		elsif duration_entree_six_days_before_in_hours > 9 && display_duration_entree_six_days_before_minutes > 9
			"#{duration_entree_six_days_before_in_hours}h#{display_duration_entree_six_days_before_minutes}m"	
		end
	end

  	def duration_entree_seven_days_before 
  		duration_entree_seven_days_before = 0
		attendances.entree.seven_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_seven_days_before += duration_entree(entree)
			end
		end
		duration_entree_seven_days_before	
  	end

	def duration_entree_seven_days_before_in_minutes
		(duration_entree_seven_days_before / 60).floor
	end

	def duration_entree_seven_days_before_in_hours
		(duration_entree_seven_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_seven_days_before_minutes		
		duration_entree_seven_days_before_in_minutes - duration_entree_seven_days_before_in_hours*60		
	end

	def display_duration_entree_seven_days_before_seconds
		duration_entree_seven_days_before - duration_entree_seven_days_before_in_minutes*60
	end

	def display_duration_entree_seven_days_before # OK
		if duration_entree_seven_days_before_in_hours < 10 && display_duration_entree_seven_days_before_minutes < 10
			"0#{duration_entree_seven_days_before_in_hours}h0#{display_duration_entree_seven_days_before_minutes}m"
		elsif duration_entree_seven_days_before_in_hours < 10 && display_duration_entree_seven_days_before_minutes > 9
			"0#{duration_entree_seven_days_before_in_hours}h#{display_duration_entree_seven_days_before_minutes}m"
		elsif duration_entree_seven_days_before_in_hours > 9 && display_duration_entree_seven_days_before_minutes < 10
			"#{duration_entree_seven_days_before_in_hours}h0#{display_duration_entree_seven_days_before_minutes}m"
		elsif duration_entree_seven_days_before_in_hours > 9 && display_duration_entree_seven_days_before_minutes > 9
			"#{duration_entree_seven_days_before_in_hours}h#{display_duration_entree_seven_days_before_minutes}m"	
		end
	end

  	def duration_entree_eight_days_before 
  		duration_entree_eight_days_before = 0
		attendances.entree.eight_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_eight_days_before += duration_entree(entree)
			end
		end
		duration_entree_eight_days_before	
  	end

	def duration_entree_eight_days_before_in_minutes
		(duration_entree_eight_days_before / 60).floor
	end

	def duration_entree_eight_days_before_in_hours
		(duration_entree_eight_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_eight_days_before_minutes		
		duration_entree_eight_days_before_in_minutes - duration_entree_eight_days_before_in_hours*60		
	end

	def display_duration_entree_eight_days_before_seconds
		duration_entree_eight_days_before - duration_entree_eight_days_before_in_minutes*60
	end

	def display_duration_entree_eight_days_before # OK
		if duration_entree_eight_days_before_in_hours < 10 && display_duration_entree_eight_days_before_minutes < 10
			"0#{duration_entree_eight_days_before_in_hours}h0#{display_duration_entree_eight_days_before_minutes}m"
		elsif duration_entree_eight_days_before_in_hours < 10 && display_duration_entree_eight_days_before_minutes > 9
			"0#{duration_entree_eight_days_before_in_hours}h#{display_duration_entree_eight_days_before_minutes}m"
		elsif duration_entree_eight_days_before_in_hours > 9 && display_duration_entree_eight_days_before_minutes < 10
			"#{duration_entree_eight_days_before_in_hours}h0#{display_duration_entree_eight_days_before_minutes}m"
		elsif duration_entree_eight_days_before_in_hours > 9 && display_duration_entree_eight_days_before_minutes > 9
			"#{duration_entree_eight_days_before_in_hours}h#{display_duration_entree_eight_days_before_minutes}m"	
		end
	end

  	def duration_entree_nine_days_before 
  		duration_entree_nine_days_before = 0
		attendances.entree.nine_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_nine_days_before += duration_entree(entree)
			end
		end
		duration_entree_nine_days_before	
  	end

	def duration_entree_nine_days_before_in_minutes
		(duration_entree_nine_days_before / 60).floor
	end

	def duration_entree_nine_days_before_in_hours
		(duration_entree_nine_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_nine_days_before_minutes		
		duration_entree_nine_days_before_in_minutes - duration_entree_nine_days_before_in_hours*60		
	end

	def display_duration_entree_nine_days_before_seconds
		duration_entree_nine_days_before - duration_entree_nine_days_before_in_minutes*60
	end

	def display_duration_entree_nine_days_before # OK
		if duration_entree_nine_days_before_in_hours < 10 && display_duration_entree_nine_days_before_minutes < 10
			"0#{duration_entree_nine_days_before_in_hours}h0#{display_duration_entree_nine_days_before_minutes}m"
		elsif duration_entree_nine_days_before_in_hours < 10 && display_duration_entree_nine_days_before_minutes > 9
			"0#{duration_entree_nine_days_before_in_hours}h#{display_duration_entree_nine_days_before_minutes}m"
		elsif duration_entree_nine_days_before_in_hours > 9 && display_duration_entree_nine_days_before_minutes < 10
			"#{duration_entree_nine_days_before_in_hours}h0#{display_duration_entree_nine_days_before_minutes}m"
		elsif duration_entree_nine_days_before_in_hours > 9 && display_duration_entree_nine_days_before_minutes > 9
			"#{duration_entree_nine_days_before_in_hours}h#{display_duration_entree_nine_days_before_minutes}m"	
		end
	end

  	def duration_entree_ten_days_before 
  		duration_entree_ten_days_before = 0
		attendances.entree.ten_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_ten_days_before += duration_entree(entree)
			end
		end
		duration_entree_ten_days_before	
  	end

	def duration_entree_ten_days_before_in_minutes
		(duration_entree_ten_days_before / 60).floor
	end

	def duration_entree_ten_days_before_in_hours
		(duration_entree_ten_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_ten_days_before_minutes		
		duration_entree_ten_days_before_in_minutes - duration_entree_ten_days_before_in_hours*60		
	end

	def display_duration_entree_ten_days_before_seconds
		duration_entree_ten_days_before - duration_entree_ten_days_before_in_minutes*60
	end

	def display_duration_entree_ten_days_before # OK
		if duration_entree_ten_days_before_in_hours < 10 && display_duration_entree_ten_days_before_minutes < 10
			"0#{duration_entree_ten_days_before_in_hours}h0#{display_duration_entree_ten_days_before_minutes}m"
		elsif duration_entree_ten_days_before_in_hours < 10 && display_duration_entree_ten_days_before_minutes > 9
			"0#{duration_entree_ten_days_before_in_hours}h#{display_duration_entree_ten_days_before_minutes}m"
		elsif duration_entree_ten_days_before_in_hours > 9 && display_duration_entree_ten_days_before_minutes < 10
			"#{duration_entree_ten_days_before_in_hours}h0#{display_duration_entree_ten_days_before_minutes}m"
		elsif duration_entree_ten_days_before_in_hours > 9 && display_duration_entree_ten_days_before_minutes > 9
			"#{duration_entree_ten_days_before_in_hours}h#{display_duration_entree_ten_days_before_minutes}m"	
		end
	end

  	def duration_entree_eleven_days_before 
  		duration_entree_eleven_days_before = 0
		attendances.entree.eleven_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_eleven_days_before += duration_entree(entree)
			end
		end
		duration_entree_eleven_days_before	
  	end

	def duration_entree_eleven_days_before_in_minutes
		(duration_entree_eleven_days_before / 60).floor
	end

	def duration_entree_eleven_days_before_in_hours
		(duration_entree_eleven_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_eleven_days_before_minutes		
		duration_entree_eleven_days_before_in_minutes - duration_entree_eleven_days_before_in_hours*60		
	end

	def display_duration_entree_eleven_days_before_seconds
		duration_entree_eleven_days_before - duration_entree_eleven_days_before_in_minutes*60
	end

	def display_duration_entree_eleven_days_before # OK
		if duration_entree_eleven_days_before_in_hours < 10 && display_duration_entree_eleven_days_before_minutes < 10
			"0#{duration_entree_eleven_days_before_in_hours}h0#{display_duration_entree_eleven_days_before_minutes}m"
		elsif duration_entree_eleven_days_before_in_hours < 10 && display_duration_entree_eleven_days_before_minutes > 9
			"0#{duration_entree_eleven_days_before_in_hours}h#{display_duration_entree_eleven_days_before_minutes}m"
		elsif duration_entree_eleven_days_before_in_hours > 9 && display_duration_entree_eleven_days_before_minutes < 10
			"#{duration_entree_eleven_days_before_in_hours}h0#{display_duration_entree_eleven_days_before_minutes}m"
		elsif duration_entree_eleven_days_before_in_hours > 9 && display_duration_entree_eleven_days_before_minutes > 9
			"#{duration_entree_eleven_days_before_in_hours}h#{display_duration_entree_eleven_days_before_minutes}m"	
		end
	end

  	def duration_entree_twelve_days_before 
  		duration_entree_twelve_days_before = 0
		attendances.entree.twelve_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_twelve_days_before += duration_entree(entree)
			end
		end
		duration_entree_twelve_days_before	
  	end

	def duration_entree_twelve_days_before_in_minutes
		(duration_entree_twelve_days_before / 60).floor
	end

	def duration_entree_twelve_days_before_in_hours
		(duration_entree_twelve_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_twelve_days_before_minutes		
		duration_entree_twelve_days_before_in_minutes - duration_entree_twelve_days_before_in_hours*60		
	end

	def display_duration_entree_twelve_days_before_seconds
		duration_entree_twelve_days_before - duration_entree_twelve_days_before_in_minutes*60
	end

	def display_duration_entree_twelve_days_before # OK
		if duration_entree_twelve_days_before_in_hours < 10 && display_duration_entree_twelve_days_before_minutes < 10
			"0#{duration_entree_twelve_days_before_in_hours}h0#{display_duration_entree_twelve_days_before_minutes}m"
		elsif duration_entree_twelve_days_before_in_hours < 10 && display_duration_entree_twelve_days_before_minutes > 9
			"0#{duration_entree_twelve_days_before_in_hours}h#{display_duration_entree_twelve_days_before_minutes}m"
		elsif duration_entree_twelve_days_before_in_hours > 9 && display_duration_entree_twelve_days_before_minutes < 10
			"#{duration_entree_twelve_days_before_in_hours}h0#{display_duration_entree_twelve_days_before_minutes}m"
		elsif duration_entree_twelve_days_before_in_hours > 9 && display_duration_entree_twelve_days_before_minutes > 9
			"#{duration_entree_twelve_days_before_in_hours}h#{display_duration_entree_twelve_days_before_minutes}m"	
		end
	end

  	def duration_entree_thirteen_days_before 
  		duration_entree_thirteen_days_before = 0
		attendances.entree.thirteen_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_thirteen_days_before += duration_entree(entree)
			end
		end
		duration_entree_thirteen_days_before	
  	end

	def duration_entree_thirteen_days_before_in_minutes
		(duration_entree_thirteen_days_before / 60).floor
	end

	def duration_entree_thirteen_days_before_in_hours
		(duration_entree_thirteen_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_thirteen_days_before_minutes		
		duration_entree_thirteen_days_before_in_minutes - duration_entree_thirteen_days_before_in_hours*60		
	end

	def display_duration_entree_thirteen_days_before_seconds
		duration_entree_thirteen_days_before - duration_entree_thirteen_days_before_in_minutes*60
	end

	def display_duration_entree_thirteen_days_before # OK
		if duration_entree_thirteen_days_before_in_hours < 10 && display_duration_entree_thirteen_days_before_minutes < 10
			"0#{duration_entree_thirteen_days_before_in_hours}h0#{display_duration_entree_thirteen_days_before_minutes}m"
		elsif duration_entree_thirteen_days_before_in_hours < 10 && display_duration_entree_thirteen_days_before_minutes > 9
			"0#{duration_entree_thirteen_days_before_in_hours}h#{display_duration_entree_thirteen_days_before_minutes}m"
		elsif duration_entree_thirteen_days_before_in_hours > 9 && display_duration_entree_thirteen_days_before_minutes < 10
			"#{duration_entree_thirteen_days_before_in_hours}h0#{display_duration_entree_thirteen_days_before_minutes}m"
		elsif duration_entree_thirteen_days_before_in_hours > 9 && display_duration_entree_thirteen_days_before_minutes > 9
			"#{duration_entree_thirteen_days_before_in_hours}h#{display_duration_entree_thirteen_days_before_minutes}m"	
		end
	end

  	def duration_entree_fourteen_days_before 
  		duration_entree_fourteen_days_before = 0
		attendances.entree.fourteen_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_fourteen_days_before += duration_entree(entree)
			end
		end
		duration_entree_fourteen_days_before	
  	end

	def duration_entree_fourteen_days_before_in_minutes
		(duration_entree_fourteen_days_before / 60).floor
	end

	def duration_entree_fourteen_days_before_in_hours
		(duration_entree_fourteen_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_fourteen_days_before_minutes		
		duration_entree_fourteen_days_before_in_minutes - duration_entree_fourteen_days_before_in_hours*60		
	end

	def display_duration_entree_fourteen_days_before_seconds
		duration_entree_fourteen_days_before - duration_entree_fourteen_days_before_in_minutes*60
	end

	def display_duration_entree_fourteen_days_before # OK
		if duration_entree_fourteen_days_before_in_hours < 10 && display_duration_entree_fourteen_days_before_minutes < 10
			"0#{duration_entree_fourteen_days_before_in_hours}h0#{display_duration_entree_fourteen_days_before_minutes}m"
		elsif duration_entree_fourteen_days_before_in_hours < 10 && display_duration_entree_fourteen_days_before_minutes > 9
			"0#{duration_entree_fourteen_days_before_in_hours}h#{display_duration_entree_fourteen_days_before_minutes}m"
		elsif duration_entree_fourteen_days_before_in_hours > 9 && display_duration_entree_fourteen_days_before_minutes < 10
			"#{duration_entree_fourteen_days_before_in_hours}h0#{display_duration_entree_fourteen_days_before_minutes}m"
		elsif duration_entree_fourteen_days_before_in_hours > 9 && display_duration_entree_fourteen_days_before_minutes > 9
			"#{duration_entree_fourteen_days_before_in_hours}h#{display_duration_entree_fourteen_days_before_minutes}m"	
		end
	end

  	def duration_entree_fifteen_days_before 
  		duration_entree_fifteen_days_before = 0
		attendances.entree.fifteen_days_before.each do |entree|
			if next_sortie(entree)
			duration_entree_fifteen_days_before += duration_entree(entree)
			end
		end
		duration_entree_fifteen_days_before	
  	end

	def duration_entree_fifteen_days_before_in_minutes
		(duration_entree_fifteen_days_before / 60).floor
	end

	def duration_entree_fifteen_days_before_in_hours
		(duration_entree_fifteen_days_before_in_minutes / 60).floor
	end

	def display_duration_entree_fifteen_days_before_minutes		
		duration_entree_fifteen_days_before_in_minutes - duration_entree_fifteen_days_before_in_hours*60		
	end

	def display_duration_entree_fifteen_days_before_seconds
		duration_entree_fifteen_days_before - duration_entree_fifteen_days_before_in_minutes*60
	end

	def display_duration_entree_fifteen_days_before # OK
		if duration_entree_fifteen_days_before_in_hours < 10 && display_duration_entree_fifteen_days_before_minutes < 10
			"0#{duration_entree_fifteen_days_before_in_hours}h0#{display_duration_entree_fifteen_days_before_minutes}m"
		elsif duration_entree_fifteen_days_before_in_hours < 10 && display_duration_entree_fifteen_days_before_minutes > 9
			"0#{duration_entree_fifteen_days_before_in_hours}h#{display_duration_entree_fifteen_days_before_minutes}m"
		elsif duration_entree_fifteen_days_before_in_hours > 9 && display_duration_entree_fifteen_days_before_minutes < 10
			"#{duration_entree_fifteen_days_before_in_hours}h0#{display_duration_entree_fifteen_days_before_minutes}m"
		elsif duration_entree_fifteen_days_before_in_hours > 9 && display_duration_entree_fifteen_days_before_minutes > 9
			"#{duration_entree_fifteen_days_before_in_hours}h#{display_duration_entree_fifteen_days_before_minutes}m"	
		end
	end

  	def duration_entree_last_monday 
  		duration_entree_last_monday = 0
		attendances.entree.last_monday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_monday += duration_entree(entree)
			end
		end
		duration_entree_last_monday	
  	end

	def duration_entree_last_monday_in_minutes
		(duration_entree_last_monday / 60).floor
	end

	def duration_entree_last_monday_in_hours
		(duration_entree_last_monday_in_minutes / 60).floor
	end

	def display_duration_entree_last_monday_minutes		
		duration_entree_last_monday_in_minutes - duration_entree_last_monday_in_hours*60		
	end

	def display_duration_entree_last_monday_seconds
		duration_entree_last_monday - duration_entree_last_monday_in_minutes*60
	end

	def display_duration_entree_last_monday # OK
		if duration_entree_last_monday_in_hours < 10 && display_duration_entree_last_monday_minutes < 10
			"0#{duration_entree_last_monday_in_hours}h0#{display_duration_entree_last_monday_minutes}m"
		elsif duration_entree_last_monday_in_hours < 10 && display_duration_entree_last_monday_minutes > 9
			"0#{duration_entree_last_monday_in_hours}h#{display_duration_entree_last_monday_minutes}m"
		elsif duration_entree_last_monday_in_hours > 9 && display_duration_entree_last_monday_minutes < 10
			"#{duration_entree_last_monday_in_hours}h0#{display_duration_entree_last_monday_minutes}m"
		elsif duration_entree_last_monday_in_hours > 9 && display_duration_entree_last_monday_minutes > 9
			"#{duration_entree_last_monday_in_hours}h#{display_duration_entree_last_monday_minutes}m"	
		end
	end

  	def duration_entree_last_tuesday 
  		duration_entree_last_tuesday = 0
		attendances.entree.last_tuesday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_tuesday += duration_entree(entree)
			end
		end
		duration_entree_last_tuesday	
  	end

	def duration_entree_last_tuesday_in_minutes
		(duration_entree_last_tuesday / 60).floor
	end

	def duration_entree_last_tuesday_in_hours
		(duration_entree_last_tuesday_in_minutes / 60).floor
	end

	def display_duration_entree_last_tuesday_minutes		
		duration_entree_last_tuesday_in_minutes - duration_entree_last_tuesday_in_hours*60		
	end

	def display_duration_entree_last_tuesday_seconds
		duration_entree_last_tuesday - duration_entree_last_tuesday_in_minutes*60
	end

	def display_duration_entree_last_tuesday # OK
		if duration_entree_last_tuesday_in_hours < 10 && display_duration_entree_last_tuesday_minutes < 10
			"0#{duration_entree_last_tuesday_in_hours}h0#{display_duration_entree_last_tuesday_minutes}m"
		elsif duration_entree_last_tuesday_in_hours < 10 && display_duration_entree_last_tuesday_minutes >= 10
			"0#{duration_entree_last_tuesday_in_hours}h#{display_duration_entree_last_tuesday_minutes}m"
		elsif duration_entree_last_tuesday_in_hours >= 10 && display_duration_entree_last_tuesday_minutes < 10
			"#{duration_entree_last_tuesday_in_hours}h0#{display_duration_entree_last_tuesday_minutes}m"
		elsif duration_entree_last_tuesday_in_hours >= 10 && display_duration_entree_last_tuesday_minutes >= 10
			"#{duration_entree_last_tuesday_in_hours}h#{display_duration_entree_last_tuesday_minutes}m"	
		end
	end

  	def duration_entree_last_wednesday 
  		duration_entree_last_wednesday = 0
		attendances.entree.last_wednesday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_wednesday += duration_entree(entree)
			end
		end
		duration_entree_last_wednesday	
  	end

	def duration_entree_last_wednesday_in_minutes
		(duration_entree_last_wednesday / 60).floor
	end

	def duration_entree_last_wednesday_in_hours
		(duration_entree_last_wednesday_in_minutes / 60).floor
	end

	def display_duration_entree_last_wednesday_minutes		
		duration_entree_last_wednesday_in_minutes - duration_entree_last_wednesday_in_hours*60		
	end

	def display_duration_entree_last_wednesday_seconds
		duration_entree_last_wednesday - duration_entree_last_wednesday_in_minutes*60
	end

	def display_duration_entree_last_wednesday # OK
		if duration_entree_last_wednesday_in_hours < 10 && display_duration_entree_last_wednesday_minutes < 10
			"0#{duration_entree_last_wednesday_in_hours}h0#{display_duration_entree_last_wednesday_minutes}m"
		elsif duration_entree_last_wednesday_in_hours < 10 && display_duration_entree_last_wednesday_minutes > 9
			"0#{duration_entree_last_wednesday_in_hours}h#{display_duration_entree_last_wednesday_minutes}m"
		elsif duration_entree_last_wednesday_in_hours > 9 && display_duration_entree_last_wednesday_minutes < 10
			"#{duration_entree_last_wednesday_in_hours}h0#{display_duration_entree_last_wednesday_minutes}m"
		elsif duration_entree_last_wednesday_in_hours > 9 && display_duration_entree_last_wednesday_minutes > 9
			"#{duration_entree_last_wednesday_in_hours}h#{display_duration_entree_last_wednesday_minutes}m"	
		end
	end

  	def duration_entree_last_thursday 
  		duration_entree_last_thursday = 0
		attendances.entree.last_thursday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_thursday += duration_entree(entree)
			end
		end
		duration_entree_last_thursday	
  	end

	def duration_entree_last_thursday_in_minutes
		(duration_entree_last_thursday / 60).floor
	end

	def duration_entree_last_thursday_in_hours
		(duration_entree_last_thursday_in_minutes / 60).floor
	end

	def display_duration_entree_last_thursday_minutes		
		duration_entree_last_thursday_in_minutes - duration_entree_last_thursday_in_hours*60		
	end

	def display_duration_entree_last_thursday_seconds
		duration_entree_last_thursday - duration_entree_last_thursday_in_minutes*60
	end

	def display_duration_entree_last_thursday # OK
		if duration_entree_last_thursday_in_hours < 10 && display_duration_entree_last_thursday_minutes < 10
			"0#{duration_entree_last_thursday_in_hours}h0#{display_duration_entree_last_thursday_minutes}m"
		elsif duration_entree_last_thursday_in_hours < 10 && display_duration_entree_last_thursday_minutes > 9
			"0#{duration_entree_last_thursday_in_hours}h#{display_duration_entree_last_thursday_minutes}m"
		elsif duration_entree_last_thursday_in_hours > 9 && display_duration_entree_last_thursday_minutes < 10
			"#{duration_entree_last_thursday_in_hours}h0#{display_duration_entree_last_thursday_minutes}m"
		elsif duration_entree_last_thursday_in_hours > 9 && display_duration_entree_last_thursday_minutes > 9
			"#{duration_entree_last_thursday_in_hours}h#{display_duration_entree_last_thursday_minutes}m"	
		end
	end

  	def duration_entree_last_friday 
  		duration_entree_last_friday = 0
		attendances.entree.last_friday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_friday += duration_entree(entree)
			end
		end
		duration_entree_last_friday	
  	end

	def duration_entree_last_friday_in_minutes
		(duration_entree_last_friday / 60).floor
	end

	def duration_entree_last_friday_in_hours
		(duration_entree_last_friday_in_minutes / 60).floor
	end

	def display_duration_entree_last_friday_minutes		
		duration_entree_last_friday_in_minutes - duration_entree_last_friday_in_hours*60		
	end

	def display_duration_entree_last_friday_seconds
		duration_entree_last_friday - duration_entree_last_friday_in_minutes*60
	end

	def display_duration_entree_last_friday # OK
		if duration_entree_last_friday_in_hours < 10 && display_duration_entree_last_friday_minutes < 10
			"0#{duration_entree_last_friday_in_hours}h0#{display_duration_entree_last_friday_minutes}m"
		elsif duration_entree_last_friday_in_hours < 10 && display_duration_entree_last_friday_minutes > 9
			"0#{duration_entree_last_friday_in_hours}h#{display_duration_entree_last_friday_minutes}m"
		elsif duration_entree_last_friday_in_hours > 9 && display_duration_entree_last_friday_minutes < 10
			"#{duration_entree_last_friday_in_hours}h0#{display_duration_entree_last_friday_minutes}m"
		elsif duration_entree_last_friday_in_hours > 9 && display_duration_entree_last_friday_minutes > 9
			"#{duration_entree_last_friday_in_hours}h#{display_duration_entree_last_friday_minutes}m"	
		end
	end

  	def duration_entree_last_saturday 
  		duration_entree_last_saturday = 0
		attendances.entree.last_saturday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_saturday += duration_entree(entree)
			end
		end
		duration_entree_last_saturday	
  	end

	def duration_entree_last_saturday_in_minutes
		(duration_entree_last_saturday / 60).floor
	end

	def duration_entree_last_saturday_in_hours
		(duration_entree_last_saturday_in_minutes / 60).floor
	end

	def display_duration_entree_last_saturday_minutes		
		duration_entree_last_saturday_in_minutes - duration_entree_last_saturday_in_hours*60		
	end

	def display_duration_entree_last_saturday_seconds
		duration_entree_last_saturday - duration_entree_last_saturday_in_minutes*60
	end

	def display_duration_entree_last_saturday # OK
		if duration_entree_last_saturday_in_hours < 10 && display_duration_entree_last_saturday_minutes < 10
			"0#{duration_entree_last_saturday_in_hours}h0#{display_duration_entree_last_saturday_minutes}m"
		elsif duration_entree_last_saturday_in_hours < 10 && display_duration_entree_last_saturday_minutes >= 10
			"0#{duration_entree_last_saturday_in_hours}h#{display_duration_entree_last_saturday_minutes}m"
		elsif duration_entree_last_saturday_in_hours >= 10 && display_duration_entree_last_saturday_minutes < 10
			"#{duration_entree_last_saturday_in_hours}h0#{display_duration_entree_last_saturday_minutes}m"
		elsif duration_entree_last_saturday_in_hours >= 10 && display_duration_entree_last_saturday_minutes >= 10
			"#{duration_entree_last_saturday_in_hours}h#{display_duration_entree_last_saturday_minutes}m"	
		end
	end

  	def duration_entree_last_sunday 
  		duration_entree_last_sunday = 0
		attendances.entree.last_sunday.each do |entree|
			if next_sortie(entree)
			duration_entree_last_sunday += duration_entree(entree)
			end
		end
		duration_entree_last_sunday	
  	end

	def duration_entree_last_sunday_in_minutes
		(duration_entree_last_sunday / 60).floor
	end

	def duration_entree_last_sunday_in_hours
		(duration_entree_last_sunday_in_minutes / 60).floor
	end

	def display_duration_entree_last_sunday_minutes		
		duration_entree_last_sunday_in_minutes - duration_entree_last_sunday_in_hours*60		
	end

	def display_duration_entree_last_sunday_seconds
		duration_entree_last_sunday - duration_entree_last_sunday_minutes*60
	end

	def display_duration_entree_last_sunday # OK
		if duration_entree_last_sunday_in_hours < 10 && display_duration_entree_last_sunday_minutes < 10
			"0#{duration_entree_last_sunday_in_hours}h0#{display_duration_entree_last_sunday_minutes}m"
		elsif duration_entree_last_sunday_in_hours < 10 && display_duration_entree_last_sunday_minutes > 9
			"0#{duration_entree_last_sunday_in_hours}h#{display_duration_entree_last_sunday_minutes}m"
		elsif duration_entree_last_sunday_in_hours > 9 && display_duration_entree_last_sunday_minutes < 10
			"#{duration_entree_last_sunday_in_hours}h0#{display_duration_entree_last_sunday_minutes}m"
		elsif duration_entree_last_sunday_in_hours > 9 && display_duration_entree_last_sunday_minutes > 9
			"#{duration_entree_last_sunday_in_hours}h#{display_duration_entree_last_sunday_minutes}m"	
		end
	end

  	def duration_entree_last_week 
  		duration_entree_last_week = 0
		attendances.entree.last_week.each do |entree|
			if next_sortie(entree)
			duration_entree_last_week += duration_entree(entree)
			end
		end
		duration_entree_last_week	
  	end

	def duration_entree_last_week_in_minutes
		(duration_entree_last_week / 60).floor
	end

	def duration_entree_last_week_in_hours
		(duration_entree_last_week_in_minutes / 60).floor
	end

	def display_duration_entree_last_week_minutes		
		duration_entree_last_week_in_minutes - duration_entree_last_week_in_hours*60		
	end

	def display_duration_entree_last_week_seconds
		duration_entree_last_week - duration_entree_last_week_in_minutes*60
	end

	def display_duration_entree_last_week # OK
		if duration_entree_last_week_in_hours < 10 && display_duration_entree_last_week_minutes < 10
			"0#{duration_entree_last_week_in_hours}h0#{display_duration_entree_last_week_minutes}m"
		elsif duration_entree_last_week_in_hours < 10 && display_duration_entree_last_week_minutes > 9
			"0#{duration_entree_last_week_in_hours}h#{display_duration_entree_last_week_minutes}m"
		elsif duration_entree_last_week_in_hours > 9 && display_duration_entree_last_week_minutes < 10
			"#{duration_entree_last_week_in_hours}h0#{display_duration_entree_last_week_minutes}m"
		elsif duration_entree_last_week_in_hours > 9 && display_duration_entree_last_week_minutes > 9
			"#{duration_entree_last_week_in_hours}h#{display_duration_entree_last_week_minutes}m"	
		end
	end

  	def duration_entree_current_month 
  		duration_entree_current_month = 0
		attendances.entree.current_month.each do |entree|
			if next_sortie(entree)
			duration_entree_current_month += duration_entree(entree)
			end
		end
		duration_entree_current_month	
  	end

	def duration_entree_current_month_in_minutes
		(duration_entree_current_month / 60).floor
	end

	def duration_entree_current_month_in_hours
		(duration_entree_current_month_in_minutes / 60).floor
	end

	def display_duration_entree_current_month_minutes		
		duration_entree_current_month_in_minutes - duration_entree_current_month_in_hours*60		
	end

	def display_duration_entree_current_month_seconds
		duration_entree_current_month - duration_entree_current_month_in_minutes*60
	end

	def display_duration_entree_current_month # OK
		if duration_entree_current_month_in_hours < 10 && display_duration_entree_current_month_minutes < 10
			"0#{duration_entree_current_month_in_hours}h0#{display_duration_entree_current_month_minutes}m"
		elsif duration_entree_current_month_in_hours < 10 && display_duration_entree_current_month_minutes > 9
			"0#{duration_entree_current_month_in_hours}h#{display_duration_entree_current_month_minutes}m"
		elsif duration_entree_current_month_in_hours > 9 && display_duration_entree_current_month_minutes < 10
			"#{duration_entree_current_month_in_hours}h0#{display_duration_entree_current_month_minutes}m"
		elsif duration_entree_current_month_in_hours > 9 && display_duration_entree_current_month_minutes > 9
			"#{duration_entree_current_month_in_hours}h#{display_duration_entree_current_month_minutes}m"	
		end
	end

end