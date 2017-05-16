class CreatePokemonBattleLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemon_battle_logs do |t|
      t.integer :pokemon_battle_id, null: false
      t.integer :turn, null: false
      t.integer :skill_id, null: true
      t.integer :damage, null: true
      t.integer :attacker_id, null: false
      t.integer :attacker_current_health_point, null: false
      t.integer :defender_id, null: false
      t.integer :defender_current_health_point, null: false
      t.string :action_type, null: false, limit: 45
      t.timestamps
    end
  end
end
