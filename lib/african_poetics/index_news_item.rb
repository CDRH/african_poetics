class IndexNewsItem < Index

  def record_type
    "news"
  end

  def creator
    # TODO
  end

  def date
    date_standardize(@record.date)
  end

  def date_not_after
    date_standardize(@record.date, before: false)
  end

  def date_not_before
    date
  end

  def description
    @record.summary
  end

  def person
    # TODO
  end

  def places
    # TODO from publisher location?
  end

  def publisher
    @record.publisher.name
  end

  def source
    @record.source_link
  end

  def text_additional
    [
      @record.excerpt
    ]
  end

  def works
    @record.works.map { |w| w.name }
  end


end
