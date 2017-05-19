require "rails_helper"

RSpec.describe PokemonTrainersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pokemon_trainers").to route_to("pokemon_trainers#index")
    end

    it "routes to #new" do
      expect(:get => "/pokemon_trainers/new").to route_to("pokemon_trainers#new")
    end

    it "routes to #show" do
      expect(:get => "/pokemon_trainers/1").to route_to("pokemon_trainers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pokemon_trainers/1/edit").to route_to("pokemon_trainers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pokemon_trainers").to route_to("pokemon_trainers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pokemon_trainers/1").to route_to("pokemon_trainers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pokemon_trainers/1").to route_to("pokemon_trainers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pokemon_trainers/1").to route_to("pokemon_trainers#destroy", :id => "1")
    end

  end
end
