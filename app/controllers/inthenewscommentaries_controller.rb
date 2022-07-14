class InthenewscommentariesController < ItemsController

  def home
    @title = "Commentaries"
    @facets = @items_api.query({
      "facet" => [
        "creator.name", 
        "keywords",
        "subjects",
        "person.name",
        "works"
      ]
    }).facets

    set_page_facets
    # @featured = Commentary.featured.sample
    @skip_fields = []
  end

  def show
    # @item = es_to_db_record("Commentary", params[:id])
    # @title = @item.name
  end

end
