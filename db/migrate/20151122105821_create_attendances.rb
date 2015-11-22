class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.boolean :in

      t.timestamps null: false
    end
  end
end
