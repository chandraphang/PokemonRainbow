class Pokedex < ApplicationRecord
    ELEMENT_LIST = ["Normal", "Fire", "Fighting", "Water", "Flying", "Grass", "Electric", "Psychic", "Rock", "Ice", "Bug", "Dragon", "Ghost", "Dark", "Steel", "Fairy"]
    has_many :pokemons, dependent: :destroy
    validates :name, :presence =>true,:uniqueness => true
    validates :element_type, :presence => true, :inclusion => { in: ELEMENT_LIST }
    validates :base_health_point, :presence =>true,:numericality => { :greater_than => 0 }
    validates :base_attack, :presence =>true,:numericality => { :greater_than => 0 }
    validates :base_defence, :presence =>true,:numericality => { :greater_than => 0 }
    validates :base_speed, :presence =>true,:numericality => { :greater_than => 0 }
end
