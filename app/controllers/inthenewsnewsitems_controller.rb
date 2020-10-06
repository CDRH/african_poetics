class InthenewsnewsitemsController < ItemsController

  def home
    @title = "News"
    @facets = @items_api.query({
      "facet" => [
        "topics", 
        "type"
      ]
    }).facets
  end

  def show
    @item = es_to_db_record("NewsItem", params[:id])
    @title = @item.name
  end

end
