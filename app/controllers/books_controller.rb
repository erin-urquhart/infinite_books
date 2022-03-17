class BooksController < ApplicationController
  def index
    @books = Book.all
    @books = Book.order(:name).page params[:page]
  end
end
