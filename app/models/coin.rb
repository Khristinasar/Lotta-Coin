class Coin < ApplicationRecord
  has_many :users, through: :user_coins
end
