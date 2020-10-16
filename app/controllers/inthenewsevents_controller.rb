class InthenewseventsController < ItemsController

  def home
    @title = "Events"
    @facets = @items_api.query({
      "facet" => [
        "spatial.region",
      ]
    }).facets
  end

  def show
    @item = es_to_db_record("Event", params[:id])
    @title = @item.name
  end

end
