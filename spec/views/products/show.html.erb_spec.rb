require "rails_helper"

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      title: "Title",
      description: "MyText",
      image_url: "crystal.jpg",
      price: "9.99",
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/crystal/)
    expect(rendered).to match(/9.99/)
  end
end
