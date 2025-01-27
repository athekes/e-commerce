class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(cart_item_params)

    if @cart.add_cart_item(cart_item)
      flash.now[:notice] = 'Item do carrinho adicionado com sucesso'
    else
      flash.now[:alert]  = 'Item do carrinho não pôde ser adicionado'
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      flash.now[:notice] = 'Item do carrinho atualizado com sucesso'
    else
      flash.now[:alert] =  'Item do carrinho não pôde ser atualizado'
    end
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    
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
