class CartController < ApplicationController
  def create
    item = { id: params[:id].to_i, quantity: params[:quantity].to_i }
    id = params[:id].to_i
    unless session[:shopping_cart].include?(session[:shopping_cart][id - 1])
      session[:shopping_cart] << item # push id onto the end of the cart array
      redirect_to books_path
    end
  end

  def show
    # retreive a collection of products from a collection
    id_list = []
    @qty = []
    session[:shopping_cart].each do |item|
      id_list << item['id']
      @qty << item['quantity']
    end
    @books = Book.find(id_list)
  end

  # DELETE /cart/:id
  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete_if { |item| item['id'] == id }
    redirect_to books_path
  end
end
