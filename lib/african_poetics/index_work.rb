class IndexWork < Index

  def record_type
    "work"
  end

  def creator
    # it's a little bit of work to get
    # the authors / poets so do some joining
    all_people = Person
      .joins(work_roles: :role)
      .where(work_roles: { work_id: @record.id })

    # now filter those people to those who are poets / authors
    authors = all_people.where(roles: { name: "Poet" })
      .or(all_people.where(roles: { name: "Author" }))
      .distinct
    if authors
      authors.map do |a|
        {
          name: a.name,
          id: a.id,
          role: "Author"
        }
      end
    end
  end

  def date
    date_normalize(@record.year)
  end

  def date_not_after
    date_normalize(@record.year, before: false)
  end

  def date_not_before
    date
  end

  def date_display
    @record.year
  end

  def description
    @record.citation
  end

  # TODO
  def places
  end

  def publisher
    @record.publisher.name if @record.publisher
  end

  def type
    @record.work_type.name if @record.work_type
  end

end
