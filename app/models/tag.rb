class Tag < ApplicationRecord

  has_and_belongs_to_many :news_items,
  #   dependent: :destroy

end