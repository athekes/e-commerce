class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total_value
    total_value_cents / 100.0
  end

  def total_value_cents
    quantity * product.price_cents
  end

  def data
    {
      product:           product,
      quantity:          quantity,
      unit_price_cents:  product.price_cents
    }
  end
end
