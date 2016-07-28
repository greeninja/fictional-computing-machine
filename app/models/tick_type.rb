class TickType < ApplicationRecord
  has_many :ticks
  # has_many :users, through: :ticks
end
