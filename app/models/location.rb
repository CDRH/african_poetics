class Location < ApplicationRecord

  belongs_to :region

  # nationality
  has_and_belongs_to_many :people,
    dependent: :destroy
  has_many :events
  has_many :universities

  def name
    [ country, city ].compact.join(", ")
  end

end
