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
          puts "FOUND"
          session[:shopping_cart].delete(cart)
        end
      end
    end
    if !found_id
      session[:shopping_cart] << item
    end
    redirect_to books_path

    # if session[:shopping_cart].include?(session[:shopping_cart][id])
    #   puts "FOUND"
    #   session[:shopping_cart].each do |cart|
    #     if cart['id'] == id
    #       item['quantity']
    #       cart['quantity'] = cart['quantity'] + quantity
    #       puts "MIDDLE"
    #       puts session[:shopping_cart]
    #     end
    #   end
    # else
    #   session[:shopping_cart] << item # push id onto the end of the cart array
    # end
    # #session[:shopping_cart].delete_if { |check| (check['quantity'] < 1) && (puts check['quantity']) }
    # puts "END"
    # puts session[:shopping_cart]

    # redirect_to books_path
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
