class Skill < ApplicationRecord
    has_many :pokemon_skills, dependent: :destroy
    has_many :pokemon, through: :pokemon_skills

    validates_presence_of :name
    validates_uniqueness_of :name
    validates :power, :numericality => { :greater_than => 0 }
    validates :max_pp, :numericality => { :greater_than => 0 }
end
