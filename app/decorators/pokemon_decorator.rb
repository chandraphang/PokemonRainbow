class PokemonDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :id,
    :pokedex_id,
    :name,
    :level,
    :current_health_point,
    :attack,
    :defence,
    :speed,
    :element_type,
    :current_experience,
    :image,
    :link_to_show,
    :link_to_edit,
    :link_to_remove
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(pokemons)
    results = []
    pokemons.each do |pokemon|
      results << generate_decorator_result(pokemon)
    end
    results
  end

  def decorate_for_show(pokemon)
    result = generate_decorator_result(pokemon)
    result
  end

  private

  def generate_decorator_result(pokemon)
    result = DecoratorResult.new
    result.pokedex_id = pokemon.pokedex_id
    result.id = pokemon.id
    result.name = pokemon.name
    result.level = pokemon.level
    result.current_health_point = set_current_hp(pokemon)
    result.attack = pokemon.attack
    result.defence = pokemon.defence
    result.speed = pokemon.speed
    result.element_type = set_element_type(pokemon.pokedex_id)
    result.current_experience = pokemon.current_experience
    result.image = set_image(pokemon.pokedex_id)
    result.link_to_show = set_link_to_show(pokemon)
    result.link_to_edit = set_link_to_edit(pokemon)
    result.link_to_remove = set_link_to_remove(pokemon)

    result
  end

  def set_current_hp(pokemon)
    pokemon.current_health_point.to_s + ' / ' + pokemon.max_health_point.to_s
  end

  def set_element_type(pokemon)
    Pokedex.find(pokemon).element_type
  end

  def set_image(pokemon)
    image_tag Pokedex.find(pokemon).image_url, :alt => 'Pokemon Image', class: 'pokemon-image'
  end

  def set_link_to_show(pokemon)
    @context.helpers.link_to pokemon.name, pokemon
  end

  def set_link_to_edit(pokemon)
    @context.helpers.link_to 'Edit', edit_pokemon_path(pokemon), class: 'btn btn-default btn-remove'
  end

  def set_link_to_remove(pokemon)
    @context.helpers.link_to 'Remove', pokemon, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-default btn-remove'
  end
end