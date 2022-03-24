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

  def search
    query = "%#{params[:keywords]}%"
    genre = params[:genre_id].to_s
    @books = if genre == ""
                  Book.where("name LIKE ?", query,
                                ).order("name").page(params[:page]).per(4)
                else
                  Book.where("name LIKE ?", query).where(
                    "genre_id LIKE ?", genre
                  ).order("name").page(params[:page]).per(4)
                end
  end

end
