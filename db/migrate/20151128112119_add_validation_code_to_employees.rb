class AddValidationCodeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :validation_code, :integer
  end
end
