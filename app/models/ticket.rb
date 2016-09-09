class Ticket < ApplicationRecord

  belongs_to :agent
  has_many :qas, required: false
  has_many :mets, required: false

  has_paper_trail

end
