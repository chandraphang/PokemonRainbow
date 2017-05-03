class Skill < ApplicationRecord
    validates_numericality_of :power
    validates_numericality_of :max_pp
    validates :power, :numericality => { :greater_than => 0 }
    validates :max_pp, :numericality => { :greater_than => 0 }
end
