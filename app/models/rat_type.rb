class RatType < ApplicationRecord
  has_many :rats
  # has_many :users, through: :rats
  scope :sorted, lambda { order("rat_types.name ASC") }
end
