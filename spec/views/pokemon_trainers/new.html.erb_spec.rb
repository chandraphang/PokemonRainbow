require 'rails_helper'

RSpec.describe "pokemon_trainers/new", type: :view do
  before(:each) do
    assign(:pokemon_trainer, PokemonTrainer.new())
  end

  it "renders new pokemon_trainer form" do
    render

    assert_select "form[action=?][method=?]", pokemon_trainers_path, "post" do
    end
  end
end
