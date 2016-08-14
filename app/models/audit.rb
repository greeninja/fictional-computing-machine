class Audit < ApplicationRecord
  self.table_name = "versions"

  scope :sorted, lambda { order("versions.created_at DESC") }

end
