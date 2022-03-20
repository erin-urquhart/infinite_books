class GenresController < ApplicationController
  def index
    @genres = Genre.all.order("name")
  end

  def show
    @genre = Genre.find(params[:id])
    @genrebooks = Book.select("genres.id, books.id, books.name").joins(:genres).where(
      "genre_id = ?", @genre.id.to_s
    )
  end
end
