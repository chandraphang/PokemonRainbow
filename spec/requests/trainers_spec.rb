require 'rails_helper'

RSpec.describe "Trainers", type: :request do
  describe "GET /trainers" do
    it "works! (now write some real specs)" do
      get trainers_path
      expect(response).to have_http_status(200)
    end
  end
end
