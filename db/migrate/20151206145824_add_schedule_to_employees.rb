class AddScheduleToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :schedule, :integer
  end
end
