class QaSetting < ApplicationRecord

  belongs_to :team, required: false

  has_paper_trail

  scope :sorted, lambda { order("qa_settings.position ASC") }

end
