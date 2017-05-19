require 'rails_helper'

RSpec.describe "pokemon_trainers/show", type: :view do
  before(:each) do
    @pokemon_trainer = assign(:pokemon_trainer, PokemonTrainer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
