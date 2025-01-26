class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)

    cart.add_cart_item(cart_item)

    render turbo_stream: turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart })
  end

  def update
    cart_item = cart.cart_items.find(params[:id])

    if cart_item.update(cart_item_params)
      render turbo_stream: [
        turbo_stream.replace(cart_item),
        turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart }),
        turbo_stream.replace('cart_total', partial: 'carts/cart_total', locals: { cart: cart }),
      ]
    end
  end

  def destroy
    cart_item = cart.cart_items.find(params[:id])

    if cart_item.destroy
      render turbo_stream: [
        turbo_stream.remove(cart_item),
        turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart }),
        turbo_stream.replace('cart_total', partial: 'carts/cart_total', locals: { cart: cart }),
      ]
    end
  end

  private

  def cart
    current_user.cart || current_user.create_cart
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
