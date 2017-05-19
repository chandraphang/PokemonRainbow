class PokemonBattle < ApplicationRecord

  STATE = ["On Going", "Finish"].freeze
  BATTLE_TYPE = ['Manual Battle', 'Battle With AI', 'Auto Battle'].freeze
  belongs_to :pokemon1, class_name: 'Pokemon'
  belongs_to :pokemon2, class_name: 'Pokemon'
  belongs_to :pokemon_winner, class_name: 'Pokemon', optional: true
  belongs_to :pokemon_loser, class_name: 'Pokemon', optional: true
  has_many :pokemon_battle_logs, dependent: :destroy

  validates :pokemon1_id, presence: true
  validates :pokemon2_id, presence: true
  validates :current_turn, presence: true, numericality:  { greater_than:  0 }
  validates :state, presence: true
  validates :experience_gain, numericality: { greater_than_or_equal_to:  0 }, if: 'experience_gain_present'
  validates :pokemon1_max_health_point, numericality: { greater_than:  0 }, if: 'pokemon1_present'
  validates :pokemon2_max_health_point, numericality: { greater_than:  0 }, if: 'pokemon2_present'
  validates :state, :inclusion => { in: STATE }
  validates :battle_type, :inclusion => { in: BATTLE_TYPE }
  validate :pokemon1_not_pokemon2, if: 'pokemon1_present' and 'pokemon2_present'
  validate :pokemon1_hp_not_zero, on: :create, if: 'pokemon1_present'
  validate :pokemon2_hp_not_zero, on: :create, if: 'pokemon2_present'
  validate :pokemon_winner_must_between_pokemon1_and_pokemon2, if: 'pokemon_winner_present'
  validate :pokemon_winner_must_empty_before_finish, if: 'battle_on_going'
  validate :pokemon_loser_must_empty_before_finish, if: 'battle_on_going'

  def battle_on_going
    state == 'On Going'
  end

  def pokemon_winner_must_empty_before_finish
    if pokemon_winner_id.present?
      errors.add(:pokemon1_id, "pokemon winner has not known yet" )
    end
  end

  def pokemon_loser_must_empty_before_finish
    if pokemon_loser_id.present?
      errors.add(:pokemon1_id, "pokemon loser has not known yet" )
    end
  end

  def pokemon_winner_present
    pokemon_winner_id.present?
  end

  def pokemon1_present
    pokemon1.present?
  end

  def pokemon2_present
    pokemon2.present?
  end

  def experience_gain_present
    experience_gain.present?
  end

  def pokemon1_not_pokemon2
      if pokemon1_id == pokemon2_id
        errors.add(:pokemon1_id, "can't fight itself" )
      end
  end


  def pokemon1_hp_not_zero
      if pokemon1.current_health_point <= 0
        errors.add(:pokemon1_id, "HP must above 0")
      end
  end


  def pokemon2_hp_not_zero
      if pokemon2.current_health_point <= 0
        errors.add(:pokemon2_id, "HP must above 0")
      end
  end

  def pokemon_winner_must_between_pokemon1_and_pokemon2
    if pokemon_winner_id == pokemon1_id  || pokemon_winner_id == pokemon2_id
      true
    else
      false
      errors.add(:pokemon1_id, "Pokemon Winner Must Between Pokemon 1 or Pokemon 2")
    end
  end

end
