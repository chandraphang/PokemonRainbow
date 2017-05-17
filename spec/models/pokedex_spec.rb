require 'rails_helper'

describe Pokedex, type: :model do

it 'should be able to save pokedex' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(true)
end

it 'should fail saving if name is empty' do
    pokedex = Pokedex.new
    pokedex.name = nil
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if name is not unique' do
    attribute = {
    name: 'coba',
    base_health_point: 10,
    base_attack: 10,
    base_defence: 10,
    base_speed: 10,
    element_type: 'grass'
    }

    Pokedex.create!(attribute)
    pokedex_with_duplicate_name = Pokedex.new(attribute)
    expect(pokedex_with_duplicate_name.save).to eq(false)
end

it 'should fail saving if base_health_point is empty' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = nil
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_health_point is not a number' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 'test'
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_health_point less or equal to zero' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 0
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_attack is empty' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = nil
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_attack is not a number' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 'test'
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_attack less or equal to zero' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 0
    pokedex.base_defence = 10
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_defence is empty' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = nil
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_defence is not a number' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 'test'
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_defence less or equal to zero' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 0
    pokedex.base_speed = 10
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_speed is empty' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = nil
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_speed is not a number' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 'test'
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if base_speed less or equal to zero' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 0
    pokedex.element_type = 'normal'

    expect(pokedex.save).to eq(false)
end

it 'should fail saving if element_type is not one of 24 element list' do
    pokedex = Pokedex.new
    pokedex.name = 'test'
    pokedex.base_health_point = 10
    pokedex.base_attack = 10
    pokedex.base_defence = 10
    pokedex.base_speed = 0
    pokedex.element_type = 'test'

    expect(pokedex.save).to eq(false)
end

end