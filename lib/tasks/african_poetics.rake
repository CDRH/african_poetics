require "african_poetics/svg"

namespace :african_poetics do

  desc "Modifies an SVG with countries of Africa to carry regional information instead"
  task region_map: :environment do
    Svg.modify_map
  end

end
