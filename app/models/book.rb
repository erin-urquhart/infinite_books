class Book < ApplicationRecord
  validates :name, :author, :price_cents, presence: true
  validates :price_cents, numericality: true
  validates :publication_year, :isbn, numericality: {allow_nil: true}
  has_one_attached :image
  has_many :item_orders
  has_many :book_genres
  has_many :genres, through: :book_genres
end
