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
    @skip_fields = ["spatial.region", "topics"]
  end

end
