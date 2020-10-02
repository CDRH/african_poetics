# these are the default fields shared by all the index types
#
# for the most part they do not have default values

module Fields

  def alternative
  end

  def annotations_text
  end

  def category
    "In the News"
  end

  # nested field
  def creator
    []
  end

  def collection
    "african_poetics"
  end

  def collection_desc
  end

  # nested field
  def contributor
    []
  end

  def data_type
    "database"
  end

  def date
  end

  def date_display
  end

  def date_not_after
  end

  def date_not_before
  end

  def description
  end

  def extent
  end

  def format
  end

  def identifier
    @id
  end

  def image_id
  end

  def keywords
  end

  def language
  end

  def languages
  end

  def medium
  end

  # nested field
  def person
    []
    # eles = get_elements(@xpaths["person"]).map do |p|
    #   {
    #     "id" => get_text("@id", xml: p),
    #     "name" => get_text(".", xml: p),
    #     "role" => get_text("@role", xml: p)
    #   }
    # end
    # eles.uniq
  end

  def places
  end

  def publisher
  end

  # nested field
  def recipient
    []
  end

  def relation
  end

  # TODO need to look into rights / license statement
  def rights
  end

  def rights_holder
  end

  def rights_uri
  end

  def source
  end

  # nested field
  def spatial
  end

  def subjects
  end

  def subcategory
    @record_type
  end

  def text
    primary_text = [
      title,
      description,
    ]
    all_text = primary_text + text_additional
    all_text.compact.join(" ")
  end

  def text_additional
    []
  end

  def title
  end

  def title_sort
    # TODO
  end

  # USING FOR DECADE
  def topics
    if date && date[/^\d{4}/]
      year = date[/^\d{4}/]
      year.to_i - (year.to_i % 10)
    end
  end

  def type
  end

  def uri
    # TODO
  end

  def uri_data
    # TODO
  end

  def uri_html
  end

  def works
  end

end