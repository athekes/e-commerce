class OrdersController < ApplicationController
  def index 
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create  
    result = CreateOrderFromCart.new(cart: current_cart).call

    if result[:success]
      redirect_to order_path(result[:order]), notice: 'Pedido realizado com sucesso'
    else
      redirect_to current_cart, alert: result[:message]
    end
  end
end
