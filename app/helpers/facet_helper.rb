module FacetHelper
  include Orchid::FacetHelper
  # type: type of facet (category, format, etc)
  # normalized: the normalized value ("willa cather", "Yellowstone Kelly")
  #     used for URL creation and translation matching
  # label: non normalized value ("Willa Cather", '"Yellowstone Kelly"')
  def facet_label(type: nil, normalized: nil, label: nil)
    # if @page_facets are not present, for example if a search_preset
    # view or a custom action are using the metadata method,
    # do not error but just skip possible translations
    if @page_facets.present?
      # determine if translation needed
      info = @page_facets[type]
      if info && info["flags"] && info["flags"].include?("translate")
        # do not need "label" since that will be found in the locale info
        facet_label_translation(type: type, normalized: normalized)
      else
        # if there is no label specified, use the normalized version
        sanitize(parse_md_brackets(label)) || normalized
      end
    else
      label
    end
  end

end