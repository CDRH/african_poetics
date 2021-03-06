class Commentary < ApplicationRecord

  scope :featured, -> { where(featured: true) }

  has_and_belongs_to_many :commentary_authors,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_and_belongs_to_many :works,
    dependent: :destroy

  def author_credit
    commentary_authors.map { |c| c.name }.join("; ")
  end

  def es_id
    "ap.commentary.#{id}"
  end

end
