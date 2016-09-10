class Ticket < ApplicationRecord

  belongs_to :agent
  has_many :qas
  has_many :mets

  has_paper_trail

end
