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

	scope :one_week_before, lambda {where(:created_at => (7.day.ago.beginning_of_day..Date.current.end_of_day))}

end

def my_date
	Time.now + 6.days
end