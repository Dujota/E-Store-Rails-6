require "rails_helper"

RSpec.describe "Stores", type: :request do
  before :each do
    @product = create(:product)
    @product2 = create(:product)
    @product3 = create(:product)
  end

  describe "GET /index" do
    it "returns http success" do
      get store_index_url
      expect(response).to have_http_status(:success)
    end

    it "renders :index" do
      get store_index_url
      expect(response).to render_template :index

      assert_select "nav.side_nav a", minimum: 4
      assert_select "main ul.catalog li", 3
      assert_select "h2", "#{@product.title}"
      assert_select ".price", /\$[,\d]+\.\d\d/
    end
  end
end
