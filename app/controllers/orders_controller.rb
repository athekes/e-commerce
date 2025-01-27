class OrdersController < ApplicationController
  def index 
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new_order_from(cart_data: @cart.data)

    if @order.save
      @cart.destroy

      redirect_to order_path(@order), notice: 'Pedido realizado com sucesso'
    else
      redirect_to @cart, alert: @order.errors.full_messages.join(', ')
    end
  end
end
