class AddApprovedToMomentsUsers < ActiveRecord::Migration
  def change
    add_column :moments_users, :approved, :boolean, :default => false
  end
end
