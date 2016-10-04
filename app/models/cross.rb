class Cross < ApplicationRecord
  belongs_to :agent
  belongs_to :cross_type

  has_paper_trail

  scope :byuser, lambda { order("crosses.created_at DESC") }
  scope :sorted, lambda { order("created_at DESC") }
  scope :this_month, -> { where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month) }
end
