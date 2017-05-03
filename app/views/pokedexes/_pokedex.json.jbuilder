json.extract! pokedex, :id, :created_at, :updated_at
json.url pokedex_url(pokedex, format: :json)
