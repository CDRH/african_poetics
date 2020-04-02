module InthenewsHelper

  def all_related_people(current_person)
    people = {}
    people.default = 0

    current_person.events.each do |item|
      item.people.each do |person|
        people[person] += 1
      end
    end
    current_person.news_items.each do |item|
      item.people.each do |person|
        people[person] += 1
      end
    end
    current_person.works.each do |item|
      item.people.each do |person|
        people[person] += 1
      end
    end
    current_person.educations.each do |item|
      # look for people who went to the same university
      item.university.people.each do |person|
        people[person] += 1
      end
    end

    people.delete(current_person)
    people.sort_by { |k,v| v }.reverse
  end

  def link_complex_li_item(value, count, path, query_param, default_params: {})
    label = "#{value.pluralize(count)} (#{count})"
    default_params[query_param] = value
    link_to label, send(path, default_params)
  end

  def link_search_result_item(item, attr, path)
    label = item.send(attr)
    link_to label, send(path, item)
  end

  def link_simple_li_item(assoc_rec, path)
    # check path to see if this should be linked at all
    # and if so, make sure that only poets are linked from Person
    okay_to_link = !@item.respond_to?(:poet_id) || @item.poet_id.present?
    if path && okay_to_link
      link_to assoc_rec.name, send(path, assoc_rec)
    else
      # just return a string
      assoc_rec.name
    end
  end

end
