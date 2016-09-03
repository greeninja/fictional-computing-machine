class QaSetting < ApplicationRecord

  belongs_to :team

  has_paper_trail

  scope :sorted, lambda { order("qa_settings.qa ASC") }

end
