class InthenewsController < ApplicationController

  def home
    @title = "African Poets in the News"
  end

  ################
  # COMMENTARIES #
  ################

  def commentary
    @item = Commentary.find(params[:id])
    @title = @item.name
  end

  def commentaries
    @title = "Commentaries"
    @poets = Person.poet.joins(:commentaries)
      .group("name_last", "name_given")
      .count
  end

  def search_commentaries
    @title = "Commentary Search"
    items = Commentary.all
    if params[:person].present?
      last, given = params[:person]
      @person = Person.find_by(name_last: last, name_given: given)
      items = items.joins(:people)
        .where(people: {
            name_last: last, name_given: given
        })
    end
    if params[:q].present?
      items = text_query_commentary(items, params[:q])
    end
    @items = items.paginate(page: params[:page])
  end

  private

  def text_query(items, fields, query)
    text = fields.join(" LIKE :search OR ")
    text += " LIKE :search"
    items.where(text, search: "%#{query}%").distinct
  end

  def text_query_commentary(items, query)
    items = items.left_joins(:commentary_authors, :events, :news_items, :people, :works)
    fields = %w[
      commentaries.name
      commentaries.content
      commentary_authors.name_last
      commentary_authors.name_given
      commentary_authors.short_biography
      events.name
      news_items.article_title
      people.name_last
      people.name_given
      people.name_alt
      works.title
    ]
    text_query(items, fields, query)
  end

end
