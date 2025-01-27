class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)

    if cart.add_cart_item(cart_item)
      flash.now[:notice] = 'Cart item added successfully'

      render turbo_stream: [
        turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart }),
        turbo_stream.replace('flash', partial: 'shared/flash'),
      ]
    else
      flash.now[:alert] = 'Cart item could not be added'

      render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
    end
  end

  def update
    cart_item = cart.cart_items.find(params[:id])

    if cart_item.update(cart_item_params)
      flash.now[:notice] = 'Cart item updated successfully'

      render turbo_stream: [
        turbo_stream.replace(cart_item),
        turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart }),
        turbo_stream.replace('cart_total', partial: 'carts/cart_total', locals: { cart: cart }),
        turbo_stream.replace('flash', partial: 'shared/flash'),
      ]
    else
      flash.now[:alert] = 'Cart item could not be updated'

      render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
    end
  end

  def destroy
    cart_item = cart.cart_items.find(params[:id])

    if cart_item.destroy
      flash.now[:notice] = 'Cart item removed successfully'

      render turbo_stream: [
        turbo_stream.remove(cart_item),
        turbo_stream.replace(cart, partial: 'carts/min_cart', locals: { cart: cart }),
        turbo_stream.replace('cart_total', partial: 'carts/cart_total', locals: { cart: cart }),
        turbo_stream.replace('flash', partial: 'shared/flash'),
      ]
    else
      flash.now[:alert] = 'Cart item could not be removed'

      render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash')
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
