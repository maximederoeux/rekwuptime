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
		if self.attendances.last.content = "entree"
			"Dernière entrée"
		elsif self.attendances.last.content = "sortie"
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

	# duration between an out and the next in, in seconds
	def duration_in_out
		(attendance.created_at - employee.attendances.where("created_at < ?", attendance.created_at).where(:content => "entree").last.created_at)
	end

	def full_name_with_id
    	"##{id} - #{full_name}"
  	end

end
