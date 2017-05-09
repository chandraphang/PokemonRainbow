class Pokemon < ApplicationRecord
    belongs_to :pokedex
    has_many :pokemon_skills, dependent: :destroy
    has_many :skills, through: :pokemon_skills

    validates :name, :presence =>true,:uniqueness => {scope: :pokedex_id}
    validates :current_experience, :numericality => { :greater_than_or_equal_to => 0 }
    validates :max_health_point, :presence =>true,:numericality => { :greater_than => 0 }
    validates :current_health_point, :presence =>true,:numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => :max_health_point }
    validates :attack, :presence =>true,:numericality => { :greater_than => 0 }
    validates :defence, :presence =>true,:numericality => { :greater_than => 0 }
    validates :speed, :presence =>true,:numericality => { :greater_than => 0 }
    validates :level, :presence =>true,:numericality => { :greater_than => 0 }
end
