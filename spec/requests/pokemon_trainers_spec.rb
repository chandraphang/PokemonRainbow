require 'rails_helper'

RSpec.describe "PokemonTrainers", type: :request do
  describe "GET /pokemon_trainers" do
    it "works! (now write some real specs)" do
      get pokemon_trainers_path
      expect(response).to have_http_status(200)
    end
  end
end
