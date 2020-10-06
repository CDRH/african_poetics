ItemsController.class_eval do

  helper_method :es_to_db_record

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
      render "contemporarypoets/featured"
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

  private

  def es_to_db_record(model, es_id)
    db_id = es_id[/ap\.\w*\.(\d*)/,1]
    model.constantize.find(db_id)
  end

end
