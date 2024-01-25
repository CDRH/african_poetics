def transliterate(name)
  # remove diacritics from name
  ActiveSupport::Inflector.transliterate(name)
end
# standard api query for all Index of Poets names
sort_by = API_OPTS["browse_sort"]
options = {
  facet: "person.name",
  facet_num: 1000,
  facet_sort: sort_by,
  num: 0,
  f: ["subcategory|Index of Poets"]
}
res = $api.query(options).facets
# sort poets alphabetically, note that Elasticsearch order needs to be corrected for case and diacritics
# split into three categories for the sake of sorting
POETS_AG = { "person.name" => res["person.name"].select { |name| transliterate(name).downcase < "h" }.sort_by { |p| transliterate(p[0]).downcase }}
POETS_HM = { "person.name" => res["person.name"].select { |name| transliterate(name).downcase >= "h" && transliterate(name).downcase < "n" }.sort_by { |p| transliterate(p[0]).downcase }}
POETS_NZ = { "person.name" => res["person.name"].select { |name| transliterate(name).downcase >= "n" }.sort_by { |p| transliterate(p[0]).downcase }}
