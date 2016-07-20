class User < ApplicationRecord
  has_many :rats
  has_many :ticks
    accepts_nested_attributes_for :rats, :ticks, allow_destroy: true, reject_if: :all_blank 
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("users.name ASC") }
  scope :sorted_by_id, lambda { order("users.id ASC") }
end
