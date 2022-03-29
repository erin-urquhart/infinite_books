class CartController < ApplicationController
  def create
    puts "START"
    puts session[:shopping_cart]
    item = { id: params[:id].to_i, quantity: params[:quantity].to_i }
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    found_id = false
    session[:shopping_cart].each do |cart|
      if cart['id'] == id
        item['quantity']
        cart['quantity'] = cart['quantity'] + quantity
        found_id = true
        if cart['quantity'] < 1
          session[:shopping_cart].delete(cart)
        end
      end
    end
    if !found_id
      session[:shopping_cart] << item
    end
    redirect_to books_path
  end

  def show
    # retreive a collection of products from a collection
    id_list = []
    @qty = []
    session[:shopping_cart].each do |item|
      id_list << item['id']
      @qty << item['quantity']
    end
    print id_list
    print @qty
    @books = Book.find(id_list)
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete_if { |item| item['id'] == id }
    redirect_to books_path
  end
end
