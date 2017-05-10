class PokemonSkillDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :pokemon_id,
    :skill_id,
    :current_pp,
    :link_to_show,
    :link_to_remove
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(pokemon_skills)
    results = []
    pokemon_skills.each do |pokemon_skill|
      results << generate_decorator_result(pokemon_skill)
    end
    results
  end

  def decorate_for_show(pokemon_skill)
    result = generate_decorator_result(pokemon_skill)
    result
  end

  private

  def generate_decorator_result(pokemon_skill)
    if pokemon_skill.present?
      result = DecoratorResult.new
      result.pokemon_id = pokemon_skill.pokemon_id
      result.skill_id = pokemon_skill.skill_id
      result.current_pp = pokemon_skill.skill
      result.link_to_show = set_link_to_show(pokemon_skill.skill)
      result.link_to_remove = set_link_to_remove(pokemon_skill)
      result
    else
      nil
    end
  end

  def set_link_to_show(skill)
    @context.helpers.link_to skill.name, skill
  end

  def set_link_to_remove(pokemon_skill)
    @context.helpers.link_to 'Remove', pokemon_skill, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-default btn-remove'
  end
end