class AddColumnsToTeamsTable < ActiveRecord::Migration[4.2]
  add_column :teams, :year_founded, :string
  add_column :teams, :manager, :string
  add_column :teams, :description, :string
  add_column :teams, :stadium_name, :string
  add_column :teams, :stadium_location, :string
end
