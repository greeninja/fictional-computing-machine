class Skill < ApplicationRecord

  has_paper_trail

  has_many :agents

end
