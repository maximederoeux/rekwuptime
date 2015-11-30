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
		self.duration_in_minutes(attendance) - (self.duration_in_hours(attendance))*60
	end

	def display_duration_seconds(attendance)
		self.duration(attendance) - (self.duration_in_minutes(attendance)*60)	
	end

	def display_duration(attendance)
		"#{self.duration_in_hours(attendance)}h#{self.display_duration_minutes(attendance)}m#{self.display_duration_seconds(attendance)}s"
	end

end
