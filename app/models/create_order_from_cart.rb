class CreateOrderFromCart
  private attr_reader :cart

  def initialize(cart:)
    @cart = cart
  end

  def call
    order = build_order

    ActiveRecord::Base.transaction do
      withdraw_from_stock!

      order.save!

      cart.destroy!
    end

    { success: true, order: order }
  rescue ActiveRecord::RecordInvalid => e
    { success: false, message: e.message }
  end

  private

  def build_order
    order = user.orders.build

    cart_items_data&.each do |cart_item_data|
      product          = cart_item_data[:product]
      quantity         = cart_item_data[:quantity]
      unit_price_cents = cart_item_data[:unit_price_cents]

      order.order_items.build(product:, quantity:, unit_price_cents:)
    end

    order
  end
  
  def withdraw_from_stock!
    cart_items_data&.each do |cart_item_data|
      product  = cart_item_data[:product]
      quantity = cart_item_data[:quantity]

      product.with_lock do
        product.stock_quantity -= quantity
        product.save!
      end
    end
  end

  def user
    cart_data[:user]
  end

  def cart_items_data
    cart_data[:cart_items_data]
  end

  def cart_data
    @cart.data
  end
end