class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :publisher

  has_and_belongs_to_many :commentaries,
    dependent: :destroy
  has_and_belongs_to_many :events,
    dependent: :destroy
  has_and_belongs_to_many :repositories,
    dependent: :destroy
  has_and_belongs_to_many :tags,
    dependent: :destroy
  has_and_belongs_to_many :works,
    dependent: :destroy

  has_many :news_item_roles, dependent: :destroy
  has_many :people, through: :news_item_roles

  def name
    pub = publisher ? publisher.name : ""
    "'#{article_title}', #{pub} (#{year})"
  end

end
