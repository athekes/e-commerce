class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy

  def total_value
    total_value_cents / 100.0
  end

  def total_value_cents
    cart_items.sum(&:total_value_cents)
  end

  def data
    { user: user, cart_items_data: cart_items.map(&:data) }
  end
end
