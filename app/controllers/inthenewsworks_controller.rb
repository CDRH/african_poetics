class InthenewsworksController < ItemsController

  def home
    @title = "Works"
    @facets = @items_api.query({
      "facet" => [
        "topics",
        "type",
      ],
      "facet_sort" => "term|asc"
    }).facets

    set_page_facets
    # remove decade browse
    @page_facets.delete("topics")
    @page_facets.delete("type")
  end

  def show
    @item = es_to_db_record("Work", params[:id])
    @title = @item.name
  end

end
