class AddColumnsToPlayersTable < ActiveRecord::Migration[4.2]
  add_column :players, :birthdate, :string
  add_column :players, :birth_location, :string
  add_column :players, :nationality, :string
  add_column :players, :date_signed, :string
  add_column :players, :signing_status, :string
  add_column :players, :player_description, :string
  add_column :players, :height, :string
  add_column :players, :weight, :string
end
