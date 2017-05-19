class PokemonTrainerDecorator
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
    :link_to_remove
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(pokemon_trainers)
    results = []
    pokemon_trainers.each do |pokemon_trainer|
      results << generate_decorator_result(pokemon_trainer)
    end
    results
  end

  private

  def generate_decorator_result(pokemon_trainer)
    result = DecoratorResult.new
    result.pokedex_id = pokemon_trainer.pokedex_id
    result.id = pokemon_trainer.id
    result.name = pokemon_trainer.name
    result.level = pokemon_trainer.level
    result.current_health_point = set_current_hp(pokemon_trainer)
    result.attack = pokemon_trainer.attack
    result.defence = pokemon_trainer.defence
    result.speed = pokemon_trainer.speed
    result.element_type = set_element_type(pokemon_trainer.pokedex_id)
    result.current_experience = pokemon_trainer.current_experience
    result.image = set_image(pokemon_trainer.pokedex_id)
    result.link_to_show = set_link_to_show(pokemon_trainer)
    result.link_to_remove = set_link_to_remove(pokemon_trainer)
    result
  end

  def set_current_hp(pokemon_trainer)
    pokemon_trainer.current_health_point.to_s + ' / ' + pokemon_trainer.max_health_point.to_s
  end

  def set_element_type(pokemon_trainer)
    Pokedex.find(pokemon_trainer).element_type
  end

  def set_image(pokemon_trainer)
    image_tag Pokedex.find(pokemon_trainer).image_url, :alt => 'Pokemon Image', class: 'pokemon-image'
  end

  def set_link_to_show(pokemon_trainer)
    @context.helpers.link_to pokemon_trainer.name, pokemon_trainer
  end

  def set_link_to_remove(pokemon_trainer)
    @context.helpers.button_to 'Remove', trainer_delete_pokemon_trainer_path( pokemon_trainer.trainer.id,  pokemon_trainer.id ), :method => 'post', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-danger btn-remove', id: 'custom-btn'
  end

end