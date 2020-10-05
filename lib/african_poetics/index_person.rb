class IndexPerson < Index

  def record_type
    "person"
  end

  private

  # using birthday for now
  def date
    date_normalize(@record.date_birth)
  end

  def date_display
    date_display_format(date)
  end

  def date_not_before
    date_normalize(@record.date_birth)
  end

  def date_not_after
    date_normalize(@record.date_death, before: false)
  end

  def description
    @record.short_biography
  end

  def person
    [
      {
        "id" => @id,
        "name" => title,
        "role" => "Self"
      }
    ]
  end

  def places
    # use nationalities currently
    @record.nationalities

    # TODO should we also be including birthplace, education, nationality, etc?
  end

  def source
    # using news item article titles for now, not sure this is ideal
    @record.news_items.map { |n| n.name }
  end

  def spatial
    if @record.regions
      # TODO should probably put full locations here
      # but only using regions for speed's sake
      @record.regions.map { |r| { "region" => r.name } }
    else
      []
    end
  end

  def subcategory
    if @record.major_african_poet
      "Person (Poet)"
    else
      "Person (Non-Poet)"
    end
  end

  def text_additional
    # education?
    [
      source,
      works
    ]
  end

  def topics
    @record.regions.map { |r| r.name }
  end

  def works
    @record.works.map { |w| w.name }
  end

end
