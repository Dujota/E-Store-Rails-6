require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/line_items", type: :request do
  # LineItem. As you add validations to LineItem, be sure to
  # adjust the attributes here as well.

  before :each do
    @line_item = create(:line_item, price: product.price)
  end

  let(:product) { create(:product) }
  let(:valid_attributes) {
    {
      product_id: product.id,
    }
  }

  let(:invalid_attributes) {
    {
      product_id: nil,
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      get line_items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get line_item_url(@line_item)
      expect(response).to be_successful
      expect(response).to render_template :show
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_line_item_url
      expect(response).to be_successful
      expect(response).to render_template :new
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_line_item_url(@line_item)
      expect(response).to be_successful
      expect(response).to render_template :edit
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new LineItem" do
        expect {
          post line_items_url, params: { **valid_attributes }
        }.to change(LineItem, :count).by(1)
      end

      it "redirects to the cart the line_item was created at" do
        post line_items_url, params: { **valid_attributes }
        expect(response).to redirect_to(cart_url(Cart.last))

        follow_redirect!

        assert_select "h2", "Shopping Cart"
        assert_select "tr.line-item", 1
        assert_select "td.quantity", "1"
        assert_select "td.product-title", "#{product.title}"
      end
    end

    context "with invalid parameters" do
      it "does not create a new LineItem" do
        expect {
          post line_items_url, params: { **invalid_attributes }
        }.to change(LineItem, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post line_items_url, params: { **invalid_attributes }
        expect(response).to redirect_to(cart_url(Cart.last))
        follow_redirect!

        assert_select "h2", "Shopping Cart"
        assert_select "li.line-item", 0
        assert_select "aside#notice", "Unable to add the product to cart"
      end
    end

    context "with duplicate products" do
      it "adds to the quantity of existing line item in cart" do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart_id: @line_item.cart_id } }

        new_product = create(:product)
        line_item_in_cart = create(:line_item, cart_id: @line_item.cart_id, quantity: 5, price: new_product.price, product_id: new_product.id)

        # duplicate line item added to cart
        post line_items_url, params: { product_id: new_product.id }
        expect(response).to redirect_to(cart_url(@line_item.cart))

        follow_redirect!

        assert_select "h2", "Shopping Cart"
        assert_select "tr.line-item", 2
        assert_select "td.quantity", "6"
      end
    end
  end

  describe "PATCH /update" do
    before :each do
      @new_product = create(:product)
    end

    context "with valid parameters" do
      let(:new_attributes) {
        { product_id: @new_product.id }
      }

      it "updates the requested line_item" do
        patch line_item_url(@line_item), params: { line_item: new_attributes }
        @line_item.reload

        expect(@line_item.product.id).to eq @new_product.id
      end

      it "redirects to the shopping cart" do
        patch line_item_url(@line_item), params: { line_item: new_attributes }
        @line_item.reload
        expect(response).to redirect_to(cart_url(Cart.last))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch line_item_url(@line_item), params: { line_item: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested line_item" do
      expect {
        delete line_item_url(@line_item)
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to the shopping cart" do
      delete line_item_url(@line_item)
      expect(response).to redirect_to(cart_url(Cart.last))
    end
  end
end
