require 'rails_helper'

RSpec.describe "pokemon_trainers/edit", type: :view do
  before(:each) do
    @pokemon_trainer = assign(:pokemon_trainer, PokemonTrainer.create!())
  end

  it "renders the edit pokemon_trainer form" do
    render

    assert_select "form[action=?][method=?]", pokemon_trainer_path(@pokemon_trainer), "post" do
    end
  end
end
