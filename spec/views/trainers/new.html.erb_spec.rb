require 'rails_helper'

RSpec.describe "trainers/new", type: :view do
  before(:each) do
    assign(:trainer, Trainer.new())
  end

  it "renders new trainer form" do
    render

    assert_select "form[action=?][method=?]", trainers_path, "post" do
    end
  end
end
