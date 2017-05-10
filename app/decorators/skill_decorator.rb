class SkillDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :name,
    :power,
    :max_pp,
    :element_type,
    :link_to_show,
    :link_to_edit,
    :link_to_remove
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(pokedexes)
    results = []
    pokedexes.each do |pokedex|
      results << generate_decorator_result(pokedex)
    end
    results
  end

  def decorate_for_show(pokedex)
    result = generate_decorator_result(pokedex)
    result
  end

  private

  def generate_decorator_result(pokedex)
    result = DecoratorResult.new
    result.name = pokedex.name
    result.power = pokedex.power
    result.max_pp = pokedex.max_pp
    result.element_type = pokedex.element_type
    result.link_to_show = set_link_to_show(pokedex)
    result.link_to_edit = set_link_to_edit(pokedex)
    result.link_to_remove = set_link_to_remove(pokedex)

    result
  end

  def set_link_to_show(pokedex)
    @context.helpers.link_to pokedex.name, pokedex
  end

  def set_link_to_edit(pokedex)
    @context.helpers.link_to 'Edit', edit_pokedex_path(pokedex), class: 'btn btn-default btn-remove'
  end

  def set_link_to_remove(pokedex)
    @context.helpers.link_to 'Remove', pokedex, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-default btn-remove'
  end
end