class CartItemsController < ApplicationController
  def create
    result = AddToCart.new(cart: current_cart, cart_item_params:).call

    if result[:success]
      flash.now[:notice] = 'Item do carrinho adicionado com sucesso'
    else
      flash.now[:alert] = result[:message]
    end
  end

  def update
    @cart_item = current_cart.cart_items.find(params[:id])

    if @success = @cart_item.update(cart_item_params)
      flash.now[:notice] = 'Item do carrinho atualizado com sucesso'
    else
      flash.now[:alert] =  @cart_item.errors.full_messages.join(', ')
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    
    if @success = @cart_item.destroy
      flash.now[:notice] = 'Item do carrinho removido com sucesso'
    else
      flash.now[:alert] = 'Item do carrinho não pôde ser removido'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
