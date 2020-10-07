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
  end

end
