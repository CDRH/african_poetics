class Publication < ApplicationRecord

  belongs_to :location, optional: true
  belongs_to :repository, optional: true
  has_many :news_items

end
