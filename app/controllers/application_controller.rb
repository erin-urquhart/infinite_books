class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private
  # this will initialize the visit counter to zero for new users
  def initialize_session
    # initialize the visit counter
    session[:shopping_cart] ||= [] # empty arry of product IDs
  end

  def cart
    # retreive a collection of products from a collection
      Book.find(session[:shopping_cart])
  end
end
