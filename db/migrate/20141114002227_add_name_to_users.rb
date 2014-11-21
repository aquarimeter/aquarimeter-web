class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :first_name, :string, limit: 127
    add_column :last_name,  :string, limit: 127
  end
end