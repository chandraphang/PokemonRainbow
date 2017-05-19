class PokemonBattleDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :pokemon1_id,
    :pokemon2_id,
    :pokemon1,
    :pokemon2,
    :current_turn,
    :battle_type,
    :state,
    :pokemon_winner_id,
    :pokemon_loser_id,
    :experience_gain,
    :image_pokemon1,
    :image_pokemon2,
    :current_hp_pokemon1,
    :current_hp_pokemon2,
    :link_to_pokemon1,
    :link_to_pokemon2,
    :link_to_pokemon_winner,
    :link_to_pokemon_loser,
    :link_to_edit,
    :link_to_remove,
    :link_to_pokemon_battle_log
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(pokemon_battles)

    results = []
    pokemon_battles.each do |pokemon_battle|
      results << generate_decorator_result(pokemon_battle)
    end
    results
  end

  def decorate_for_show(pokemon_battle)
    result = generate_decorator_result(pokemon_battle)
    result
  end

  private

  def generate_decorator_result(pokemon_battle)
    if pokemon_battle.present?

      result = DecoratorResult.new
      result.pokemon1_id = pokemon_battle.pokemon1_id
      result.pokemon2_id = pokemon_battle.pokemon2_id
      result.pokemon1 = set_pokemon_name(pokemon_battle.pokemon1)
      result.pokemon2 = set_pokemon_name(pokemon_battle.pokemon2)
      result.current_turn = pokemon_battle.current_turn
      result.pokemon_winner_id = pokemon_battle.pokemon_winner_id
      result.pokemon_loser_id = pokemon_battle.pokemon_loser_id
      result.experience_gain = pokemon_battle.experience_gain
      result.image_pokemon1 = set_image(pokemon_battle.pokemon1)
      result.image_pokemon2 = set_image(pokemon_battle.pokemon2)
      result.current_hp_pokemon1 = set_current_hp(pokemon_battle.pokemon1)
      result.current_hp_pokemon2 = set_current_hp(pokemon_battle.pokemon2)
      result.link_to_pokemon1 = set_link_to_pokemon1(pokemon_battle)
      result.link_to_pokemon2 = set_link_to_pokemon2(pokemon_battle)
      result.link_to_edit = set_link_to_edit(pokemon_battle)
      result.link_to_pokemon_battle_log = set_link_to_pokemon_battle_log(pokemon_battle)
      result.link_to_remove = set_link_to_remove(pokemon_battle)
      result.state = pokemon_battle.state
      result.battle_type = pokemon_battle.battle_type
      if pokemon_battle.pokemon_winner.present?
        result.link_to_pokemon_winner = set_link_to_pokemon_winner_or_loser(Pokemon.find(pokemon_battle.pokemon_winner_id))
        result.link_to_pokemon_loser = set_link_to_pokemon_winner_or_loser(Pokemon.find(pokemon_battle.pokemon_loser_id))
      else
        result.link_to_pokemon_winner = '-'
        result.link_to_pokemon_loser = '-'
      end

      result
    else
      nil
    end
  end

  def set_pokemon_winner(pokemon_winner_id)
    Pokemon.find(pokemon_winner_id).name
  end

  def set_pokemon_loser(pokemon_loser_id)
    Pokemon.find(pokemon_loser_id).name
  end

  def set_pokemon_name(pokemon)
    Pokemon.find(pokemon).name
  end

  def set_current_hp(pokemon)
    pokemon.current_health_point.to_s + ' / ' + pokemon.max_health_point.to_s
  end

  def set_link_to_pokemon_battle_log(pokemon_battle)
    @context.helpers.link_to "Show Log", pokemon_battle_show_pokemon_battle_log_path(pokemon_battle),:method => 'get',class: 'btn btn-default btn-remove'
  end

  def set_link_to_pokemon_winner_or_loser(pokemon)
    @context.helpers.link_to pokemon.name, pokemon
  end

  def set_link_to_pokemon1(pokemon_battle)
    @context.helpers.link_to pokemon_battle.pokemon1.name, pokemon_battle
  end

  def set_link_to_pokemon2(pokemon_battle)
    @context.helpers.link_to pokemon_battle.pokemon2.name, pokemon_battle
  end

  def set_image(pokemon)
    image_tag pokemon.pokedex.image_url, :alt => 'product_image', class: 'pokemon-image img-center'
  end

  def set_link_to_show(pokemon_battle)
    @context.helpers.link_to 'Show', pokemon_battle, class: 'btn btn-default btn-remove'
  end

  def set_link_to_edit(pokemon_battle)
    @context.helpers.link_to 'Edit', edit_pokemon_battle_path(pokemon_battle), class: 'btn btn-default btn-remove', id: 'custom-btn'
  end

  def set_link_to_remove(pokemon_battle)
    @context.helpers.link_to 'Remove', pokemon_battle, :method => 'delete', data: {confirm: 'Are you sure you want to delete it?'}, class: 'btn btn-default btn-remove' , id: 'custom-btn'
  end
end