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
    @skip_fields = ["topics", "type"]
  end

end
