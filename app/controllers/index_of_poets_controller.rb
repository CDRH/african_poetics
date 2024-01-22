class IndexOfPoetsController < ApplicationController

  def about
    @title = "About"
  end

  def about_consultedsources
    @title = "Consulted Sources"
  end

  def about_criteria
    @title = "Selection Criteria"
  end

  def home
    @title = "Index of Poets"
  end

  # NOTE being overridden in items_override.rb
  # def browse_facet
  # end

end
