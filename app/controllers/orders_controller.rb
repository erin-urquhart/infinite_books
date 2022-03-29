class OrdersController < ApplicationController
  @orders = Order.includes(:user)
end
