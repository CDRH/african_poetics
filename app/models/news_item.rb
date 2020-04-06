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

  def authors
    critic_roles = news_item_roles.joins(:role).where(roles: { name: "Critic" })
    authors = critic_roles.map{ |r| r.person.name }.join(", ")
    authors.blank? ? "No author" : authors
  end

  def citation
    # TODO make this logic much better, but for the sake of getting
    # something displaying on many pages, here's a sample citation format
    if date && publisher && repositories && source_access_date
      <<-TEXT
      #{authors}. "#{article_title}",
      #{publisher.name}, #{date.strftime('%d %b. %Y')},
      #{source_page_no}
      #{repositories.first.name}, #{source_link}.
      Accessed #{source_access_date.strftime('%d %b %Y')}.
      TEXT
    end
  end

  def name
    pub = publisher ? publisher.name : ""
    "'#{article_title}', #{pub} (#{year})"
  end

end
