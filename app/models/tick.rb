class Tick < ApplicationRecord
  belongs_to :user
  belongs_to :tick_type

  scope :byuser, lambda { order("ticks.created_at DESC") }
  scope :sorted, lambda { order("created_at DESC") }
  scope :this_month, -> { where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month) }

end
