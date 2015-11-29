class AddValidationCodeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :validation_code, :integer
  end
end
