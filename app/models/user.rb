class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :province
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def username
    return self.email.split('@')[0].capitalize
  end
end
