require 'rails_helper'

describe PokemonSkill, type: :model do
  before(:each) do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'
    pokedex.save

    @pokemon = Pokemon.new
    @pokemon.pokedex_id = pokedex.id
    @pokemon.name = 'test'
    @pokemon.level = 10
    @pokemon.max_health_point = 10
    @pokemon.current_health_point = 10
    @pokemon.attack = 10
    @pokemon.defence = 10
    @pokemon.speed = 10
    @pokemon.current_experience = 10
    @pokemon.save

    @skill = Skill.new
    @skill.name = 'test'
    @skill.power = 10
    @skill.max_pp = 10
    @skill.element_type = 'grass'
    @skill.save
  end

  it 'should be able to save pokemon_skill' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(true)
  end

  it 'should fail saving if both pokemon_id and skill_id is not exist' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = 100
    pokemon_skill.skill_id = 100
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if both pokemon_id and skill_id is empty' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = nil
    pokemon_skill.skill_id = nil
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end
  it 'should fail saving if pokemon_id is empty' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = nil
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if pokemon_id is not exist' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = 100
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if skill_id is empty' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = nil
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if skill_id is not exist' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = 100
    pokemon_skill.current_pp = @skill.max_pp
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if pair of skill_id and pokemon_id is already exist' do
    attribute = {
      pokemon_id: @pokemon.id,
      skill_id: @skill.id,
      current_pp: 10,
    }

    PokemonSkill.create!(attribute)
    pokemon_skill_with_duplicate_pokemon_id_and_skill_id = PokemonSkill.new(attribute)
    expect(pokemon_skill_with_duplicate_pokemon_id_and_skill_id.save).to eq(false)
  end

  it 'should fail saving if current_pp is greater than max_pp' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = @skill.max_pp+1
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if current_pp is less than 0' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = -1
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if current_pp is empty' do
    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = nil
    expect(pokemon_skill.save).to eq(false)
  end

  it 'should fail saving if one pokemon have more than 4 skills' do
    skill2 = Skill.new
    skill2.name = 'test2'
    skill2.power = 10
    skill2.max_pp = 10
    skill2.element_type = 'grass'
    skill2.save

    skill3 = Skill.new
    skill3.name = 'test3'
    skill3.power = 10
    skill3.max_pp = 10
    skill3.element_type = 'grass'
    skill3.save

    skill4 = Skill.new
    skill4.name = 'test4'
    skill4.power = 10
    skill4.max_pp = 10
    skill4.element_type = 'grass'
    skill4.save

    skill5 = Skill.new
    skill5.name = 'test5'
    skill5.power = 10
    skill5.max_pp = 10
    skill5.element_type = 'grass'
    skill5.save


    pokemon_skill = PokemonSkill.new
    pokemon_skill.pokemon_id = @pokemon.id
    pokemon_skill.skill_id = @skill.id
    pokemon_skill.current_pp = 10
    pokemon_skill.save

    pokemon_skill2 = PokemonSkill.new
    pokemon_skill2.pokemon_id = @pokemon.id
    pokemon_skill2.skill_id = skill2.id
    pokemon_skill2.current_pp = 10
    pokemon_skill2.save

    pokemon_skill3 = PokemonSkill.new
    pokemon_skill3.pokemon_id = @pokemon.id
    pokemon_skill3.skill_id = skill3.id
    pokemon_skill3.current_pp = 10
    pokemon_skill3.save

    pokemon_skill4 = PokemonSkill.new
    pokemon_skill4.pokemon_id = @pokemon.id
    pokemon_skill4.skill_id = skill4.id
    pokemon_skill4.current_pp = 10
    pokemon_skill4.save

    pokemon_skill5 = PokemonSkill.new
    pokemon_skill5.pokemon_id = @pokemon.id
    pokemon_skill5.skill_id = skill5.id
    pokemon_skill5.current_pp = 10

    expect(pokemon_skill5.save).to eq(false)
  end

end