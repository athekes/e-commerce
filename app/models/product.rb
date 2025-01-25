class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def price
    price_cents / 100.0
  end
end
