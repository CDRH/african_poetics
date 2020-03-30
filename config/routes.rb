Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/country", to: "general#country", as: "country"

  scope "/contemporarypoets" do
    get "/", to: "contemporarypoets#home", as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    get "/about", to: "contemporarypoets#about",
      as: "contemporarypoets_about", defaults: { section: "contemporarypoets" }

    get "/about/consultedsources", to: "contemporarypoets#about_consultedsources",
      as: "contemporarypoets_about_consultedsources", defaults: { section: "contemporarypoets" }

    Orchid::Routing.draw(section: "contemporarypoets",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/contemporarypoets")
  end

  scope "/inthenews" do
    get "/", to: "inthenews#home", as: :inthenews_home,
      defaults: { section: "inthenews" }
    get "/about", to: "inthenews#about", as: :inthenews_about,
      defaults: { section: "inthenews" }

    # events
    get "/events", to: "inthenews#events", as: :inthenews_events,
      defaults: { section: "inthenews" }
    get "/events/search", to: "inthenews#search_events", as: :inthenews_search_events,
      defaults: { section: "inthenews" }
    get "/events/:id", to: "inthenews#event", as: :inthenews_event,
      defaults: { section: "inthenews" }

    # news items
    get "/news", to: "inthenews#news_items", as: :inthenews_news_items,
      defaults: { section: "inthenews" }
    get "/news/search", to: "inthenews#search_news_items", as: :inthenews_search_news_items,
      defaults: { section: "inthenews" }
    get "/news/:id", to: "inthenews#news_item", as: :inthenews_news_item,
      defaults: { section: "inthenews" }

    # poets
    get "/poets", to: "inthenews#poets", as: :inthenews_poets,
      defaults: { section: "inthenews" }
    get "/poets/search", to: "inthenews#search_poets", as: :inthenews_search_poets,
      defaults: { section: "inthenews" }
    get "/poets/:id", to: "inthenews#poet", as: :inthenews_poet,
      defaults: { section: "inthenews" }

    get "/relationships", to: "inthenews#relationships", as: :inthenews_relationships,
      defaults: { section: "inthenews" }

    # Orchid::Routing.draw(section: "inthenews",
    #   routes: ["browse", "browse_facet", "search"], scope: "/inthenews")
  end

  scope "/about" do
    get "/", to: "about#homeabout",
      as: "about_homeabout", defaults: { section: "about" }
    get "/africanpoetrybookfund", to: "about#africanpoetrybookfund",
      as:  "about_africanpoetrybookfund", defaults: { section: "about" }
    get "/technicaldetails", to: "about#technicaldetails",
      as:  "about_technicaldetails", defaults: { section: "about" }

  end



end
