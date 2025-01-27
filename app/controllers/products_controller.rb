class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])

    @cart_item = CartItem.new(product: @product, quantity: 1)
  end
end
