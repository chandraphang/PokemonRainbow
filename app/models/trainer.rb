class Trainer < ApplicationRecord
  has_many :pokemon_trainers, dependent: :destroy
  has_many :pokemon, through: :pokemon_trainers

  validates :name, presence: true
  validates :email, presence: true, uniqueness:  true
  validates :password, presence: true
end
