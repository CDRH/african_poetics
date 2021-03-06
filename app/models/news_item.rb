class NewsItem < ApplicationRecord
  include Dates

  belongs_to :news_item_type
  belongs_to :publication

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
    people.where(news_item_roles: { author: true })
  end

  def author_roles
    news_item_roles.where(author: true)
  end

  def citation
    # TODO make this logic much better, but for the sake of getting
    # something displaying on many pages, here's a sample citation format
    cit = ""

    a = authors.map { |p| p.name }.join("; ")
    # formatting if there are authors
    if a.present?
      cit = "#{a}. "
    end

    if article_title
      cit += "\"#{article_title}\", "
    end

    if publication
      cit += "#{publication.name}, "
    end

    if date
      cit += "#{date.strftime('%d %b. %Y')}, "
    end

    if source_page_no
      cit += "#{source_page_no} "
    end

    if repositories && repositories.first
      cit += "#{repositories.first.name}, "
    end

    if source_link
      best_link = sanitize_source_link
      cit += "<a href=\"#{best_link}\">#{best_link}</a>. "
    end

    if source_access_date
      cit += "Accessed #{source_access_date.strftime('%d %b. %Y')}."
    end
    cit
  end

  def es_id
    "ap.news.#{id}"
  end

  def name
    pub = publication ? publication.name : ""
    "'#{article_title}', #{pub} (#{year})"
  end

  private

  def sanitize_source_link
    # many of the Gale links have return characters / new lines / spaces in them
    # which means they are not valid links, so attempt to patch that up here
    URI.parse(source_link)
    source_link
  rescue => e
    no_space = source_link.strip
    no_space.gsub(/[\n\r]/, "")
  end

end
