class InthenewsController < ApplicationController

  def home
    @title = "African Poets in the News"
  end

  ################
  # COMMENTARIES #
  ################

  def commentary
    @item = Commentary.find(params[:id])
    @title = @item.name
  end

  def commentaries
    @title = "Commentaries"
    @poets = Person.poet.joins(:commentaries)
      .group("name_last", "name_given")
      .count
  end

  def search_commentaries
    @title = "Commentary Search"
    items = Commentary.all
    if params[:person].present?
      last, given = params[:person]
      @person = Person.find_by(name_last: last, name_given: given)
      items = items.joins(:people)
        .where(people: {
            name_last: last, name_given: given
        })
    end
    if params[:q].present?
      items = text_query_commentary(items, params[:q])
    end
    @items = items.paginate(page: params[:page])
  end

  ##########
  # EVENTS #
  ##########

  def event
    @item = Event.find(params[:id])
    @title = @item.name
  end

  def events
    @title = "Events"
    @event_types = Event
      .joins(:event_type)
      .group("event_types.name")
      .count
    @regions = Event
      .joins(:region)
      .group("regions.name")
      .count
    # decade calculated with syntax found here:
    # https://stackoverflow.com/a/22224123/4154134
    @decades = Event
      .order(date_not_before: :asc)
      .group("FLOOR(year(date_not_before)/10)*10")
      .count
  end

  def search_events
    @title = "Event Search"
    items = Event.all
    if params[:decade].present?
      items = decade_search(items, "date_not_before")
    end
    if params[:event_type].present?
      items = items.joins(:event_type)
        .where(event_types: { name: params[:event_type] })
    end
    if params[:person].present?
      @person = Person.find(params[:person])
      items = items.joins(:people)
        .where(people: { id: params[:person] })
    end
    if params[:region].present?
      items = items.joins(:region)
        .where(regions: { name: params[:region] })
    end
    if params[:q].present?
      items = text_query_event(items, params[:q])
    end
    @items = items.paginate(page: params[:page])
  end

  ##############
  # NEWS ITEMS #
  ##############

  def news_item
    @item = NewsItem.find(params[:id])
    @title = @item.name
  end

  # /news links here
  def news_items
    @title = "News"
    @news_item_types = NewsItemType
      .joins(:news_items)
      .group(:name)
      .count
    @decades = NewsItem
      .order(date: :asc)
      .group("FLOOR(year(date)/10)*10")
      .count
  end

  def search_news_items
    @title = "News Search"
    items = NewsItem.all
    if params[:decade].present?
      items = decade_search(items, "date")
    end
    if params[:news_type].present?
      items = items.joins(:news_item_type)
        .where(news_item_types: { name: params[:news_type] })
    end
    if params[:person].present?
      @person = Person.find(params[:person])
      items = items.joins(:people)
        .where(people: { id: params[:person] })
    end
    if params[:q].present?
      items = text_query_news_item(items, params[:q])
    end
    @items = items.paginate(page: params[:page])
  end

  #########
  # POETS #
  #########

  def poet
    @item = Person.find(params[:id])
    @title = @item.name
    # get list of news item types (not count)
    # NewsItemType.joins(news_items: :people).where(news_items: { people: { id: 1 }})
    @news_items = NewsItem.joins(:people)
        .where(people: { id: params[:id] })
        .joins(:news_item_type)
        .group("news_item_types.name")
        .count
    # TODO will need to redo this if event_type is its own table
    @events = Event.joins(:event_type, :people)
        .where(people: { id: params[:id] })
        .group("event_types.name")
        .count
    @works = Work.joins(:people)
        .where(people: { id: params[:id] })
        .joins(:work_type)
        .group("work_types.name")
        .count
  end

  def poets
    @title = "Poets"
    @regions = Person
      .poet
      .joins(:regions)
      .group("regions.name")
      .count
  end

  def search_poets
    @title = "Poet Search"
    items = Person.poet
    if params[:letter].present?
      items = items
        .where("name_last LIKE (?)", "#{params[:letter]}%")
    end
    if params[:region].present?
      items = items
        .joins(:regions)
        .where(regions: { name: params[:region] })
    end
    if params[:q].present?
      items = text_query_poet(items, params[:q])
    end
    @items = items.paginate(page: params[:page])
  end

  #########
  # WORKS #
  #########

  def work
    @item = Work.find(params[:id])
    @title = @item.name
  end

  def works
    @title = "Works"
    @decades = Work
      .order(year: :asc)
      .group("FLOOR(year/10)*10")
      .count
    @regions = Work
      .joins(:region)
      .group("regions.name")
      .count
    @work_types = Work.joins(:work_type)
      .group("work_types.name")
      .count
  end

  def search_works
    @title = "Work Search"
    items = Work.all

    if params[:decade].present?
      items = decade_search(items, "year", field_type: "integer")
    end
    if params[:person].present?
      @person = Person.find(params[:person])
      items = items.joins(:work_roles)
        .where(work_roles: {
          person_id: params[:person],
          role: Role.find_by(name: "Poet")
        })
    end
    if params[:q].present?
      items = text_query_work(items, params[:q])
    end
    if params[:region].present?
      items = items.joins(:region)
        .where(regions: { name: params[:region] })
    end
    if params[:work_type].present?
      items = items.joins(:work_type)
        .where(work_types: { name: params[:work_type] })
    end

    @items = items.paginate(page: params[:page])
  end

  private

  def decade_search(items, date_field, field_type: "date")
    if params[:decade] == "Unknown"
      items
        .where(date_field => nil)
    elsif field_type == "date"
      start = Date.new(params[:decade].to_i)
      finish = Date.new(params[:decade].to_i)+10.year-1.day
      items
        .where(date_field => start..finish)
    else
      # assume this is an integer field YYYY
      start = params[:decade].to_i
      finish = start + 9
      items
        .where(date_field => start..finish)
    end
  end

  def text_query(items, fields, query)
    text = fields.join(" LIKE :search OR ")
    text += " LIKE :search"
    items.where(text, search: "%#{query}%").distinct
  end

  def text_query_commentary(items, query)
    items = items.left_joins(:commentary_authors, :events, :news_items, :people, :works)
    fields = %w[
      commentaries.name
      commentaries.content
      commentary_authors.name_last
      commentary_authors.name_given
      commentary_authors.short_biography
      events.name
      news_items.article_title
      people.name_last
      people.name_given
      people.name_alt
      works.title
    ]
    text_query(items, fields, query)
  end

  def text_query_event(items, query)
    items = items.left_joins(:location, :people)
    fields = %w[
      name
      summary
      people.name_last
      people.name_given
      people.name_alt
      locations.place
      locations.city
      locations.country
    ]
    text_query(items, fields, query)
  end

  def text_query_news_item(items, query)
    items = items.left_joins(:people, :publisher)
    fields = %w[
      article_title
      excerpt
      summary
      publishers.name
      people.name_last
      people.name_given
      people.name_alt
    ]
    text_query(items, fields, query)
  end

  def text_query_poet(items, query)
    fields = %w[
      name_last
      name_given
      name_alt
      bibliography
      short_biography
    ]
    text_query(items, fields, query)
  end

  def text_query_work(items, query)
    items = items.left_joins(:publisher, :location)
    fields = %w[
      title
      citation
      publishers.name
      locations.place
      locations.city
      locations.country
    ]
    text_query(items, fields, query)
  end

end
