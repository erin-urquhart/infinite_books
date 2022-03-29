class Book < ApplicationRecord
  validates :name, :author, :price_cents, presence: true
  has_one_attached :image
  has_many :item_orders
  has_many :book_genres
  has_many :genres, through: :book_genres
end
