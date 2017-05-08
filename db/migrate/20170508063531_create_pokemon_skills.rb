class CreatePokemonSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_skills do |t|
        t.integer :pokemon_id, null: false
        t.integer :skill_id, null: false
        t.integer :current_pp, null: false
      t.timestamps
    end
    add_foreign_key :pokemon_skills, :pokemons
    add_foreign_key :pokemon_skills, :skills
  end
end
