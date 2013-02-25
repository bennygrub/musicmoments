class CreateTempUsers < ActiveRecord::Migration
  def change
    create_table :temp_users do |t|
      t.integer :moment_id
      t.string :email

      t.timestamps
    end
  end
end
