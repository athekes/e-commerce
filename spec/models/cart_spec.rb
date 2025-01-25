require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end

  describe '#total_value_cents' do
    it 'returns the total value of all cart items' do
      cart = Cart.new
      cart.cart_items.new(quantity: 2, product: Product.new(price_cents: 1000))
      cart.cart_items.new(quantity: 1, product: Product.new(price_cents: 500))

      expect(cart.total_value_cents).to eq(2500)
    end
  end

  describe '#total_value' do
    it 'converts total_value_cents to total_value' do
      cart = Cart.new
      cart.cart_items.new(quantity: 2, product: Product.new(price_cents: 1000))
      cart.cart_items.new(quantity: 1, product: Product.new(price_cents: 500))

      expect(cart.total_value).to eq(25.0)
    end
  end
end
