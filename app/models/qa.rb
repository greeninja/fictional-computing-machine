class Qa < ApplicationRecord
  has_many :settings
  belongs_to :ticket

  # has_paper_trail

end
