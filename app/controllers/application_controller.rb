class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :cart

  private
  def initialize_session
    # initialize the cart
    session[:shopping_cart] ||= [] # empty arry of product IDs
  end

  def cart
    # retreive a collection of products from a collection
    id_list = []
    session[:shopping_cart].each do |item|
      id_list << item['id']
    end
    Book.find(id_list)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address])

  end
end
