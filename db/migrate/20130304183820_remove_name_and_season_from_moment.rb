class RemoveNameAndSeasonFromMoment < ActiveRecord::Migration
  def up
    remove_column :moments, :name
    remove_column :moments, :season
  end

  def down
    add_column :moments, :season, :string
    add_column :moments, :name, :string
  end
end
