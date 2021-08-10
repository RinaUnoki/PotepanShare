class User < ApplicationRecord
  attachment :image_name
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true  
end
