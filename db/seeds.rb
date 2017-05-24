require 'csv'

puts 'Seeding Pokedex data ...'
pokedex_text = File.read(Rails.root.join('db', 'pokemon_rainbow', 'list_pokedex.csv'))
pokedex = CSV.parse(pokedex_text, :headers => true, :encoding => 'ISO-8859-1')
pokedex.each do |row|
  t = Pokedex.new
  t.name = row['name']
  t.base_health_point = row['base_health_point']
  t.base_attack = row['base_attack']
  t.base_defence = row['base_defence']
  t.base_speed = row['base_speed']
  t.element_type = row['element_type']
  t.image_url = row['image_url']
  t.save
 end

puts 'Seeding Skill data ...'
csv_text = File.read(Rails.root.join('db', 'pokemon_rainbow', 'list_skill.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Skill.new
  t.name = row['name']
  t.power = row['power']
  t.max_pp = row['max_pp']
  t.element_type = row['element_type']
  t.save

 end

puts 'Seeding Pokemon data ...'
pokedex_id = 1
pokedexes = Pokedex.all
pokedexes.each do |pokedex|
  u = Pokemon.new
  u.pokedex_id = pokedex_id
  u.name = pokedex['name']
  u.level = 1
  u.max_health_point = pokedex['base_health_point']
  u.current_health_point = pokedex['base_health_point']
  u.attack = pokedex['base_attack']
  u.defence = pokedex['base_defence']
  u.speed = pokedex['base_speed']
  u.current_experience = 0
  u.save
  pokedex_id += 1
end



puts 'Seeding Pokemon Skill data ...'
pokemons = Pokemon.all
pokemons.each do |pokemon|
  element_type = Pokedex.find(pokemon.id).element_type
  skills = Skill.where(element_type: element_type).sample(4)
  skills.each do |skill|
    t = PokemonSkill.new
    t.pokemon_id = pokemon.id
    t.skill_id = skill.id
    t.current_pp = skill.max_pp
    t.save
  end
end

puts 'Seeding Pokemon Evolution data ...'
csv_text = File.read(Rails.root.join('db', 'pokemon_rainbow', 'list_evolution.csv'))
pokemon_evolution = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
pokemon_evolution.each do |row|
  t = PokemonEvolution.new
  t.pokedex_from_name = row['pokedex_from_name']
  t.pokedex_to_name = row['pokedex_to_name']
  t.minimum_level = row['minimum_level']
  t.save

end