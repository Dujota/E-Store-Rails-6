require "rails_helper"

RSpec.describe "line_items/index", type: :view do
  before(:each) do
    @line_item1 = create(:line_item)
    @line_item2 = create(:line_item)

    assign(:line_items, [
      @line_item1,
      @line_item2,
    ])
  end

  it "renders a list of line_items" do
    render
    # 4 fields + 1 button X 2 line items
    assert_select "tr>td", count: 10
  end
end
