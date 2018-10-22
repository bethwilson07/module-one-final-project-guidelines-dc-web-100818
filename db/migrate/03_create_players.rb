class CreatePlayers < ActiveRecord::Migration[5.1]
  create_table :players do |t|
    t.string :name
    t.string :position
  end
end
