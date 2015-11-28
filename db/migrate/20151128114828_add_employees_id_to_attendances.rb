class AddEmployeesIdToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :employees_id, :integer
  end
end
