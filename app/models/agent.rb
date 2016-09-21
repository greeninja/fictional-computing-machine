class Agent < ApplicationRecord

  belongs_to :team
  has_many :users
  has_many :rats
  has_many :ticks
  has_many :tickets
  has_many :qas, :through => :tickets

  has_paper_trail

  validates_uniqueness_of :customid

  accepts_nested_attributes_for :rats, :ticks, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("agents.customid ASC") }
  scope :uniq_team_id, lambda { select('DISTINCT(team_id)') }


  def full_name
    "#{name} #{last_name}"
  end

end
