class Pokedex < ApplicationRecord
    has_many :pokemons, dependent: :destroy
    validates_presence_of :name
    validates_uniqueness_of :name
    validates_presence_of :base_health_point
    validates_presence_of :base_attack
    validates_presence_of :base_defence
    validates_presence_of :base_speed
    validates_presence_of :element_type
    validates_presence_of :image_url
end
