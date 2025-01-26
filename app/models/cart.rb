class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy

  def add_cart_item(new_cart_item)
    previous_cart_item = cart_items.find_by(product: new_cart_item.product)

    if previous_cart_item.present?
      previous_cart_item.quantity += new_cart_item.quantity
      previous_cart_item.save
    else
      new_cart_item.cart = self
      new_cart_item.save
    end
  end

  def total_value
    total_value_cents / 100.0
  end

  def total_value_cents
    cart_items.sum(&:total_value_cents)
  end
end
