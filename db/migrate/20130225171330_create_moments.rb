class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :name
      t.string :song
      t.datetime :year
      t.string :season

      t.timestamps
    end
  end
end
