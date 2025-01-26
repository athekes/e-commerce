require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe '#total_value' do
    it 'converts total_value_cents to total_value' do
      order_item = OrderItem.new(quantity: 2, unit_price_cents: 1000)

      expect(order_item.total_value).to eq(20.0)
    end
  end

  describe '#total_value_cents' do
    it 'returns the total value of the order item' do
      order_item = OrderItem.new(quantity: 2, unit_price_cents: 1000)

      expect(order_item.total_value_cents).to eq(2000)
    end
  end
end
