class Skill < ApplicationRecord
  has_many :pokemon_skills, dependent: :destroy
  has_many :pokemon, through: :pokemon_skills

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
  # ELEMENT_LIST = ["Normal", "Fire", "Fighting", "Water", "Flying", "Grass", "Electric", "Psychic", "Rock", "Ice", "Bug", "Dragon", "Ghost", "Dark", "Steel", "Fairy"].freeze

  enumerize :element_type, in: ELEMENT_LIST

    # ELEMENT_LIST = ["Normal", "Fire", "Fighting", "Water", "Flying", "Grass", "Electric", "Psychic", "Rock", "Ice", "Bug", "Dragon", "Ghost", "Dark", "Steel", "Fairy"]
    validates :name, :presence =>true,:uniqueness => true
    validates :power, :numericality => { :greater_than => 0 }
    validates :max_pp, :numericality => { :greater_than => 0 }
    validates :element_type, :presence => true, :inclusion => { in: ELEMENT_LIST }

  end
