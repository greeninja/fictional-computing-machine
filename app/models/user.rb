class User < ApplicationRecord

  belongs_to :team
  has_many :rats
  has_many :ticks

  accepts_nested_attributes_for :rats, :ticks, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("users.customid ASC") }
  scope :uniq_team_id, lambda { select('DISTINCT(team_id)') }

end
