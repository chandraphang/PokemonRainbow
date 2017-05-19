class AutoBattleEngine
  attr_reader :errors
  def initialize(pokemon_battle)
    @pokemon_battle = pokemon_battle
  end

  def execute!
    while @pokemon_battle.state == 'On Going'
      flag = 0
      if @pokemon_battle.current_turn.odd?
        ai_pokemon_skills = @pokemon_battle.pokemon1.pokemon_skills
        pokemon_attacker = @pokemon_battle.pokemon1
        pokemon_defender = @pokemon_battle.pokemon2
      else
        ai_pokemon_skills = @pokemon_battle.pokemon2.pokemon_skills
        pokemon_attacker = @pokemon_battle.pokemon2
        pokemon_defender = @pokemon_battle.pokemon1
      end

      ai_pokemon_skills.each do |f|
        if f.current_pp > 0
          flag += 1
        end
      end
      if flag == 0
        battle_engine = BattleEngine.new(@pokemon_battle.id, pokemon_attacker, pokemon_defender, nil)
        battle_engine.next_turn!
        battle_engine.save!
        battle_engine.battle_log!
      else
        skill_current_pp = 0
        while skill_current_pp == 0
          pokemon_skill = ai_pokemon_skills.sample(1).first
          skill_current_pp = pokemon_skill.current_pp
        end
        skill = pokemon_skill.skill
        skill_name = pokemon_skill.skill.name
        battle_engine = BattleEngine.new(@pokemon_battle.id, pokemon_attacker, pokemon_defender, skill_name)
        battle_engine.next_turn!
        battle_engine.save!
        battle_engine.battle_log!
      end
      @pokemon_battle.reload
    end
  end
end