class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate  :stock_availability

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

  private

  def stock_availability
    return unless quantity.present? && product.present?

    errors.add(:quantity, 'adicionada ao carrinho não está disponível em estoque') if quantity > product.stock_quantity
  end
end
