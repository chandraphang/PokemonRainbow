class PokemonEvolutionEngine
  def self.check_evolution?(pokemon)
    pokemon_to_check = PokemonEvolution.find_by(pokedex_from_name: pokemon.pokedex.name)
    if pokemon_to_check.present?
      if pokemon.level >= pokemon_to_check.minimum_level
        true
      else
        false
      end
    else
      false
    end
  end

  def self.add_skill!(pokemon)
    if pokemon.pokemon_skills.count < 4
      existing_pokemon_skill = pokemon.pokemon_skills
      new_skill = existing_pokemon_skill.first
      while existing_pokemon_skill.include?(new_skill)
        new_skill = Skill.where(element_type: pokemon.pokedex.element_type).sample(1).first
      end
      new_pokemon_skill = PokemonSkill.new
      new_pokemon_skill.pokemon_id = pokemon.id
      new_pokemon_skill.skill_id = new_skill.id
      new_pokemon_skill.current_pp = new_skill.max_pp
      new_pokemon_skill.save
      true
    else
      false
    end

  end

  def self.remove_and_add_skill(pokemon, old_skill, new_skill)

    old_pokemon_skill = PokemonSkill.where(pokemon_id: pokemon.id, skill_id: old_skill.id)
    PokemonSkill.destroy(old_pokemon_skill)

    new_pokemon_skill = PokemonSkill.new
    new_pokemon_skill.pokemon_id = pokemon.id
    new_pokemon_skill.skill_id = new_skill.id
    new_pokemon_skill.current_pp = new_skill.max_pp
    new_pokemon_skill.save
  end

  def self.do_evolution!(pokemon)
    pokemon_evolution = PokemonEvolution.find_by(pokedex_from_name: pokemon.pokedex.name)
    pokedex_before = Pokedex.find_by(name: pokemon_evolution.pokedex_from_name)
    pokedex_after = Pokedex.find_by(name: pokemon_evolution.pokedex_to_name)
    pokemon.pokedex_id = pokedex_after.id
    added_max_health_point = pokedex_after.base_health_point - pokedex_before.base_health_point
    added_attack = pokedex_after.base_attack - pokedex_before.base_attack
    added_defence = pokedex_after.base_defence - pokedex_before.base_defence
    added_speed = pokedex_after.base_speed - pokedex_before.base_speed
    pokemon.max_health_point += added_max_health_point
    pokemon.attack += added_attack
    pokemon.defence += added_defence
    pokemon.speed += added_speed
    pokemon.save
  end
end