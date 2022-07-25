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

  def show
    id = params["id"]
    @res = @items_api.get_item_by_id(id)
    @res = @res.first
    if @res
      url = @res["uri_html"]
      @html = Net::HTTP.get(URI.parse(url)) if url
      @title = item_title

      render_overridable("inthenewsworks", "show")
    else
      @title = t "item.no_item", id: id,
        default: "No item with identifier #{id} found!"
      render_overridable("items", "show_not_found", status: 404)
    end
  end

end
