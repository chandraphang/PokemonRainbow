class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
    validates_uniqueness_of :skill_id, :scope => :pokemon_id
end
