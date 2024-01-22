ItemsController.class_eval do

  helper_method :db_to_es_id, :es_to_db_record

  # NOTE below method is entirely the same as the default except
  # for "if @browse_facet == 'featured' if / else"
  def browse_facet
    # Reverse facet name from url-formatting
    @browse_facet = params[:facet]
    if @browse_facet.include?(".")
      @page_facets.each_with_index do |(facet_name, facet_info), index|
        if @browse_facet == facet_name.parameterize(separator: ".")
          @browse_facet = facet_name
          break
        end
      end
    end

    # Get selected facet's info
    if @section == "index_of_poets" && @browse_facet.include?("person.name_")
      @browse_facet = "person.name"
    end
    @browse_facet_info = @page_facets[@browse_facet]
    if @browse_facet_info.blank?
      redirect_to browse_path, notice: t("errors.browse",
        facet: @browse_facet, default: "Cannot browse by key: '#{@browse_facet}'")
      return
    end

    sort_by = params["facet_sort"].present? ?
      params["facet_sort"] : API_OPTS["browse_sort"]

    options = {
      facet: @browse_facet,
      facet_num: 10000,
      facet_sort: sort_by,
      num: 0
    }
    if @browse_facet == "featured"
      @title = "#{t "browse.browse_type"} #{@browse_facet_info["label"]}"
      render "index_of_poets/featured"
    else
      # Get facet results
      @res = @items_api.query(options).facets
      # Warn when approaching facet result limit
      result_size = @res.length
      if result_size == 10000
        raise {"Facet results list has hit the limit of 10000. Revisit facet
          result handling NOW"}
      elsif result_size >= 9000
        logger.warn {"Facet results list has surpassed 9000 of 10000 limit. Please
          revisit facet result handling SOON"}
      elsif result_size >= 7500
        logger.warn {"Facet results list has surpassed 7500 of 10000 limit. Please
          revisit facet result handling soon"}
      end

      @title = "#{t "browse.browse_type"} #{@browse_facet_info["label"]}"
      render_overridable("items", "browse_facet", locals: { sort_by: sort_by })
    end
  end

  def item_retrieve(id)
    if @section
      type = @section.gsub("inthenews", "")
      # make sure that items or only rendering in the proper section, otherwise show not found
      if type == "poets" || type == "index_of_poets"
        type = "person"
      elsif type == "newsitems"
        type = "news"
      elsif type == "events"
        type = "event"
      elsif type == "works"
        type = "work"
      elsif type == "commentaries"
        type = "commentary"
      end
      if !(id.include?(type))
        @title = t "item.no_item", id: id,
          default: "No item with identifier #{id} found!"
        render_overridable("items", "show_not_found", status: 404)
        return
      end
    end
    @res = @items_api.get_item_by_id(id)
    # check_response #note: does not work here
    @res = @res.first
    if @res
      url = @res["uri_html"]
      @html = Net::HTTP.get(URI.parse(url)) if url
      @title = item_title

      render_overridable("items", "show")
    else
      @title = t "item.no_item", id: id,
        default: "No item with identifier #{id} found!"
      render_overridable("items", "show_not_found", status: 404)
    end
  end


  private

  def check_response
    if @res.blank? || @res.error
      flash[:error] = t "errors.api"
    end
  end

  def db_to_es_id(category, id)
    "ap.#{category}.#{id}"
  end

end
