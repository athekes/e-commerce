class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new_order_from(cart_data: @cart.data)

    if @order.save
      @cart.destroy

      redirect_to order_path(@order)      
    end
  end
end
