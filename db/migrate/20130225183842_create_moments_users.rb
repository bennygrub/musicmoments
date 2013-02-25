class CreateMomentsUsers < ActiveRecord::Migration
  def change
    create_table :moments_users do |t|
      t.integer :moment_id
      t.integer :user_id

      t.timestamps
    end
  end
end
