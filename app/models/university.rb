class University < ApplicationRecord

  belongs_to :location
  has_many :educations
  has_many :people, through: :educations

end
