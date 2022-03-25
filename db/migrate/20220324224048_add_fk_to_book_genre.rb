class AddFkToBookGenre < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :book_genres, :books
    remove_foreign_key :book_genres, :genres
  end
end
