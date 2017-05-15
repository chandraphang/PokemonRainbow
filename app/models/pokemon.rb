class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :pokemon_skills, dependent: :destroy
    has_many :skills, through: :pokemon_skills
    has_many :pokemon_battles
    has_many :pokemon1, class_name: 'PokemonBattle', foreign_key: 'pokemon1_id', dependent: :destroy
    has_many :pokemon2, class_name: 'PokemonBattle', foreign_key: 'pokemon2_id', dependent: :destroy
    has_many :pokemon_winner, class_name: 'PokemonBattle', foreign_key: 'pokemon_winner_id', dependent: :destroy
    has_many :pokemon_loser, class_name: 'PokemonBattle', foreign_key: 'pokemon_loser_id', dependent: :destroy


    validates :name, :presence =>true,:uniqueness => true, if: ':pokedex_present'
    validates :current_experience, :numericality => { :greater_than_or_equal_to => 0 }, if: 'pokedex_present'
    validates :max_health_point, :presence =>true,:numericality => { :greater_than => 0 }, if: 'pokedex_present'
    validates :current_health_point, :presence =>true,:numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => :max_health_point }, if: 'pokedex_present'
    validates :attack, :presence =>true,:numericality => { :greater_than => 0 }, if: 'pokedex_present'
    validates :defence, :presence =>true,:numericality => { :greater_than => 0 }, if: 'pokedex_present'
    validates :speed, :presence =>true,:numericality => { :greater_than => 0 }, if: 'pokedex_present'
    validates :level, :presence =>true,:numericality => { :greater_than => 0 }, if: 'pokedex_present'

    def pokedex_present
        if !:pokedex.present?
            false
        end
    end
end
