require "african_poetics/elasticsearch"
require "african_poetics/index"
require "african_poetics/index_person"
require "african_poetics/svg"

namespace :african_poetics do

  desc "creates documents and posts information to Elasticsearch"
  task index: :environment do
    es = Elasticsearch.new()
    Person.all.each do |person|
      IndexPerson.new(person, es).post
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
