class ContemporarypoetsController < ApplicationController

  def home
    @title = "Contemporary African Poets"
    set_page_facets
  end

  # NOTE being overridden in items_override.rb
  # def browse_facet
  # end

end
