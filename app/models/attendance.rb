class Attendance < ActiveRecord::Base
	belongs_to :employee

	scope :entree, lambda {where(:content => "entree")}
	scope :sortie, lambda {where(:content => "sortie")}

	scope :this_day, lambda {where(:created_at => (Date.current.beginning_of_day..Date.current.end_of_day))}
	scope :one_day_before, lambda {where(:created_at => (1.day.ago.beginning_of_day..1.day.ago.end_of_day))}
	scope :two_days_before, lambda {where(:created_at => (2.days.ago.beginning_of_day..2.days.ago.end_of_day))}
	scope :three_days_before, lambda {where(:created_at => (3.days.ago.beginning_of_day..3.days.ago.end_of_day))}
	scope :four_days_before, lambda {where(:created_at => (4.days.ago.beginning_of_day..4.days.ago.end_of_day))}
	scope :five_days_before, lambda {where(:created_at => (5.days.ago.beginning_of_day..5.days.ago.end_of_day))}
	scope :six_days_before, lambda {where(:created_at => (6.days.ago.beginning_of_day..6.days.ago.end_of_day))}
	scope :seven_days_before, lambda {where(:created_at => (7.days.ago.beginning_of_day..7.days.ago.end_of_day))}
	scope :eight_days_before, lambda {where(:created_at => (8.days.ago.beginning_of_day..8.days.ago.end_of_day))}
	scope :nine_days_before, lambda {where(:created_at => (9.days.ago.beginning_of_day..9.days.ago.end_of_day))}
	scope :ten_days_before, lambda {where(:created_at => (10.days.ago.beginning_of_day..10.days.ago.end_of_day))}
	scope :eleven_days_before, lambda {where(:created_at => (11.days.ago.beginning_of_day..11.days.ago.end_of_day))}
	scope :twelve_days_before, lambda {where(:created_at => (12.days.ago.beginning_of_day..12.days.ago.end_of_day))}
	scope :thirteen_days_before, lambda {where(:created_at => (13.days.ago.beginning_of_day..13.days.ago.end_of_day))}
	scope :fourteen_days_before, lambda {where(:created_at => (14.days.ago.beginning_of_day..14.days.ago.end_of_day))}
	scope :fifteen_days_before, lambda {where(:created_at => (15.days.ago.beginning_of_day..15.days.ago.end_of_day))}

	


	scope :last_week, lambda {where(:created_at => (6.days.ago.beginning_of_week.beginning_of_day..6.days.ago.end_of_week.end_of_day))}
	scope :last_monday, lambda {where(:created_at => (6.days.ago.beginning_of_week.beginning_of_day..6.days.ago.beginning_of_week.end_of_day))}
	scope :last_tuesday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 1.day).beginning_of_day..(6.days.ago.beginning_of_week + 1.day).end_of_day))}
	scope :last_wednesday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 2.days).beginning_of_day..(6.days.ago.beginning_of_week + 2.days).end_of_day))}
	scope :last_thursday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 3.days).beginning_of_day..(6.days.ago.beginning_of_week + 3.days).end_of_day))}
	scope :last_friday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 4.days).beginning_of_day..(6.days.ago.beginning_of_week + 4.days).end_of_day))}
	scope :last_saturday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 5.days).beginning_of_day..(6.days.ago.beginning_of_week + 5.days).end_of_day))}
	scope :last_sunday, lambda {where(:created_at => ((6.days.ago.beginning_of_week + 6.days).beginning_of_day..(6.days.ago.beginning_of_week + 6.days).end_of_day))}

	scope :current_month, lambda {where(:created_at => (Date.current.beginning_of_month..Date.current.end_of_month))}


def my_date
	Time.now + 6.days
end

def content_display
	if content == 'entree'
		"Présent(e)"

	elsif content == 'sortie'
		"Absent(e)"

	end
end

def entree
	content == 'entree'
end

def sortie
	content == 'sortie'
end

# duration between an out and the next in, in seconds
	def duration_in_out
		(attendance.created_at - employee.attendances.where("created_at < ?", attendance.created_at).where(:content => "entree").last.created_at)
	end

	def duration_in_hours
		(sortie.created_at - employee.entrees.where("created_at < ?", sortie.created_at).last.created_at)/3600
	end

	def daily_sort
		self.created_at.strftime('%d/%m/%Y')
	end



end