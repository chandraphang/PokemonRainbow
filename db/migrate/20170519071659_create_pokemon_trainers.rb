class CreatePokemonTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_trainers do |t|
      t.integer :pokemon_id, null: false
      t.integer :trainer_id, null: false
      t.timestamps
    end
    add_index :pokemon_trainers, :pokemon_id, unique: true
  end
end
