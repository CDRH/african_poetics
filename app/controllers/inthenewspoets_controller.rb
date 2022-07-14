class InthenewspoetsController < ItemsController

  def home
    @title = "Poets"
    @facets = @items_api.query({
      "facet" => [
        "alternative",
        "spatial.region"
      ],
      "facet_sort" => "term|asc",
      "facet_num" => 30
    }).facets

    set_page_facets
    @skip_fields = ["alternative", "spatial.region"]
  end

  def show
    # @item = es_to_db_record("Person", params[:id])
    # @title = @item.name
  end

end
