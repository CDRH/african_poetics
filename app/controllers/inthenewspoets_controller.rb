class InthenewspoetsController < ItemsController

  def home
    @title = "Poets"
    @facets = @items_api.query({
      "facet" => ["spatial.region"]
    }).facets
  end

  def show
    @item = es_to_db_record("Person", params[:id])
    @title = @item.name

    # get list of news item types (not count)
    # NewsItemType.joins(news_items: :people).where(news_items: { people: { id: 1 }})
    @news_items = NewsItem.joins(:people)
        .where(people: { id: @item.id })
        .joins(:news_item_type)
        .group("news_item_types.name")
        .count
    # TODO will need to redo this if event_type is its own table
    @events = Event.joins(:event_type, :people)
        .where(people: { id: @item.id })
        .group("event_types.name")
        .count
    @works = Work.joins(:people)
        .where(people: { id: @item.id })
        .joins(:work_type)
        .group("work_types.name")
        .count
  end

end
