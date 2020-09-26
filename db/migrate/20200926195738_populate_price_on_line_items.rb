class PopulatePriceOnLineItems < ActiveRecord::Migration[6.0]
  def up
    # execute "UPDATE line_items li, products p SET li.price=p.price WHERE li.product_id=p.id"

    execute "UPDATE line_items SET price = products.price FROM products WHERE products.id = line_items.product_id"
  end

  def down
    LineItem.update_all("price = null")
  end
end
