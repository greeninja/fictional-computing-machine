class Qa < ApplicationRecord
  has_many :settings
  belongs_to :ticket

  before_create :add_ticket

  # has_paper_trail

  def add_ticket
    new_ticket = Ticket.new(params[:ticket_reference, :date, :agent_id, :score, :notes])

    unless new_ticket.save
      self.errors.add(:base, "Couldn't create ticker.")
      return false
    end

    self.ticket_id = new_ticket.id
  end

end
