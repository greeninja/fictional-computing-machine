class Qa < ApplicationRecord

  has_many :settings
  belongs_to :ticket

  validates_presence_of :score, :ticket_id, :out_of, :qa_setting_id

  accepts_nested_attributes_for :ticket, reject_if: :all_blank

end
