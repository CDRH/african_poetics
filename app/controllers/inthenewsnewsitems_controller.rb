class InthenewsnewsitemsController < ItemsController

  def home
    @title = "News"
    @facets = @items_api.query({
      "facet" => [
        "keywords",
        "type"
      ],
      "facet_sort" => "term|asc",
      "facet_num" => 600
    }).facets
    set_page_facets
    @skip_fields = ["keywords", "type"]
  end

end
