require 'rails_helper'

RSpec.describe "pokemon_evolutions/new", type: :view do
  before(:each) do
    assign(:pokemon_evolution, PokemonEvolution.new())
  end

  it "renders new pokemon_evolution form" do
    render

    assert_select "form[action=?][method=?]", pokemon_evolutions_path, "post" do
    end
  end
end
