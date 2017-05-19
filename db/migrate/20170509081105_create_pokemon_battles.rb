class CreatePokemonBattles < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battles do |t|
      t.integer :pokemon1_id, null: false
      t.integer :pokemon2_id, null: false
      t.integer :current_turn, null: false
      t.string :state, null: false, limit: 45
      t.string :battle_type, null: false, limit: 45
      t.integer :pokemon_winner_id, null: true
      t.integer :pokemon_loser_id, null: true
      t.integer :experience_gain, null: false
      t.integer :pokemon1_max_health_point, null: false
      t.integer :pokemon2_max_health_point, null: false
      t.timestamps
    end
  end
end
