class Province < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :gst, :pst, :hst, numericality: true
end
