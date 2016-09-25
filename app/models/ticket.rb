class Ticket < ApplicationRecord

  belongs_to :agent
  has_many :qas
  has_many :mets

  # has_paper_trail :only => [:feedback]
  accepts_nested_attributes_for :qas, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :ticket_reference, :date
  validates_uniqueness_of :ticket_reference, :scope => :agent_id

end
