class InthenewsworksController < ItemsController

  def home
    @title = "Works"
    @facets = @items_api.query({
      "facet" => [
        "spatial.region",
        "topics",
        "type"
      ]
    }).facets
  end

  def show
    @item = es_to_db_record("Work", params[:id])
    @title = @item.name
  end

end
