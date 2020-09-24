require "rails_helper"

RSpec.describe Product, type: :model do
  OK_image_urls = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg​http://a.b.c/x/y/z/fred.gif}

  BAD_image_urls = %w{fred.doc fred.gif/more fred.gif.more}

  let(:invalid_product) {
    build(:product, title: nil,
                    description: nil,
                    image_url: nil,
                    price: nil)
  }

  let(:bad_price_value) { build(:product, price: "some text") }
  let(:bad_price_amount) { build(:product, price: 0.001) }

  it "product attributes must not be empty" do
    invalid_product.valid?
    expect(invalid_product.errors[:image_url].size).to eq(1)
    expect(invalid_product.errors[:title].size).to eq(1)
    expect(invalid_product.errors[:description].size).to eq(1)
    expect(invalid_product.errors[:price].size).to eq(1)
  end

  it "is invalid with a duplicate title" do
    create(:product, title: "new product")
    duplicate_title = build(:product, title: "new product")

    expect(duplicate_title).to be_invalid
  end

  context "validates the numeracity of the price field" do
    it "is invalid without a numerical value on price" do
      bad_price_value.valid?
      expect(bad_price_value.errors[:title].size).to eq 0
      expect(bad_price_value.errors[:price].size).to eq 1
    end

    it "is not valid with a value below 0.01" do
      bad_price_amount.valid?
      expect(bad_price_amount.errors[:price].size).to eq 1
    end
  end

  context "validates filetype extension" do
    it "it is invalid when wrong filetype given" do
      BAD_image_urls.each do |image_url|
        new_product = build(:product, image_url: image_url)
        expect(new_product.valid?).to be false
        expect(new_product.errors[:image_url].size).to eq(1)
      end
    end

    it "is valid when correct image_url file extension given" do
      OK_image_urls.each do |image_url|
        new_product = build(:product, image_url: image_url)
        expect(new_product.valid?).to be true
        expect(new_product.errors[:image_url].size).to eq(0)
      end
    end
  end
end
