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

  describe '#data' do
    it 'returns the user and cart items data' do
      user = User.create!(email: 'test@test', cpf: '123456789', password: '123123')
      cart = Cart.create!(user: user)
      product = Product.create!(
        name:           'Product',
        description:    'Description',
        price_cents:    1000,
        stock_quantity: 10
      )

      cart_item = CartItem.create!(quantity: 2, product: product, cart: cart)

      expect(cart.data).to eq({ user: user, cart_items_data: [cart_item.data] })
    end
  end
end
