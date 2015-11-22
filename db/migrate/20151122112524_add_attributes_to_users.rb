class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :status, :string
    add_column :users, :validation_code, :string
  end
end
