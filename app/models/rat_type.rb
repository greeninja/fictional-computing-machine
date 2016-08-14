class RatType < ApplicationRecord

  has_paper_trail

  has_many :rats
  # has_many :users, through: :rats
  scope :sorted, lambda { order("rat_types.name ASC") }
end
