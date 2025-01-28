class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart

  protected

  # Allow additional parameters for sign up and account update
  def configure_permitted_parameters
    added_attrs = [:cpf, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_cart
    return unless user_signed_in?

    @cart = current_user.cart || current_user.create_cart
  end

  def current_cart
    @cart
  end
end
