module FacetHelper
  include Orchid::FacetHelper

  def value_label field, value
    # if @page_facets are not present, for example if a search_preset
    # view or a custom action are using the metadata method,
    # do not error but just skip possible translations
    if @page_facets.present?
      info = @page_facets[field]
      if value.present? && info && info["flags"] \
        && info["flags"].include?("translate")
        field_name = field.gsub(".", "_")
        # if this is a list of values, we need to return a list as well
        subs = /[\., ]/
        if value.class == Array
          value.compact.map do |v|
            v = v.gsub(subs, "_")
            t "facet_value.#{field_name}.#{v}", default: v
          end
        else
          value_name = value.gsub(subs, "_")
          t "facet_value.#{field_name}.#{value_name}", default: value
        end
      else
        # check if value is markdown, if so show title only
        parse_md_brackets(value)
      end
    else
      value
    end
  end
end
