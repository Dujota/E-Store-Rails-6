require "rails_helper"

RSpec.describe "line_items/show", type: :view do
  before(:each) do
    @line_item = create(:line_item)
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/#{@line_item.product.id}/)
    expect(rendered).to match(/#{@line_item.cart.id}/)
  end
end
