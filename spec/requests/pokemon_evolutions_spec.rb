require 'rails_helper'

RSpec.describe "PokemonEvolutions", type: :request do
  describe "GET /pokemon_evolutions" do
    it "works! (now write some real specs)" do
      get pokemon_evolutions_path
      expect(response).to have_http_status(200)
    end
  end
end
