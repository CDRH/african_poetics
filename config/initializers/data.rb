# this file collects the country and region information
# for display on the map pages

yml_path = File.join(Rails.root, "config", "data", "countries.yml")

begin
  COUNTRIES = YAML.load_file(yml_path, aliases: true)["countries"]
  
  # TODO remove or alter this when we are no longer supporting originally
  # proof of concept map
  codes = {}
  COUNTRIES.each do |country, info|
    codes[country] = info["code"]
  end
  COUNTRY_CODES = codes

rescue => e
  puts "something went wrong loading the countries.yml file: #{e}"
end
