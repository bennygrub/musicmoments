class AddUserIdToMoment < ActiveRecord::Migration
  def change
    add_column :moments, :user_id, :integer
  end
end
