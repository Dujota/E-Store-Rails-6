FactoryBot.define do
  factory :product do
    sequence :title do |n|
      "Title#{n}"
    end

    description { "MyText" }
    image_url { "crystal.jpg" }
    price { "9.99" }
  end
end
