class AddNameToBookGenre < ActiveRecord::Migration[7.0]
  def change
    add_column :book_genres, :name, :string
  end
end
