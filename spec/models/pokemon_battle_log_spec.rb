require 'rails_helper'

describe PokemonBattleLog do
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

  end

  it 'should return appropriate value if action is attack' do
    expected_pokemon_battle_id = @pokemon_battle.id
    expected_pokemon_battle_turn = @pokemon_battle.current_turn
    expected_skill = @skill.id
    expected_attacker_id = @pokemon_attacker.id
    expected_defender_id = @pokemon_defender.id
    expected_action_type = 'Attack'
    expected_attacker_current_health_point = @pokemon_attacker.current_health_point
    expected_defender_current_health_point = @pokemon_defender.current_health_point

    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, @skill.name)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    battle_engine.battle_log!

    pokemon_battle_log = PokemonBattleLog.first

    expect(pokemon_battle_log.pokemon_battle_id).to be(expected_pokemon_battle_id)
    expect(pokemon_battle_log.turn).to be(expected_pokemon_battle_turn)
    expect(pokemon_battle_log.skill_id).to be(expected_skill)
    expect(pokemon_battle_log.attacker_id).to be(expected_attacker_id)
    expect(pokemon_battle_log.defender_id).to be(expected_defender_id)
    expect(pokemon_battle_log.action_type).to eql(expected_action_type)
    expect(pokemon_battle_log.attacker_current_health_point).to be(expected_attacker_current_health_point)
    expect(pokemon_battle_log.defender_current_health_point).to be < expected_defender_current_health_point
  end

  it 'should return appropriate value if action is surrender' do
    expected_pokemon_battle_id = @pokemon_battle.id
    expected_pokemon_battle_turn = @pokemon_battle.current_turn
    expected_skill = nil
    expected_attacker_id = @pokemon_attacker.id
    expected_defender_id = @pokemon_defender.id
    expected_action_type = 'Surrender'
    expected_attacker_current_health_point = @pokemon_attacker.current_health_point
    expected_defender_current_health_point = @pokemon_defender.current_health_point
    expected_state = 'Finish'

    battle_engine = BattleEngine.new(@pokemon_battle.id, @pokemon_attacker.id, @pokemon_defender.id, nil)
    battle_engine.valid_next_turn?
    battle_engine.next_turn!
    battle_engine.save!
    battle_engine.battle_log!

    pokemon_battle_log = PokemonBattleLog.first
    pokemon_battle_state = PokemonBattle.first.state
    expect(pokemon_battle_log.pokemon_battle_id).to be(expected_pokemon_battle_id)
    expect(pokemon_battle_log.turn).to be(expected_pokemon_battle_turn)
    expect(pokemon_battle_log.skill_id).to be(expected_skill)
    expect(pokemon_battle_log.attacker_id).to be(expected_defender_id)
    expect(pokemon_battle_log.defender_id).to be(expected_attacker_id)
    expect(pokemon_battle_log.action_type).to eql(expected_action_type)
    expect(pokemon_battle_log.attacker_current_health_point).to be(expected_defender_current_health_point)
    expect(pokemon_battle_log.defender_current_health_point).to be(expected_attacker_current_health_point)
    expect(pokemon_battle_state).to eql(expected_state)

  end

end