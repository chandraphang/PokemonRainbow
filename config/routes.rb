Rails.application.routes.draw do
  resources :pokemon_battles
  resources :pokemon_skills
  resources :pokemons do
    post 'create_pokemon_skill'
    post 'delete_pokemon_skill/:skill_id', to: 'pokemons#delete_pokemon_skill', as: 'delete_pokemon_skill'
  end
  resources :pokedexes
  resources :skills

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pokedexes#home'
end
