class PokedexDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :name,
    :base_health_point,
    :base_attack,
    :base_defence,
    :base_speed,
    :element_type,
    :icon,
    :image,
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
    result.base_health_point = pokedex.base_health_point
    result.base_attack = pokedex.base_attack
    result.base_defence = pokedex.base_defence
    result.base_speed = pokedex.base_speed
    result.element_type = pokedex.element_type
    result.icon = set_icon(pokedex.image_url)
    result.image = set_image(pokedex.image_url)
    result.link_to_show = set_link_to_show(pokedex)
    result.link_to_edit = set_link_to_edit(pokedex)
    result.link_to_remove = set_link_to_remove(pokedex)

    result
  end

  def set_icon(image_url)
    image_tag image_url, :class => 'pokemon_icon'
  end

  def set_image(image_url)
    image_tag image_url, :alt => 'product_image', class: 'pokemon-image'
  end

  def set_link_to_show(pokedex)
    @context.helpers.link_to pokedex.name, pokedex
  end

  def set_link_to_edit(pokedex)
    @context.helpers.button_to 'Edit', edit_pokedex_path(pokedex), :method => "get", class: 'btn btn-warning btn-remove', id: 'custom-btn'
  end

  def set_link_to_remove(pokedex)
    @context.helpers.button_to 'Remove', pokedex, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-danger btn-remove', id: 'custom-btn'
  end
end