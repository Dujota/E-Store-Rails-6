require "rails_helper"

RSpec.describe "Stores", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get store_index_url
      expect(response).to have_http_status(:success)

      # Req spec dont test ui
      # assert_select "nav.side_nav a", minimum: 4
      # assert_select "main ul.catalog li", 3
      # assert_select "h2", "Programming Ruby 1.9"
      # assert_select ".price", /\$[,\d]+\.\d\d/
    end

    it "renders :index" do
      get store_index_url
      expect(response).to render_template :new

      # Req spec dont test ui
      # assert_select "nav.side_nav a", minimum: 4
      # assert_select "main ul.catalog li", 3
      # assert_select "h2", "Programming Ruby 1.9"
      # assert_select ".price", /\$[,\d]+\.\d\d/
    end
  end
end
