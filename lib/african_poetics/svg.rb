module Svg

  def self.assign_class(element, id_to_assign=nil)
    id = id_to_assign || element["id"]
    region = @code_to_region[id]
    if region.present?
      if element["class"]
        element["class"] += " #{region}"
      else
        element["class"] = region
      end
    else
      # debug line for investigating more region matches
      # puts "no region found matching #{id}"
    end
  end

  def self.modify_map
    yml_path = File.join(Rails.root, "config", "data", "countries.yml")
    svg_path = File.join(Rails.root, "lib", "assets", "africa_map.svg")
    out_path = File.join(Rails.root, "lib", "assets", "africa_map_regions.svg")

    # create an object from countries.yml mapping
    # for lowercase code to region to simplify lookup

    country_mapping = YAML.load_file(yml_path)["countries"]
    @code_to_region = {}
    country_mapping.each do |country, info|
      if info["code"] && info["region"]
        @code_to_region[info["code"].downcase] = info["region"].sub(" ", "_")
      else
        puts "didn't find a mapping for #{country}"
      end
    end

    # read in the fresh copy of the svg
    contents = File.read(svg_path)
    xml = Nokogiri::XML(contents).remove_namespaces!

    # put the class on not just the group itself
    # but all of the paths inside of it which do not have the id
    xml.xpath("//g").each do |group|
      group_id = group["id"]
      # if there is an id, iterate through all the paths
      if group_id && @code_to_region[group_id]
        assign_class(group)
        group.xpath("path").each do |path|
          assign_class(path, group_id)
        end
      end
    end

    # try to assign a region to all paths which have an id of their own
    xml.xpath("//path").each do |path|
      assign_class(path)
    end

    # write result to a different file to allow multiple runs
    File.open(out_path, "w") { |f| f.write(xml.to_xml) }
  end

end
