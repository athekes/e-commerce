class AddToCart
  private attr_reader :cart, :quantity, :product_id

  def initialize(cart:, cart_item_params:)
    @cart       = cart
    @quantity   = cart_item_params[:quantity].to_i
    @product_id = cart_item_params[:product_id].to_i
  end

  def call
    if previous_cart_item
      previous_cart_item.quantity += quantity
      previous_cart_item.save!
    else
      cart_items.create!(
        quantity: quantity,
        product:  product,
      )
    end

    { success: true }
  rescue ActiveRecord::RecordInvalid => e
    { success: false, message: e.message }
  end

  private

  def previous_cart_item
    @previous_cart_item ||= cart_items.find_by(product: product)
  end

  def product
    @product ||= Product.find(@product_id)
  end

  def cart_items
    @cart.cart_items
  end
end
