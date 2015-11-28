class RenameEmployeesIdToAttendances < ActiveRecord::Migration
  def change
  	rename_column :attendances, :employees_id, :employee_id
  end
end
