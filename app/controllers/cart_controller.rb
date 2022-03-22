class CartController < ApplicationController
  def create
    logger.debug("Adding #{params[:id]} to cart. ")
    id = params[:id].to_i
    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id # push id onto the end of the cart array
      book = Book.find(id)

      flash[:notice] = "#{book.name} added to cart."
      redirect_to book_path
    end
  end

  # DELETE /cart/:id
  def destroy
    logger.debug("***Trying to delete #{params[:id]} from cart. ")
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    book = Book.find(id)
    flash[:notice] = "#{book.name} removed from cart."
    redirect_to book_path
  end
end
