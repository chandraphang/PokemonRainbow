class PokemonBattle < ApplicationRecord

  STATE = ["On Going", "Finish"]

  belongs_to :pokemon1, class_name: 'Pokemon'
  belongs_to :pokemon2, class_name: 'Pokemon'
  belongs_to :pokemon_winner, class_name: 'Pokemon', optional: true
  belongs_to :pokemon_loser, class_name: 'Pokemon', optional: true

  validates :state, :inclusion => { in: STATE }
  validate :pokemon1_not_pokemon2
  validate :pokemon1_hp_not_zero
  validate :pokemon2_hp_not_zero

  def pokemon1_not_pokemon2
    if self.pokemon1_id == self.pokemon2_id
      errors.add(:pokemon1_id, "can't fight itself" )
    end
  end


  def pokemon1_hp_not_zero
    if Pokemon.find(self.pokemon1_id).current_health_point <= 0
      errors.add(:pokemon1_id, "HP must above 0")
    end
  end

  def pokemon2_hp_not_zero
    if Pokemon.find(self.pokemon2_id).current_health_point <= 0
      errors.add(:pokemon2_id, "HP must above 0")
    end
  end

end