require 'rails_helper'

describe BattleEngine do
  before(:each) do
    pokedex = Pokedex.new
    pokedex.name = 'pokemon'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'
    pokedex.save

    @pokemon_attacker = Pokemon.new
    @pokemon_attacker.pokedex_id = pokedex.id
    @pokemon_attacker.name = 'pokemon1'
    @pokemon_attacker.level = 1
    @pokemon_attacker.max_health_point = 100
    @pokemon_attacker.current_health_point = 100
    @pokemon_attacker.attack = 10
    @pokemon_attacker.defence = 10
    @pokemon_attacker.speed = 10
    @pokemon_attacker.current_experience = 10
    @pokemon_attacker.save

    @pokemon_defender = Pokemon.new
    @pokemon_defender.pokedex_id = pokedex.id
    @pokemon_defender.name = 'pokemon2'
    @pokemon_defender.level = 10
    @pokemon_defender.max_health_point = 100
    @pokemon_defender.current_health_point = 100
    @pokemon_defender.attack = 10
    @pokemon_defender.defence = 10
    @pokemon_defender.speed = 10
    @pokemon_defender.current_experience = 10
    @pokemon_defender.save

    @skill = Skill.new
    @skill.name = 'skill'
    @skill.power = 70
    @skill.max_pp = 10
    @skill.element_type = 'grass'
    @skill.save

    @pokemon_battle = PokemonBattle.new
    @pokemon_battle.pokemon1_id = @pokemon_attacker.id
    @pokemon_battle.pokemon2_id = @pokemon_defender.id
    @pokemon_battle.current_turn = 1
    @pokemon_battle.state = 'On Going'
    @pokemon_battle.pokemon_winner_id = ''
    @pokemon_battle.pokemon_loser_id = ''
    @pokemon_battle.experience_gain = 0
    @pokemon_battle.pokemon1_max_health_point = @pokemon_attacker.max_health_point
    @pokemon_battle.pokemon2_max_health_point = @pokemon_defender.max_health_point
    @pokemon_battle.save

    @pokemon_skill = PokemonSkill.new
    @pokemon_skill.pokemon_id = @pokemon_attacker.id
    @pokemon_skill.skill_id = @skill.id
    @pokemon_skill.current_pp = @skill.max_pp
    @pokemon_skill.save

    @pokemon_battle_log = PokemonBattleLog.new
    @pokemon_battle_log.pokemon_battle_id = @pokemon_battle.id
    @pokemon_battle_log.turn = @pokemon_battle.current_turn
    @pokemon_battle_log.skill_id = @skill.id
    @pokemon_battle_log.damage = PokemonBattleCalculator.calculate_damage(@pokemon_attacker, @pokemon_defender, @skill)
    @pokemon_battle_log.attacker_id = @pokemon_attacker.id
    @pokemon_battle_log.attacker_current_health_point = @pokemon_attacker.current_health_point
    @pokemon_battle_log.defender_id = @pokemon_defender.id
    @pokemon_battle_log.defender_current_health_point = @pokemon_defender.current_health_point
    @pokemon_battle_log.action_type = 'attack'
    @pokemon_battle_log.save

  end
  # describe '#initialize' do
  #   it 'initialize not return false' do
  #     a = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill)
  #     expect(a).to be_truthy
  #   end

  #   it 'pokemon_battle_id in initialize shoud not be null' do
  #     a = BattleEngine.new(nil, @pokemon_attacker.id, @pokemon_defender.id, @skill)
  #     expect(a).to raise_error
  #   end

  # end
  it 'should valid if every parameter is complete' do
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    expect(battle_engine.valid_next_turn?).to be_truthy
  end

  it 'should can not attack if skill is empty' do
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, nil)
    expect(battle_engine.valid_next_turn?).to eq(false)
  end

  it 'should can not attack if current pp skill is 0' do
    @pokemon_skill.current_pp = 0
    @pokemon_skill.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    expect(battle_engine.valid_next_turn?).to eq(false)
  end

  it 'should can not attack if skill is not belong to pokemon skill' do
    skill_new = Skill.new
    skill_new.name = 'skill_new'
    skill_new.power = 70
    skill_new.max_pp = 10
    skill_new.element_type = 'grass'
    skill_new.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, skill_new.name)
    expect(battle_engine.valid_next_turn?).to eq(false)
  end

  it 'should decrease current_pp pokemon pokemon_attacker skill' do
    current_pp_before = @pokemon_skill.current_pp
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    current_pp_after = PokemonSkill.where(pokemon_id: @pokemon_attacker.id, skill_id: @skill.id).first.current_pp
    expect(current_pp_after).to be(current_pp_before-1)
  end

  it 'should pokemon battle turn if pokemon attacker attack successfully' do
    turn_before = @pokemon_battle.current_turn
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    turn_after = PokemonBattle.find(@pokemon_battle.id).current_turn
    expect(turn_after).to be > turn_before
  end

  it 'should decrease pokemon_defender current_health_point' do
    current_health_point_before = @pokemon_defender.current_health_point
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    current_health_point_after = Pokemon.find(@pokemon_defender.id).current_health_point
    expect(current_health_point_after).to be  < current_health_point_before
  end

  it 'should change state to finish if pokemon_defender_health_point become zero' do
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    pokemon_battle_state = PokemonBattle.find(@pokemon_battle.id).state
    expect(pokemon_battle_state).to eq("Finish")
  end

  it 'should change pokemon_winner_id to pokemon_attacker.id when pokemon defender defeated' do
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    pokemon_winner = PokemonBattle.find(@pokemon_battle.id).pokemon_winner_id
    expect(pokemon_winner).to eq(@pokemon_attacker.id)
  end

  it 'should change pokemon_loser_id to pokemon_defender.id when pokemon defender defeated' do
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    pokemon_loser = PokemonBattle.find(@pokemon_battle.id).pokemon_loser_id
    expect(pokemon_loser).to eq(@pokemon_defender.id)
  end

  it 'should increase pokemon winner current_experience pokemon defender defeated' do
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    current_experience_before = @pokemon_attacker.current_experience
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    current_experience_after = Pokemon.find(@pokemon_attacker.id).current_experience
    expect(current_experience_after).to be > current_experience_before
  end

  it 'should increase pokemon attacker level if current experience is enough and pokemon defender defeated' do
    attacker_level_before = @pokemon_attacker.level
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    attacker_level_after = Pokemon.find(@pokemon_attacker.id).level
    expect(attacker_level_after).to be > attacker_level_before
  end

  it 'should increase pokemon attacker max_health_point if pokemon leveled up' do
    attacker_max_health_point_before = @pokemon_attacker.max_health_point
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    attacker_max_health_point_after = Pokemon.find(@pokemon_attacker.id).max_health_point
    expect(attacker_max_health_point_after).to be > attacker_max_health_point_before
  end

  it 'should increase pokemon attacker attack if pokemon leveled up' do
    attacker_attack_before = @pokemon_attacker.attack
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    attacker_attack_after = Pokemon.find(@pokemon_attacker.id).attack
    expect(attacker_attack_after).to be > attacker_attack_before
  end

  it 'should increase pokemon attacker defence if pokemon leveled up' do
    attacker_defence_before = @pokemon_attacker.defence
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    attacker_defence_after = Pokemon.find(@pokemon_attacker.id).defence
    expect(attacker_defence_after).to be > attacker_defence_before
  end

  it 'should increase pokemon attacker speed if pokemon leveled up' do
    attacker_speed_before = @pokemon_attacker.speed
    @pokemon_defender.current_health_point = 0
    @pokemon_defender.save
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    attacker_speed_after = Pokemon.find(@pokemon_attacker.id).speed
    expect(attacker_speed_after).to be > attacker_speed_before
  end

  it 'should create battle log after pokemon attacker attack successfully' do
    battle_log_before = PokemonBattleLog.count
    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    battle_engine.battle_log!
    battle_log_after = PokemonBattleLog.count
    expect(battle_log_after).to be > battle_log_before
  end

end