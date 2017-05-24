
class BattleEngine
  attr_reader :errors

  def initialize(pokemon_battle, pokemon_attacker, pokemon_defender, skill)

    @pokemon_battle = PokemonBattle.find(pokemon_battle)
    @pokemon_attacker = Pokemon.find(pokemon_attacker)
    @pokemon_defender = Pokemon.find(pokemon_defender)
    @skill = Skill.where(name: skill).first
    if @skill.present?
      @pokemon_skill = PokemonSkill.where(pokemon_id: @pokemon_attacker.id, skill_id: @skill.id).first
    end
  end

  def valid_next_turn?
    if @skill.nil? || @pokemon_skill.nil?
      if @skill.nil?
        @errors = { skill: 'Please Select One of Skill'}
        false
      else
        @errors = { skill: "Pokemon didn't have that skill"}
        false
      end
    elsif @pokemon_skill.current_pp <= 0
      @errors = { skill: 'Current PP must be greater than 0.'}
      false
    else
      true
    end
  end

  def ai_next_turn!
    flag = 0
    ai_pokemon_skills = @pokemon_defender.pokemon_skills
    ai_pokemon_skills.each do |f|
      if f.current_pp > 0
        flag += 1
      end
    end
    if flag == 0
      @pokemon_battle.pokemon_winner_id = @pokemon_attacker.id
      @pokemon_battle.pokemon_loser_id = @pokemon_defender.id
      @pokemon_battle.state = "Finish"
      @skill = nil
    else
      skill_current_pp = 0
      while skill_current_pp == 0
        pokemon_skill = @pokemon_defender.pokemon_skills.sample(1).first
        skill_current_pp = pokemon_skill.current_pp
      end
      skill = pokemon_skill.skill
      @pokemon_skill = PokemonSkill.where(pokemon_id: @pokemon_defender.id, skill_id: skill.id).first
      @attack = PokemonBattleCalculator.calculate_damage(@pokemon_defender, @pokemon_attacker, skill)
      remaining_health_point = @pokemon_attacker.current_health_point - @attack
      if remaining_health_point <= 0
        @pokemon_attacker.current_health_point = 0
        @pokemon_battle.pokemon_winner_id = @pokemon_defender.id
        @pokemon_battle.pokemon_loser_id = @pokemon_attacker.id
        @pokemon_battle.state = "Finish"
        @pokemon_defender.current_experience += PokemonBattleCalculator.calculate_experience(@pokemon_attacker.level)
        if PokemonBattleCalculator.level_up?(@pokemon_defender.level, @pokemon_defender.current_experience)
          @pokemon_defender.level += 1
          stats = PokemonBattleCalculator.calculate_level_up_extra_stats
          @pokemon_defender.max_health_point += stats.health_point
          @pokemon_defender.attack += stats.attack_point
          @pokemon_defender.defence += stats.defence_point
          @pokemon_defender.speed += stats.speed_point
        end
      else
        @pokemon_attacker.current_health_point -= @attack
      end
      if @pokemon_skill.current_pp > 0
        @pokemon_skill.current_pp -= 1
        @pokemon_battle.current_turn += 1
      end

    end


  end

  def next_turn!
    if @skill.present?
      @attack = PokemonBattleCalculator.calculate_damage(@pokemon_attacker, @pokemon_defender, @skill)
      remaining_health_point = @pokemon_defender.current_health_point - @attack


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
        @pokemon_defender.current_health_point -= @attack
      end

      if @pokemon_skill.current_pp > 0
        @pokemon_skill.current_pp -= 1
        @pokemon_battle.current_turn += 1
      end
    else
      @pokemon_battle.pokemon_winner_id = @pokemon_defender.id
      @pokemon_battle.pokemon_loser_id = @pokemon_attacker.id
      @pokemon_battle.state = "Finish"
      @pokemon_defender.current_experience += PokemonBattleCalculator.calculate_experience(@pokemon_attacker.level)
      if PokemonBattleCalculator.level_up?(@pokemon_defender.level, @pokemon_defender.current_experience)
        @pokemon_defender.level += 1
        stats = PokemonBattleCalculator.calculate_level_up_extra_stats
        @pokemon_defender.max_health_point += stats.health_point
        @pokemon_defender.attack += stats.attack_point
        @pokemon_defender.defence += stats.defence_point
        @pokemon_defender.speed += stats.speed_point
      end
    end
  end

  def save!
    @pokemon_battle.save
    @pokemon_attacker.save
    @pokemon_defender.save
    if @skill.present?
      @pokemon_skill.save
    end
  end

  def battle_log!
    @battle_log = PokemonBattleLog.new
    @battle_log.pokemon_battle_id = @pokemon_battle.id
    @battle_log.damage = @attack
    @battle_log.attacker_current_health_point = @pokemon_attacker.current_health_point
    @battle_log.defender_current_health_point = @pokemon_defender.current_health_point
    @battle_log.attacker_id = @pokemon_attacker.id
    @battle_log.defender_id = @pokemon_defender.id
    @battle_log.turn = @pokemon_battle.current_turn-1
    if @skill.present?
      @battle_log.skill_id = @skill.id
      @battle_log.action_type = "Attack"
    else
      @battle_log.turn += 1
      @battle_log.skill_id = nil
      @battle_log.action_type = "Surrender"
    end
    @battle_log.save
  end

  def ai_battle_log!
    @battle_log = PokemonBattleLog.new
    @battle_log.pokemon_battle_id = @pokemon_battle.id
    @battle_log.damage = @attack
    @battle_log.attacker_id = @pokemon_defender.id
    @battle_log.defender_id = @pokemon_attacker.id
    @battle_log.turn = @pokemon_battle.current_turn-1
    @battle_log.attacker_current_health_point = @pokemon_defender.current_health_point
    @battle_log.defender_current_health_point = @pokemon_attacker.current_health_point
    if @skill.present?
      @battle_log.action_type = "Attack"
      @battle_log.damage = @attack
      @battle_log.skill_id = @pokemon_skill.id
    else
      @battle_log.action_type = "Surrender"
      @pokemon_battle.state = "Finish"
      @battle_log.turn += 1
      @pokemon_battle.save
      @battle_log.damage = nil
      @battle_log.skill_id = nil
    end
    @battle_log.save
  end
end