class PokemonBattleLogDecorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper

  DecoratorResult = Struct.new(
    :turn,
    :skill,
    :attacker,
    :current_health_point_attacker,
    :damage,
    :defender,
    :current_health_point_defender,
    :action_type
  )

  def initialize(context)
    @context = context
  end

  def decorate_for_index(battle_logs)
    results = []
    battle_logs.each do |battle_log|
      results << generate_decorator_result(battle_log)
    end
    results
  end

  private

  def generate_decorator_result(battle_log)
    result = DecoratorResult.new
    result.turn = battle_log.turn
    result.attacker = battle_log.attacker.name
    if battle_log.skill_id.present?
      result.skill = battle_log.skill.name
    else
      result.skill = '-'
    end
    result.current_health_point_attacker = set_current_health_attacker(battle_log, battle_log.attacker)
    result.current_health_point_defender = set_current_health_defender(battle_log, battle_log.defender)
    if battle_log.damage.present?
      result.damage = battle_log.damage
    else
      result.damage = '-'
    end

    result.defender = battle_log.defender.name
    result.action_type = battle_log.action_type
    result
  end

  def set_current_health_attacker(battle_log, pokemon_attacker)
    battle_log.attacker_current_health_point.to_s + ' / ' + pokemon_attacker.max_health_point.to_s
  end

  def set_current_health_defender(battle_log, pokemon_defender)
    battle_log.defender_current_health_point.to_s + ' / ' + pokemon_defender.max_health_point.to_s
  end

end