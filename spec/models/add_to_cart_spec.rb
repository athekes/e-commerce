require 'rails_helper'

RSpec.describe AddToCart, type: :model do
  describe '#call' do
    it 'adds a cart item to the cart' do
      user    = User.create!(email: 'test@test', cpf: '123456789', password: '123456')
      cart    = Cart.create!(user: user)
      product = Product.create!(
        name:           'Product',
        description:    'Description',
        price_cents:    1000,
        stock_quantity: 10
      )

      result = AddToCart.new(
        cart: cart,
        cart_item_params: { 
          quantity: 1,
          product_id: product.id 
        }
      ).call
      
      expect(result[:success]).to eq(true)

      expect(cart.cart_items.count).to eq(1)
      expect(cart.cart_items.first.product).to eq(product)
      expect(cart.cart_items.first.quantity).to eq(1)
    end

    it 'increments the quantity of an existing cart item' do
      user    = User.create!(email: 'test@test', cpf: '123456789', password: '123456')
      cart    = Cart.create!(user: user)
      product = Product.create!(
        name:           'Product',
        description:    'Description',
        price_cents:    1000,
        stock_quantity: 10
      )

      existing_cart_item = cart.cart_items.create!(quantity: 2, product: product)

      result = AddToCart.new(
        cart: cart,
        cart_item_params: { 
          quantity: 1,
          product_id: product.id 
        }
      ).call

      expect(result[:success]).to eq(true)
      expect(existing_cart_item.reload.quantity).to eq(3)
    end

    it 'returns an error message if the cart item is invalid' do
      user    = User.create!(email: 'test@test', cpf: '123456789', password: '123456')
      cart    = Cart.create!(user: user)
      product = Product.create!(
        name:           'Product',
        description:    'Description',
        price_cents:    1000,
        stock_quantity: 10
      )

      result = AddToCart.new(
        cart: cart,
        cart_item_params: { 
          quantity: 11,
          product_id: product.id 
        }
      ).call

      expect(result[:success]).to eq(false)
      expect(result[:message]).to include('Quantidade adicionada ao carrinho não está disponível em estoque')
    end
  end
end