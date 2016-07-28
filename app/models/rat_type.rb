class RatType < ApplicationRecord
  has_many :rats
  # has_many :users, through: :rats
end
