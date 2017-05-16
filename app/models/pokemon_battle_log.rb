class PokemonBattleLog < ApplicationRecord
  belongs_to :pokemon_battle
  belongs_to :skill, class_name: 'Skill', optional: true
  belongs_to :attacker, class_name: 'Pokemon'
  belongs_to :defender, class_name: 'Pokemon'

end
