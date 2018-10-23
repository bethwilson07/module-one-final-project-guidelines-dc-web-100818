class AddColumnsToLeaguesTable < ActiveRecord::Migration[4.2]
  add_column :leagues, :year_founded, :string
  add_column :leagues, :description, :string
  add_column :leagues, :facebook, :string
  add_column :leagues, :twitter, :string
  add_column :leagues, :instagram, :string
end
