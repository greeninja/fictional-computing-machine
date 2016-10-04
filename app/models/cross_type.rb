class CrossType < ApplicationRecord

  has_paper_trail
  has_many :crosses
  scope :sorted, lambda { order("cross_types.name ASC") }

end
