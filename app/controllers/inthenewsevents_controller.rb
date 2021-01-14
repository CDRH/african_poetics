class InthenewseventsController < ItemsController

  def home
    @title = "Events"
    @facets = @items_api.query({
      "facet" => [
        "spatial.region",
        "topics"  # decade
      ],
      "facet_sort" => "term|asc",
      "facet_num" => 50
    }).facets

    set_page_facets
    # remove decade browse
    @page_facets.delete("topics")
  end

  def show
    @item = es_to_db_record("Event", params[:id])
    @title = @item.name
  end

end
