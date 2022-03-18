class BooksController < ApplicationController
  def index
    @books = Book.all
    @books = Book.order(:name).page params[:page]
  end

  def show
    @book = Book.find(params[:id])
    @bookgenres = Genre.select("books.id, genres.id, genres.name").joins(:books).where(
      "book_id = ?", @book.id.to_s
    )
  end
end
