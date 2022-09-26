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

  def show
    id = params["id"]
    @res = @items_api.get_item_by_id(id)
    @res = @res.first
    if @res
      url = @res["uri_html"]
      @html = Net::HTTP.get(URI.parse(url)) if url
      @title = item_title

      render_overridable("inthenewsevents", "show")
    else
      @title = t "item.no_item", id: id,
        default: "No item with identifier #{id} found!"
      render_overridable("items", "show_not_found", status: 404)
    end
  end

end
