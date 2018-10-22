class CreateLeagues < ActiveRecord::Migration[5.1]
  create_table :leagues do |t|
    t.string :name
    t.string :nation
  end
end
