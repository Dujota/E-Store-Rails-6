class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def decrement_quantity
    self.quantity -= 1
    if self.quantity <= 0
      self.destroy!
    else
      self.save
    end
  end
end
