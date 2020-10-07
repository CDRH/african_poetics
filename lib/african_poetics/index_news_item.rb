class IndexNewsItem < Index

  def record_type
    "news"
  end

  def creator
    @record.authors.map do |a|
      {
        "name" => a.person.name,
        "id" => a.id,
        "role" => "Creator"
      }
    end
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

  # NOTE this field is for the poet in the news item
  def person
    poets = @record.people
      .includes(:news_item_roles)
      .where(news_item_roles: { role: Role.find_by(name: "Poet") })
      .distinct
    poets.map do |author|
      {
        "name" => author.name,
        "role" => "Poet",
        "id" => author.id
      }
    end
  end

  def places
    if @record.publisher && @record.publisher.location
      @record.publisher.location.name
    end
  end

  def publisher
    @record.publisher.name if @record.publisher
  end

  def source
    @record.source_link
  end

  def text_additional
    [
      @record.excerpt
    ]
  end

  def type
    @record.news_item_type.name if @record.news_item_type
  end

  def works
    @record.works.map { |w| w.name }
  end


end
