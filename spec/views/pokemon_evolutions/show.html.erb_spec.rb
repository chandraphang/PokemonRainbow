require 'rails_helper'

RSpec.describe "pokemon_evolutions/show", type: :view do
  before(:each) do
    @pokemon_evolution = assign(:pokemon_evolution, PokemonEvolution.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
