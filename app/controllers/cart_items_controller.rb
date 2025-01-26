class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)

    cart.add_cart_item(cart_item)

    render turbo_stream: turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart })
  end

  private

  def cart
    current_user.cart || current_user.create_cart
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
