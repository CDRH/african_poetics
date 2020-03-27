class InthenewsController < ApplicationController

  def home
    @title = "African Poets in the News"
  end

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
    @events = Event.joins(:people)
        .where(people: { id: params[:id] })
        .group(:event_type)
        .count
    @works = Work.joins(:people)
        .where(people: { id: params[:id] })
        .joins(:work_type)
        .group("work_types.name")
        .count
  end

  def events
    @title = "Events"
    @event_types = Event.group(:event_type).count
  end

  def news
    @title = "News"
    @news_item_types = NewsItemType
      .joins(:news_items)
      .group(:name)
      .count
  end

  def poets
    @title = "Poets"
    @mock_country = Person
      .joins(:locations)
      .where(locations: { country: "Nigeria" })
      .limit(5)
  end

  def search_events
    @title = "Event Search"
    items = Event.all
    if params[:event_type].present?
      items = items.where(event_type: params[:event_type])
    end
    if params[:person_id].present?
      items = items.joins(:people)
        .where(people: { id: params[:person_id] })
    end
    @items = items.paginate(page: params[:page])
  end

  def search_news_items
    @title = "News Search"
    items = NewsItem.all
    if params[:news_type].present?
      items = items.joins(:news_item_type)
        .where(news_item_types: { name: params[:news_type] })
    end
    if params[:person_id].present?
      items = items.joins(:people)
        .where(people: { id: params[:person_id] })
    end
    @items = items.paginate(page: params[:page])
  end

  def search_poets
    @title = "Poet Search"
    items = Person.poet
    if params[:letter].present?
      items = items.where("name_last LIKE (?)", "#{params[:letter]}%")
    end
    @items = items.paginate(page: params[:page])
  end

end
