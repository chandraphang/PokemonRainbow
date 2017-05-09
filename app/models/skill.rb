class Skill < ApplicationRecord
    has_many :pokemon_skills, dependent: :destroy
    has_many :pokemon, through: :pokemon_skills
    ELEMENT_LIST = ["Normal", "Fire", "Fighting", "Water", "Flying", "Grass", "Electric", "Psychic", "Rock", "Ice", "Bug", "Dragon", "Ghost", "Dark", "Steel", "Fairy"]
    validates :name, :presence =>true,:uniqueness => true
    validates :power, :numericality => { :greater_than => 0 }
    validates :max_pp, :numericality => { :greater_than => 0 }
    validates :element_type, :presence => true, :inclusion => { in: ELEMENT_LIST }

end
