class Publisher < ApplicationRecord

  belongs_to :location, optional: true
  has_many :works

end
