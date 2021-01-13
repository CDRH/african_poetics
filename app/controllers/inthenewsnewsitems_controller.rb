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
  end

  def show
    @record = es_to_db_record("NewsItem", params[:id])
    @title = @record.name
  end

end
