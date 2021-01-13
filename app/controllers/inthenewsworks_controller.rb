class InthenewsworksController < ItemsController

  def home
    @title = "Works"
    @facets = @items_api.query({
      "facet" => [
        "topics",
      ],
      "facet_sort" => "term|asc"
    }).facets

    set_page_facets

  end

  def show
    @item = es_to_db_record("Work", params[:id])
    @title = @item.name
  end

end
