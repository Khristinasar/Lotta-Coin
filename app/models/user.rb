class User < ApplicationRecord
  attr_accessor :email, :name, :phone
  has_many :user_coins
  has_many :coins, through: :user_coins
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 80 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

end
