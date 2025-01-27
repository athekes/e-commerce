class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)

    if @cart.add_cart_item(cart_item)
      flash.now[:notice] = 'Cart item added successfully'
    else
      flash.now[:alert]  = 'Cart item could not be added'
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      flash.now[:notice] = 'Cart item updated successfully'
    else
      flash.now[:alert] =  'Cart item could not be updated'
    end
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    
    if @success = @cart_item.destroy
      flash.now[:notice] = 'Cart item removed successfully'
    else
      flash.now[:alert] =  'Cart item could not be removed'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
