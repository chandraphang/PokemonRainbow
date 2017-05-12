class Pokedex < ApplicationRecord
  extend Enumerize

  ELEMENT_LIST = [
    :normal,
    :fire,
    :fighting,
    :water,
    :flying,
    :grass,
    :electric,
    :psychic,
    :rock,
    :ice,
    :bug,
    :dragon,
    :ghost,
    :dark,
    :steel,
    :fairy
  ].freeze

  enumerize :element_type, in: ELEMENT_LIST

  has_many :pokemons, dependent: :destroy
  validates :name, :presence =>true,:uniqueness => true
  validates :base_health_point, :presence =>true,:numericality => { :greater_than => 0 }
  validates :base_attack, :presence =>true,:numericality => { :greater_than => 0 }
  validates :base_defence, :presence =>true,:numericality => { :greater_than => 0 }
  validates :base_speed, :presence =>true,:numericality => { :greater_than => 0 }
end
