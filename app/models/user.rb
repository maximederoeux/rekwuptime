class User < ActiveRecord::Base
	has_many :attendances
	has_many :employees
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


def interim
	employees.where(:status == 'Intérim')
	
end


end
