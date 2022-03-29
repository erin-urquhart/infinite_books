class Order < ApplicationRecord
  belongs_to :user
  has_many :item_orders
  validates :total, :taxes, :status, presence: true
  validates :total, :taxes, numericality: true
end
