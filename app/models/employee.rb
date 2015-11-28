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
	

	# duration between an out and the next in, in seconds
	def duration_in_out
		(attendance.created_at - employee.attendances.where("created_at < ?", attendance.created_at).where(:content => "entree").last.created_at)
	end

	def full_name_with_id
    	"##{id} - #{full_name}"
  	end

end
