class PokemonSkill < ApplicationRecord
    belongs_to :pokemon
    belongs_to :skill
    validates :skill_id,:uniqueness => {scope: :pokemon_id}
    validate :current_pp_should_be_less_or_equal_to_max_pp


    def current_pp_should_be_less_or_equal_to_max_pp
        skill = Skill.find(self.skill_id)
        if self.current_pp > skill.max_pp
            errors.add(:current_pp, 'should be less than or equal than Max PP')
        elsif self.current_pp < 0
            errors.add(:current_pp, 'should be greater than 0')
        end

    end
end
