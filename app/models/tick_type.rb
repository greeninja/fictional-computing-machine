class TickType < ApplicationRecord
  has_many :ticks

  has_paper_trail

  scope :sorted, lambda { order("tick_types.name ASC") }
end
