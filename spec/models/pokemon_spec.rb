require 'rails_helper'

describe Pokemon, type: :model do
  before(:each) do
    @pokedex = Pokedex.new
    @pokedex.name = 'test'
    @pokedex.base_health_point = 10
    @pokedex.base_attack = 10
    @pokedex.base_defence = 10
    @pokedex.base_speed = 10
    @pokedex.element_type = 'normal'
    @pokedex.save
  end

  it 'should be able to save pokemon' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(true)
  end

  it 'should fail saving if pokedex is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = nil
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if pokedex is not exist' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = 100
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if name is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = nil
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if name is not unique' do
    attribute = {
      pokedex_id: @pokedex.id,
      name: 'test',
      level: 10,
      max_health_point: 10,
      current_health_point: 10,
      attack: 10,
      defence: 10,
      speed: 10,
      current_experience: 10
    }
    Pokemon.create!(attribute)
    pokemon_with_duplicate_name = Pokemon.new(attribute)
    expect(pokemon_with_duplicate_name.save).to eq(false)
  end

  it 'should fail saving if current_experience is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = nil

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if current_experience is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 'test'

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if current_experience is less than zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = -1

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if max_health_point is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = nil
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if max_health_point is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 'test'
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if max_health_point is less or equal to zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 0
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if current_health_point is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = nil
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end


  it 'should fail saving if current_health_point is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 'test'
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if current_health_point is less than zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = -1
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if current_health_point is greater than max_health_point' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 20
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if attack is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = nil
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end


  it 'should fail saving if attack is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 'test'
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end


  it 'should fail saving if attack is less or equal to zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 0
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if defence is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = nil
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end


  it 'should fail saving if defence is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 'test'
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if defence is less or equal to zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 0
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if speed is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = nil
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if speed is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 'test'
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if speed is less or equal to zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 10
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 0
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if level is empty' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = nil
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if speed is not a number' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 'test'
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

  it 'should fail saving if speed is less or equal to zero' do
    pokemon = Pokemon.new
    pokemon.pokedex_id = @pokedex.id
    pokemon.name = 'test'
    pokemon.level = 0
    pokemon.max_health_point = 10
    pokemon.current_health_point = 10
    pokemon.attack = 10
    pokemon.defence = 10
    pokemon.speed = 10
    pokemon.current_experience = 10

    expect(pokemon.save).to eq(false)
  end

end