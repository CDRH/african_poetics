class Person < ApplicationRecord

  scope :poet, -> { where(major_african_poet: true) }

  # optional because this information is only collected for
  # major african poets, not all the people in the db
  belongs_to :gender, optional: true
  belongs_to :place_of_birth, optional: true, foreign_key: :place_of_birth_id,
    class_name: "Location"

  # foreign keys
  has_many :educations, dependent: :destroy

  # join tables
  has_and_belongs_to_many :commentaries
  has_and_belongs_to_many :events
  # country of nationality
  has_and_belongs_to_many :locations
  has_many :regions, through: :locations

  # join tables with attributes
  has_many :news_item_roles, dependent: :destroy
  has_many :news_items, through: :news_item_roles

  has_many :relationship_objects, foreign_key: :rel_object_id, class_name: "Relationship"
  has_many :subjects, through: :relationship_objects

  has_many :relationship_subjects, foreign_key: :subject_id, class_name: "Relationship"
  has_many :rel_objects, through: :relationship_subjects

  has_many :work_roles, dependent: :destroy
  has_many :works, through: :work_roles

  def es_id
    "ap.person.#{id}"
  end

  def name
    [ name_last, name_given ].compact.join(", ")
  end

  def nationalities
    locations.map(&:name)
  end

end
