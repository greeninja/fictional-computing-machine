class User < ApplicationRecord
  has_many :rats
  accepts_nested_attributes_for :rats, reject_if: :all_blank 
  scope :sorted, lambda { order("users.name DESC") }
end
