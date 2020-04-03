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
  end

  def search_events
    @title = "Event Search"
    items = Event.all
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
  end

  def search_news_items
    @title = "News Search"
    items = NewsItem.all
    if params[:news_type].present?
      items = items.joins(:news_item_type)
        .where(news_item_types: { name: params[:news_type] })
    end
    if params[:person].present?
      @person = Person.find(params[:person])
      items = items.joins(:people)
        .where(people: { id: params[:person] })
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
  end

  def search_works
    @title = "Work Search"
    items = Work.all

    if params[:person].present?
      @person = Person.find(params[:person])
      items = items.joins(:people)
        .where(people: { id: params[:person] })
    end
    if params[:work_type].present?
      items = items.joins(:work_type)
        .where(work_types: { name: params[:work_type] })
    end

    @items = items.paginate(page: params[:page])
  end

end
