class InthenewscommentariesController < ItemsController

  def home
    @title = "Commentaries"
    @facets = @items_api.query({
      "facet" => [
        "creator.name", 
        "keywords",
        "subjects",
        "person.name",
        "citation.title"
      ]
    }).facets

    set_page_facets
    @skip_fields = []
  end

end
