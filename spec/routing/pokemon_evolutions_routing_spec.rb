require "rails_helper"

RSpec.describe PokemonEvolutionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pokemon_evolutions").to route_to("pokemon_evolutions#index")
    end

    it "routes to #new" do
      expect(:get => "/pokemon_evolutions/new").to route_to("pokemon_evolutions#new")
    end

    it "routes to #show" do
      expect(:get => "/pokemon_evolutions/1").to route_to("pokemon_evolutions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pokemon_evolutions/1/edit").to route_to("pokemon_evolutions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pokemon_evolutions").to route_to("pokemon_evolutions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pokemon_evolutions/1").to route_to("pokemon_evolutions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pokemon_evolutions/1").to route_to("pokemon_evolutions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pokemon_evolutions/1").to route_to("pokemon_evolutions#destroy", :id => "1")
    end

  end
end
