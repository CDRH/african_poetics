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
    # remove any where there are <= 2 connections
    people = people.reject { |k,v| v <= 2 }
    people.sort_by { |k,v| v }.reverse
  end

  def link_complex_li_item(value, count, path, query_param, default_params: {})
    value = "Unknown" if value.nil?
    label = "#{value} (#{count})"
    default_params[query_param] = value
    link_to label, send(path, default_params)
  end

  def link_search_result_item(item, attr, path)
    label = item.send(attr)
    link_to label, send(path, item)
  end

  def link_simple_li_item(record, path)
    # check path to see if this should be linked at all
    # and if so, make sure that only poets are linked from Person
    okay_to_link = !@item.respond_to?(:major_african_poet) || @item.major_african_poet.present?
    if path && okay_to_link
      link_to record.name, send(path, { id: record.es_id })
    else
      # just return a string
      record.name
    end
  end

  def news_item_role(ni_role)
    if ni_role && ni_role.role.present?
      ni_role.role.name
    else
      t "item.unknown_role"
    end
  end

  def search_result_item_field(item, field, label)
    # need to account for nested field
    if field.include?(".")
      field1 = field.split(".")[0]
      field2 = field.split(".")[1]
      #need to account for field1 being an array
      if item[field1].present? 
        if item[field1].class == Array
          matching_item = item[field1].collect { |ele| ele[field2] }
          list = matching_item if matching_item
        elsif item[field1].class == Hash
          if item[field1][field2]
            list = item[field1][field2].class == Array ? item[field1][field2] : [item[field1][field2]]
          end
        end
      end
    elsif item[field].present?
      list = item[field].class == Array ? item[field] : [item[field]]
    end
    if list
      render partial: "partials/search_res_item_field",
          locals: { label: label, list: list }
    end
  end

  def word_cloud_count(count)
    if count.class == Hash && count["num"]
      count = count["num"].to_i
      case count
      when 1..3
        "smallest"
      when 4..8
        "small"
      when 9..15
        "medium"
      when 16..25
        "large"
      else
        "largest"
      end
    end
  end

  # provide a back link, either to the main "in the news" landing page
  # or to the individual section home (poets, events, works, etc)
  def section_back_link
    # the main landing page for inthenews does not need a back link
    if @section == "inthenews" && params[:action] == "home"
      ""
    elsif ["home", "about", "about_credits", "visualizations", "bibliographies"].include?(params[:action])
      link_to "← back to African Poets and Poetry in the News home",
        :inthenews_home,
        class: "back-link"
    else
      link_to "← back to #{section_label} home",
        send("#{@section}_path"),
        class: "back-link"
    end
  end

  # because inthenewsx is the pattern of all our in the news
  # sections, we can use that to get a label
  def section_label
    type = @section.sub("inthenews", "")
    if type == "newsitems"
      type = "news"
    elsif type == "index_of_poets"
      type = "index of poets"
    end
    type.titleize if type
  end
end
