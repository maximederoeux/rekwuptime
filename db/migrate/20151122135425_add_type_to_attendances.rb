class AddTypeToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :content, :string
  end
end
