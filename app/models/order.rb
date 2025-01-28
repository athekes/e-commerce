class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validate :order_items_present

  enum :status, pending: 0, paid: 1, shipped: 2, cancelled: 3

  def total_value
    total_value_cents / 100.0
  end

  def total_value_cents
    order_items.sum(&:total_value_cents)
  end

  private

  def order_items_present
    errors.add(:order_items, 'devem estar presentes')if order_items.empty?
  end
end
