class QaGeneralSetting < ApplicationRecord

  belongs_to :team, required: false
  has_paper_trail
  validates_uniqueness_of :name, :scope => :team_id

end
