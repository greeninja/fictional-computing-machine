class Ticket < ApplicationRecord

  belongs_to :agent
  has_many :qas
  has_many :mets

  has_paper_trail
  accepts_nested_attributes_for :qas, allow_destroy: true, reject_if: :all_blank
end
