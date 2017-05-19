require 'rails_helper'

RSpec.describe "pokemon_trainers/index", type: :view do
  before(:each) do
    assign(:pokemon_trainers, [
      PokemonTrainer.create!(),
      PokemonTrainer.create!()
    ])
  end

  it "renders a list of pokemon_trainers" do
    render
  end
end
