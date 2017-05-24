require 'rails_helper'

RSpec.describe "pokemon_evolutions/edit", type: :view do
  before(:each) do
    @pokemon_evolution = assign(:pokemon_evolution, PokemonEvolution.create!())
  end

  it "renders the edit pokemon_evolution form" do
    render

    assert_select "form[action=?][method=?]", pokemon_evolution_path(@pokemon_evolution), "post" do
    end
  end
end
