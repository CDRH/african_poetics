require "african_poetics/elasticsearch"
require "african_poetics/index"
require "african_poetics/index_event"
require "african_poetics/index_news_item"
require "african_poetics/index_person"
require "african_poetics/index_work"
require "african_poetics/svg"

namespace :african_poetics do

  desc "creates documents and posts information to Elasticsearch"
  task index: :environment do
    es = Elasticsearch.new()
    Event.all.each do |event|
      IndexEvent.new(event, es).post
    end
    NewsItem.all.each do |item|
      IndexNewsItem.new(item, es).post
    end
    Person.poet.each do |person|
      IndexPerson.new(person, es).post
    end
    Work.all.each do |work|
      IndexWork.new(work, es).post
    end

  end

  desc "clears Elasticsearch index of this collection + category"
  task index_clear: :environment do
    es = Elasticsearch.new()
    es.clear
  end

  desc "Modifies an SVG with countries of Africa to carry regional information instead"
  task region_map: :environment do
    Svg.modify_map
  end

end
