class Book < ApplicationRecord
  validates :name, :author, :price_cents, presence: true
  has_one_attached :image
end
