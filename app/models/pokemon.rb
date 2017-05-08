class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :pokemon_skills, dependent: :destroy
    has_many :skills, through: :pokemon_skills
end
