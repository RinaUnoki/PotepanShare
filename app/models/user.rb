class User < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true  
end
