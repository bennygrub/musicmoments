class AddNameToTempUsers < ActiveRecord::Migration
  def change
    add_column :temp_users, :name, :string
  end
end
