class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def total_value
    total_value_cents / 100.0
  end

  def total_value_cents
    quantity * unit_price_cents
  end
end
