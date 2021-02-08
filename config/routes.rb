Rails.application.routes.draw do

  with_period = /[^\/]+/
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/country", to: "general#country", as: "country"

  scope "/contemporarypoets" do
    get "/", to: "contemporarypoets#home", as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    get "/about", to: "contemporarypoets#about",
      as: "contemporarypoets_about", defaults: { section: "contemporarypoets" }

    get "/about/consultedsources", to: "contemporarypoets#about_consultedsources",
      as: "contemporarypoets_about_consultedsources", defaults: { section: "contemporarypoets" }

    get "/about/criteria", to: "contemporarypoets#about_criteria",
      as: "contemporarypoets_about_criteria", defaults: { section: "contemporarypoets" }

    Orchid::Routing.draw(section: "contemporarypoets",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/contemporarypoets")
  end

  scope "/inthenews" do

    get "/", to: "inthenews#home", as: :inthenews_home,
      defaults: { section: "inthenews" }
    get "/about", to: "inthenews#about", as: :inthenews_about,
      defaults: { section: "inthenews" }
    get "/about/credits", to: "inthenews#about_credits",
      as: "inthenews_about_credits", defaults: { section: "inthenews" }

    # commentaries
    Orchid::Routing.draw(section: "inthenews_commentaries",
      routes: ["browse", "browse_facet", "search"], scope: "/inthenews/commentaries")
    get "/commentaries", to: "inthenewscommentaries#home", as: :inthenews_commentaries,
      defaults: { section: "inthenews_commentaries" }
    get "/commentaries/:id", to: "inthenewscommentaries#show", as: :inthenews_commentaries_item,
      defaults: { section: "inthenews_commentaries" }, constraints: { id: with_period }

    # events
    Orchid::Routing.draw(section: "inthenews_events",
      routes: ["browse", "browse_facet", "search"], scope: "/inthenews/events")
    get "/events", to: "inthenewsevents#home", as: :inthenews_events,
      defaults: { section: "inthenews_events" }
    get "/events/:id", to: "inthenewsevents#show", as: :inthenews_events_item,
      defaults: { section: "inthenews_events" }, constraints: { id: with_period }

    # news items
    Orchid::Routing.draw(section: "inthenews_news_items",
      routes: ["browse", "browse_facet", "search"], scope: "/inthenews/news")
    get "/news", to: "inthenewsnewsitems#home", as: :inthenews_news_items,
      defaults: { section: "inthenews_news_items" }
    get "/news/:id", to: "inthenewsnewsitems#show", as: :inthenews_news_items_item,
      defaults: { section: "inthenews_news_items" }, constraints: { id: with_period }

    # poets
    Orchid::Routing.draw(section: "inthenews_poets",
      routes: ["browse", "browse_facet", "search"], scope: "/inthenews/poets")
    get "/poets", to: "inthenewspoets#home", as: :inthenews_poets,
      defaults: { section: "inthenews_poets" }
    get "/poets/:id", to: "inthenewspoets#show", as: :inthenews_poets_item,
      defaults: { section: "inthenews_poets" }, constraints: { id: with_period }

    # works
    Orchid::Routing.draw(section: "inthenews_works",
      routes: ["browse", "browse_facet", "search"], scope: "/inthenews/works")
    get "/works", to: "inthenewsworks#home", as: :inthenews_works,
      defaults: { section: "inthenews_works" }
    get "/works/:id", to: "inthenewsworks#show", as: :inthenews_works_item,
      defaults: { section: "inthenews_works" }, constraints: { id: with_period }

    # leftover from the wireframes but not actually used
    get "/relationships", to: "inthenews#relationships", as: :inthenews_relationships,
      defaults: { section: "inthenews" }

  end

  scope "/about" do
    get "/", to: "about#home",
      as: "about_home", defaults: { section: "about" }
    get "/credits", to: "about#credits",
      as: "about_credits", defaults: { section: "about" }
    get "/africanpoetrybookfund", to: "about#africanpoetrybookfund",
      as:  "about_africanpoetrybookfund", defaults: { section: "about" }
    get "/technicaldetails", to: "about#technicaldetails",
      as:  "about_technicaldetails", defaults: { section: "about" }

  end

end
