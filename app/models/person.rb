class Person < ApplicationRecord

  scope :poet, -> { where.not(poet_id: nil) }

  # foreign keys
  has_many :educations, dependent: :destroy

  # join tables
  has_and_belongs_to_many :commentaries,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :locations,
    dependent: :destroy  # nationality

  # join tables with attributes
  has_many :news_item_roles, dependent: :destroy
  has_many :news_items, through: :news_item_roles

  has_many :work_roles, dependent: :destroy
  has_many :works, through: :work_roles

  def name
    [ name_last, name_given ].compact.join(", ")
  end

  def nationalities
    locations.map(&:name).join("; ")
  end

end
