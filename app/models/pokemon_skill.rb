class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
    validates :skill_id, presence: true, uniqueness: {scope: :pokemon_id}
    validates :pokemon_id, presence: true
    validates :current_pp, presence: true, numericality:  { greater_than_or_equal_to:  0 }, if: 'skill_present'
    validate :current_pp_must_less_or_equal_to_max_pp, if: 'skill_present'
    validate :skill_ammount_not_greater_than_four, if: 'skill_and_pokemon_present', on: :create

    def skill_present
        skill.present?
    end

    def skill_and_pokemon_present
        pokemon.present? and skill.present?
    end

    def current_pp_must_less_or_equal_to_max_pp
        if current_pp.present?
            if current_pp <= skill.max_pp
                true
            else
                false
                errors.add(:current_pp, "Current PP Shouldn't Greater Than Max PP" )
            end
        end

    end

    def skill_ammount_not_greater_than_four
        if pokemon.pokemon_skills.count < 5
            true
        else
            false
            errors.add(:skill_id, "Pokemon Already Have 4 Moves" )
        end
    end

end
