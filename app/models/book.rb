class Book < ApplicationRecord
  validates :name, :author, :price_cents, presence: true
  has_one_attached :image
  has_many :book_genres
  has_many :genres, through: :book_genres

  def self.search(search)
    if search
      name = Book.where("name LIKE ?", "%#{search}%")
      if name
        where(id: name)
      else
        Book.all
      end
    else
      Book.all
    end
  end
end
