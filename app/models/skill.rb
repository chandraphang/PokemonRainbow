class Skill < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :name
    validates :power, :numericality => { :greater_than => 0 }
    validates :max_pp, :numericality => { :greater_than => 0 }
end
