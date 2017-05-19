require 'rails_helper'

RSpec.describe "trainers/edit", type: :view do
  before(:each) do
    @trainer = assign(:trainer, Trainer.create!())
  end

  it "renders the edit trainer form" do
    render

    assert_select "form[action=?][method=?]", trainer_path(@trainer), "post" do
    end
  end
end
