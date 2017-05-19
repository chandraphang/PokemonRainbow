require 'rails_helper'

RSpec.describe "trainers/index", type: :view do
  before(:each) do
    assign(:trainers, [
      Trainer.create!(),
      Trainer.create!()
    ])
  end

  it "renders a list of trainers" do
    render
  end
end
