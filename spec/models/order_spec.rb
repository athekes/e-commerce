require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end

  describe 'validations' do
    describe 'order_items_present' do
      it 'is valid when order_items are present' do
        order = Order.new(user: User.new)
        order.order_items.new(product: Product.new, quantity: 2, unit_price_cents: 1000)

        expect(order).to be_valid
      end

      it 'is invalid when order_items are not present' do
        order = Order.new(user: User.new)

        expect(order).to be_invalid
        expect(order.errors[:order_items]).to include('devem estar presentes')
      end
    end
  end

  describe '#total_value' do
    it 'converts total_value_cents to total_value' do
      order = Order.new
      order.order_items.new(quantity: 2, unit_price_cents: 1000)
      order.order_items.new(quantity: 1, unit_price_cents: 500)

      expect(order.total_value).to eq(25.0)
    end
  end

  describe '#total_value_cents' do
    it 'returns the total value of all order items' do
      order = Order.new
      order.order_items.new(quantity: 2, unit_price_cents: 1000)
      order.order_items.new(quantity: 1, unit_price_cents: 500)

      expect(order.total_value_cents).to eq(2500)
    end
  end
end
