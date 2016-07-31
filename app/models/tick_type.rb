class TickType < ApplicationRecord
  has_many :ticks
  # has_many :users, through: :ticks
  scope :sorted, lambda { order("tick_types.name ASC") }
end
