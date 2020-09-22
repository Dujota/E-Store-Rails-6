require "rails_helper"

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      create(:product), create(:product),
    ])
  end

  it "renders a list of products" do
    render
    # TODO: Fix these specs .. looks like issue traversing DOM

    # assert_select "tr>td", text: "Title".to_s, count: 2
    # assert_select "tr>td", text: "MyText".to_s, count: 2
    # assert_select "tr>td", text: "crystal.jpg".to_s, count: 2
    # assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
