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
    people.where(work_roles: { author: true })
  end

  def author_roles
    work_roles.where(author: true)
  end

  def es_id
    "ap.work.#{id}"
  end

  def name
    "#{title} (#{year})"
  end

end
