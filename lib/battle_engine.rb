class BattleEngine
  attr_reader :errors

  def initialize(pokemon_battle, pokemon_attacker, pokemon_defender, skill)
    @pokemon_battle = PokemonBattle.find(pokemon_battle)
    @pokemon_attacker = Pokemon.find(pokemon_attacker)
    @pokemon_defender = Pokemon.find(pokemon_defender)
    @skill = Skill.where(name: skill).first
      if skill.present?
        @pokemon_skill = PokemonSkill.where(pokemon_id: @pokemon_attacker.id, skill_id: @skill.id).first
      end
   end

  def valid_next_turn?
    if @skill.nil?
      @errors = { skill: 'Please Select One of Skill'}
      false
    elsif @pokemon_skill.current_pp <= 0
      @errors = { skill: 'Current PP must be greater than 0.'}
      false
    elsif !@pokemon_skill.present?
      @errors = { skill: "Pokemon didn't have that skill"}
      false
    else
      true
    end
  end

  def next_turn!

    if @skill.present?
      attack = PokemonBattleCalculator.calculate_damage(@pokemon_attacker, @pokemon_defender, @skill)
      remaining_health_point = @pokemon_defender.current_health_point - attack


      if remaining_health_point <= 0
        @pokemon_defender.current_health_point = 0
        @pokemon_battle.pokemon_winner_id = @pokemon_attacker.id
        @pokemon_battle.pokemon_loser_id = @pokemon_defender.id
        @pokemon_battle.state = "Finish"
        @pokemon_attacker.current_experience += PokemonBattleCalculator.calculate_experience(@pokemon_defender.level)
        if PokemonBattleCalculator.level_up?(@pokemon_attacker.level, @pokemon_attacker.current_experience)
          @pokemon_attacker.level += 1
          stats = PokemonBattleCalculator.calculate_level_up_extra_stats
          @pokemon_attacker.max_health_point += stats.health_point
          @pokemon_attacker.attack += stats.attack_point
          @pokemon_attacker.defence += stats.defence_point
          @pokemon_attacker.speed += stats.speed_point
        end
      else
        @pokemon_defender.current_health_point -= attack
      end

      if @pokemon_skill.current_pp > 0
        @pokemon_skill.current_pp -= 1
        @pokemon_battle.current_turn += 1
      end
  else
    @pokemon_battle.pokemon_winner_id = @pokemon_attacker.id
    @pokemon_battle.pokemon_loser_id = @pokemon_defender.id
    @pokemon_battle.state = "Finish"
  end
  end

  def save!
    @pokemon_battle.save
    @pokemon_attacker.save
    @pokemon_defender.save
    @pokemon_skill.save
  end
end