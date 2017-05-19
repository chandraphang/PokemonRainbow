class PokemonTrainer < ApplicationRecord
  belongs_to :trainer
  belongs_to :pokemon

  validates :pokemon_id, presence: true, uniqueness: true
  validates :trainer_id, presence: true
  validate :pokemon_ammount_not_greater_than_five, on: :create
  def pokemon_ammount_not_greater_than_five
    if trainer.pokemon_trainers.count < 5
        true
    else
        false
        errors.add(:pokemon_id, "Trainer Already Have 5 Pokemons" )
    end
  end
end
