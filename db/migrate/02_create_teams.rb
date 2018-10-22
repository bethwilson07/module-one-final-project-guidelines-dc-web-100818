class CreateTeams < ActiveRecord::Migration[5.1]
  create_table :teams do |t|
    t.string :name
    t.string :city
  end
end
