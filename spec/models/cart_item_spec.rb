require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }

    describe 'validations' do
      describe 'stock_availability' do
        it 'adds an error if the quantity is greater than the product stock quantity' do
          product = Product.new(
            name:           'Product',
            description:    'Description',
            price_cents:    1000,
            stock_quantity: 10
          )
  
          cart_item = CartItem.new(quantity: 11, product: product)
          
          expect(cart_item).to be_invalid
          expect(cart_item.errors.full_messages).to include('Quantidade adicionada ao carrinho não está disponível em estoque')
        end
      end
    end
  end

  describe '#total_value_cents' do
    it 'returns the total value of the cart item' do
      product   = Product.new(price_cents: 1000)
      cart_item = CartItem.new(quantity: 2, product: product)

      expect(cart_item.total_value_cents).to eq(2000)
    end
  end

  describe '#total_value' do
    it 'converts total_value_cents to total_value' do
      product   = Product.new(price_cents: 1000)
      cart_item = CartItem.new(quantity: 2, product: product)

      expect(cart_item.total_value).to eq(20.0)
    end
  end

  describe '#data' do
    it 'returns the cart item data' do
      product   = Product.new(price_cents: 1000)
      cart_item = CartItem.new(quantity: 2, product: product)

      expect(cart_item.data).to eq(
        {
          product:           product,
          quantity:          2,
          unit_price_cents:  1000
        }
      )
    end
  end
end
