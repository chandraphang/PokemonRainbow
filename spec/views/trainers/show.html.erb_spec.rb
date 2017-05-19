require 'rails_helper'

RSpec.describe "trainers/show", type: :view do
  before(:each) do
    @trainer = assign(:trainer, Trainer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
