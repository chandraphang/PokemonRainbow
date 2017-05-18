require 'rails_helper'

describe Pokemon, type: :model do
  before(:each) do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'
    pokedex.save

    @pokemon1 = Pokemon.new
    @pokemon1.pokedex_id = pokedex.id
    @pokemon1.name = 'test'
    @pokemon1.level = 10
    @pokemon1.max_health_point = 10
    @pokemon1.current_health_point = 10
    @pokemon1.attack = 10
    @pokemon1.defence = 10
    @pokemon1.speed = 10
    @pokemon1.current_experience = 10
    @pokemon1.save

    @pokemon2 = Pokemon.new
    @pokemon2.pokedex_id = pokedex.id
    @pokemon2.name = 'test2'
    @pokemon2.level = 10
    @pokemon2.max_health_point = 10
    @pokemon2.current_health_point = 10
    @pokemon2.attack = 10
    @pokemon2.defence = 10
    @pokemon2.speed = 10
    @pokemon2.current_experience = 10
    @pokemon2.save
  end

  it 'should be able to save pokemon battle' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(true)
  end

  it 'should fail saving if both pokemon1_id and pokemon2_id is empty' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = nil
    pokemon_battle.pokemon2_id = nil
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if both pokemon1_id and pokemon2_id is not exist' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = 100
    pokemon_battle.pokemon2_id = 101
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon1_id is empty' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = nil
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon1_id is not exist' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = 100
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon2_id is empty' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = nil
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon2_id is not exist' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = 100
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if current_turn is empty' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = nil
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if current_turn is less or equal to zero' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 0
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if state is empty' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = nil
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if state is not between On Going or Finish' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'test'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 0
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if experience_gain is not a number' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 'test'
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if experience_gain is less than zero' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = -1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon1_max_health_point is not a number' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = 'test'
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end


  it 'should fail saving if pokemon1_max_health_point is less or equal to zero' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = 0
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon2_max_health_point is less not a number' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = 'test'

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon2_max_health_point is less or equal to zero' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = 0

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon_winner_id is not exist' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = 100
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon_loser_id is not exist' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = 100
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon_winner_id is exist in On Going state' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = @pokemon1.id
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon_loser_id is exist in On Going state' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = '@pokemon1.id'
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon1_id same with pokemon2_id' do
    pokemon_battle = PokemonBattle.new
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon1.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon1_hp is zero' do
    pokemon_battle = PokemonBattle.new
    @pokemon1.current_health_point = 0
    @pokemon1.save
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

  it 'should fail saving if pokemon2_hp is zero' do
    pokemon_battle = PokemonBattle.new
    @pokemon2.current_health_point = 0
    @pokemon2.save
    pokemon_battle.pokemon1_id = @pokemon1.id
    pokemon_battle.pokemon2_id = @pokemon2.id
    pokemon_battle.current_turn = 1
    pokemon_battle.state = 'On Going'
    pokemon_battle.pokemon_winner_id = ''
    pokemon_battle.pokemon_loser_id = ''
    pokemon_battle.experience_gain = 1
    pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
    pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point

    expect(pokemon_battle.save).to eq(false)
  end

end