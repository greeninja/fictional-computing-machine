class User < ApplicationRecord
  has_many :rats
  has_many :ticks
  accepts_nested_attributes_for :rats, reject_if: :all_blank 
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("users.name DESC") }
end
