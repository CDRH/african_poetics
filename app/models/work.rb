class Work < ApplicationRecord

  belongs_to :location, optional: true
  belongs_to :publisher, optional: true
  belongs_to :work_type, optional: true

  has_many :work_roles, dependent: :destroy
  has_many :people, through: :work_roles

  has_and_belongs_to_many :commentaries,
    dependent: :destroy
  has_and_belongs_to_many :news_items,
    dependent: :destroy

  has_one :region, through: :location

  def authors
    all_people = Person
      .joins(work_roles: :role)
      .where(work_roles: { work_id: id })
      .where(roles: { name: ["Author", "Poet"]})
      .distinct
  end

  def es_id
    "ap.work.#{id}"
  end

  def name
    "#{title} (#{year})"
  end

end
