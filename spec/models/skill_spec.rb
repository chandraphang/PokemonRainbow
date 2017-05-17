require 'rails_helper'

describe Skill, type: :model do

it 'should be able to save skill' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 10
    skill.max_pp = 10
    skill.element_type = 'grass'
    expect(skill.save).to eq(true)
end

it 'should fail saving if name is empty' do
   skill = Skill.new
    skill.name = nil
    skill.power = 10
    skill.max_pp = 10
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if name is not unique' do
    attribute = {
        name: 'test',
        power: 10,
        max_pp: 10,
        element_type: 'grass'
    }

    Skill.create!(attribute)
    skill_with_duplicate_name = Skill.new(attribute)
    expect(skill_with_duplicate_name.save).to eq(false)
end

it 'should fail saving if power is empty' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = nil
    skill.max_pp = 10
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if power is not a number' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 'test'
    skill.max_pp = 10
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if power is less or equal to zero' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 0
    skill.max_pp = 10
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if max_pp is empty' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 10
    skill.max_pp = nil
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if power is not a number' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 10
    skill.max_pp = 'test'
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if power is less or equal to zero' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 10
    skill.max_pp = 0
    skill.element_type = 'grass'
    expect(skill.save).to eq(false)
end

it 'should fail saving if element_type is not one of 24 in element list' do
    skill = Skill.new
    skill.name = 'test'
    skill.power = 10
    skill.max_pp = 10
    skill.element_type = 'test'
    expect(skill.save).to eq(false)
end


end