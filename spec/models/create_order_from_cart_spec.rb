require 'rails_helper'

RSpec.describe CreateOrderFromCart do
  describe '#call' do
    it 'creates an order from the cart data' do
      user = User.create!(
        email:    'test@test',
        cpf:      '123456789', 
        password: '123456'
      )
      product = Product.create!(
        name:          'Product',
        description:   'Description',
        price_cents:    1000,
        stock_quantity: 10
      )

      cart = Cart.create!(user: user)
      cart_item = cart.cart_items.create!(
        product:          product, 
        quantity:         2
      )

      result = CreateOrderFromCart.new(cart:).call

      expect(result[:success]).to eq(true)
      expect(result[:order].user).to eq(user)
      expect(result[:order].order_items.first.product).to eq(product)
      expect(result[:order].order_items.first.quantity).to eq(cart_item.quantity)
      expect(result[:order].order_items.first.unit_price_cents).to eq(product.price_cents)
      expect(product.reload.stock_quantity).to eq(8)
    end
  end
end
