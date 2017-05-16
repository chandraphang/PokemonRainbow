class Skill < ApplicationRecord
  has_many :pokemon_skills, dependent: :destroy
  has_many :pokemon, through: :pokemon_skills
  has_many :pokemon_battle_logs, class_name: 'PokemonBattleLog', foreign_key: 'skill_id', dependent: :destroy
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

  validates :name, :presence =>true,:uniqueness => true
  validates :power, :numericality => { :greater_than => 0 }
  validates :max_pp, :numericality => { :greater_than => 0 }

  end
