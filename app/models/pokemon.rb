class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :pokemon_skills, dependent: :destroy
    has_many :skills, through: :pokemon_skills

    has_many :pokemon_battles
    has_many :pokemon1, class_name: 'PokemonBattle', foreign_key: 'pokemon1_id'
    has_many :pokemon2, class_name: 'PokemonBattle', foreign_key: 'pokemon2_id'
    has_many :pokemon_winner, class_name: 'PokemonBattle', foreign_key: 'pokemon_winner_id'
    has_many :pokemon_loser, class_name: 'PokemonBattle', foreign_key: 'pokemon_loser_id'

    validates :name, :presence =>true,:uniqueness => {scope: :pokedex_id}
    validates :current_experience, :numericality => { :greater_than_or_equal_to => 0 }
    validates :max_health_point, :presence =>true,:numericality => { :greater_than => 0 }
    validates :current_health_point, :presence =>true,:numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => :max_health_point }
    validates :attack, :presence =>true,:numericality => { :greater_than => 0 }
    validates :defence, :presence =>true,:numericality => { :greater_than => 0 }
    validates :speed, :presence =>true,:numericality => { :greater_than => 0 }
    validates :level, :presence =>true,:numericality => { :greater_than => 0 }
end
