class CreatePokemonEvolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_evolutions do |t|
      t.string :pokedex_from_name, null: false
      t.string :pokedex_to_name, null: false
      t.integer :minimum_level, null: false
      t.timestamps
    end
  end
end
