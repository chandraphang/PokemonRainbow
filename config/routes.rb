Rails.application.routes.draw do
  resources :pokemon_evolutions
  resources :pokemon_trainers
  resources :trainers do
    post 'create_pokemon_trainer'
    post 'delete_pokemon_trainer/:pokemon_trainer_id', to: 'trainers#delete_pokemon_trainer', as: 'delete_pokemon_trainer'
  end
  resources :pokemon_battles do
    patch 'attack'
    patch 'surrender'
    get 'battle_with_ai'
    get 'check_evolution'
    post 'do_evolution'
    get 'replace_skill'
    post 'remove_and_add_random_skill'
    post 'do_remove_and_add_random_skill'
    get 'evolve_done'
    get 'show_pokemon_battle_log'
  end
  resources :pokemon_skills
  resources :pokemons do
    get 'heal_one'
    get 'heal_all', on: :collection
    post 'create_pokemon_skill'
    post 'delete_pokemon_skill/:skill_id', to: 'pokemons#delete_pokemon_skill', as: 'delete_pokemon_skill'
  end
  resources :pokedexes
  resources :skills
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pokedexes#home'
end
