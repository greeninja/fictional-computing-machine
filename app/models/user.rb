class User < ApplicationRecord
  has_many :rats
  scope :sorted, lambda { order("users.name DESC") }
end
