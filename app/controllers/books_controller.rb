class BooksController < ApplicationController
  def index
    @books = Book.all
    @books = Book.order(:name).page params[:page]

  end

  def search
    if params[:search].blank?
      redirect_to books_path and return
    else
      @parameter = params[:search].downcase
      @results = Book.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
    end
  end

  def show
    @book = Book.find(params[:id])
    @bookgenres = Genre.select("books.id, genres.id, genres.name").joins(:books).where(
      "book_id = ?", @book.id.to_s
    )
  end

  def book_params
    params.require(:book).permit(:name, :id, :author, :description, :publisher, :publication_year,
                                 :search)
  end
end
