require 'rails_helper'

RSpec.describe "pokemon_evolutions/index", type: :view do
  before(:each) do
    assign(:pokemon_evolutions, [
      PokemonEvolution.create!(),
      PokemonEvolution.create!()
    ])
  end

  it "renders a list of pokemon_evolutions" do
    render
  end
end
